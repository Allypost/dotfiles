#!/usr/bin/env python3

"""
Keeps windows on-screen by snapping them back in-bounds when they
drift off-screen. Designed for Hyprland on multi-monitor setups
where XWayland/Proton games place windows at incorrect coordinates.

Usage: keep-windows-on-screen.py [--verbose]

Events listened to (from socket2.sock):
  openwindow, windowtitle, windowtitlev2, fullscreen,
  changefloatingmode, monitoradded/removed, moveworkspace,
  configreloaded

Polling fallback:
  0.5s normally, 0.1s for the first 5s after a new window opens.
"""

import json
import os
import select
import signal
import socket
import subprocess
import sys
import time

POLL_INTERVAL = 0.5
AGGRESSIVE_POLL = 0.1
AGGRESSIVE_TTL = 5.0
EVENT_SETTLE = 0.05
VIS_THRESHOLD = 0.10
MIN_SIZE = 50

WATCHED_EVENTS = frozenset(
    {
        "openwindow",
        "windowtitle",
        "windowtitlev2",
        "fullscreen",
        "changefloatingmode",
        "monitoradded",
        "monitoraddedv2",
        "monitorremoved",
        "monitorremovedv2",
        "moveworkspace",
        "moveworkspacev2",
        "configreloaded",
    }
)

_running = True


def _quit(_sig, _frame):
    global _running
    _running = False


signal.signal(signal.SIGINT, _quit)
signal.signal(signal.SIGTERM, _quit)


# ---------------------------------------------------------------------------
# hyprctl helpers
# ---------------------------------------------------------------------------


def _hyprctl_json(cmd):
    try:
        r = subprocess.run(
            ["hyprctl", cmd, "-j"],
            capture_output=True,
            text=True,
            timeout=2,
        )
        if r.returncode == 0:
            return json.loads(r.stdout)
    except (subprocess.TimeoutExpired, json.JSONDecodeError, FileNotFoundError):
        pass
    return None


def _hyprctl_dispatch(*args):
    try:
        subprocess.run(
            ["hyprctl", "dispatch", *args],
            capture_output=True,
            text=True,
            timeout=2,
        )
    except (subprocess.TimeoutExpired, FileNotFoundError):
        pass


def _monitors():
    data = _hyprctl_json("monitors")
    if not data:
        return []
    return [{"x": m["x"], "y": m["y"], "w": m["width"], "h": m["height"]} for m in data]


def _windows():
    data = _hyprctl_json("clients")
    if not data:
        return []
    out = []
    for c in data:
        if not c.get("mapped"):
            continue
        at = c.get("at", [0, 0])
        sz = c.get("size", [0, 0])
        if sz[0] < MIN_SIZE or sz[1] < MIN_SIZE:
            continue
        out.append(
            {
                "a": c.get("address", ""),
                "x": at[0],
                "y": at[1],
                "w": sz[0],
                "h": sz[1],
                "cls": c.get("class", ""),
                "ttl": c.get("title", ""),
            }
        )
    return out


# ---------------------------------------------------------------------------
# geometry
# ---------------------------------------------------------------------------


def _clamp(v, lo, hi):
    return max(lo, min(v, hi))


def _overlap_area(ax, ay, aw, ah, bx, by, bw, bh):
    ox = max(0, min(ax + aw, bx + bw) - max(ax, bx))
    oy = max(0, min(ay + ah, by + bh) - max(ay, by))
    return ox * oy


def _visibility(wx, wy, ww, wh, mons):
    area = ww * wh
    if area <= 0:
        return 0.0
    vis = sum(
        _overlap_area(wx, wy, ww, wh, m["x"], m["y"], m["w"], m["h"]) for m in mons
    )
    return min(1.0, vis / area)


def _snap_pos(wx, wy, ww, wh, mons):
    best_d = float("inf")
    bx, by = 0, 0
    for m in mons:
        nx = _clamp(wx, m["x"], max(m["x"], m["x"] + m["w"] - ww))
        ny = _clamp(wy, m["y"], max(m["y"], m["y"] + m["h"] - wh))
        d = (nx - wx) ** 2 + (ny - wy) ** 2
        if d < best_d:
            best_d = d
            bx, by = nx, ny
    return bx, by


# ---------------------------------------------------------------------------
# event socket
# ---------------------------------------------------------------------------


def _open_socket():
    sig = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE", "")
    rdir = os.environ.get("XDG_RUNTIME_DIR", f"/run/user/{os.getuid()}")
    path = f"{rdir}/hypr/{sig}/.socket2.sock"
    try:
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.connect(path)
        s.setblocking(False)
        return s
    except (FileNotFoundError, ConnectionRefusedError, OSError):
        return None


def _drain(sock):
    hit = False
    new_addr = None
    try:
        while True:
            buf = sock.recv(8192)
            if not buf:
                break
            for line in buf.decode("utf-8", errors="replace").splitlines():
                if ">>" not in line:
                    continue
                ev, rest = line.split(">>", 1)
                if ev in WATCHED_EVENTS:
                    hit = True
                if ev == "openwindow":
                    parts = rest.split(",", 3)
                    if parts:
                        new_addr = parts[0]
    except BlockingIOError:
        pass
    except OSError:
        pass
    return hit, new_addr


# ---------------------------------------------------------------------------
# main loop
# ---------------------------------------------------------------------------


def main():
    verbose = "--verbose" in sys.argv or "-v" in sys.argv
    if "--help" in sys.argv or "-h" in sys.argv:
        print("Usage: keep-windows-on-screen.py [--verbose]")
        print()
        print("Snaps off-screen windows back to the nearest in-bounds position.")
        print("Runs continuously. Designed for Hyprland multi-monitor setups.")
        sys.exit(0)

    mons = _monitors()
    if verbose:
        for i, m in enumerate(mons):
            print(f"  mon{i}: ({m['x']},{m['y']}) {m['w']}x{m['h']}")

    sock = _open_socket()
    if verbose:
        print("  socket: " + ("ok" if sock else "unavailable"))

    recent = {}
    last_poll = 0.0

    while _running:
        now = time.monotonic()

        ev_hit, new_addr = _drain(sock) if sock else (False, None)
        if new_addr:
            recent[new_addr] = now
            if verbose:
                print(f"  new: {new_addr}")

        expired = [a for a, t in recent.items() if now - t > AGGRESSIVE_TTL]
        for a in expired:
            del recent[a]

        aggressive = bool(recent)
        interval = AGGRESSIVE_POLL if aggressive else POLL_INTERVAL

        if not ev_hit and (now - last_poll) < interval:
            wait = interval - (now - last_poll)
            if sock:
                try:
                    sel, _, _ = select.select([sock], [], [], wait)
                    if sel:
                        _, na = _drain(sock)
                        if na:
                            recent[na] = time.monotonic()
                except (OSError, ValueError):
                    sock = _open_socket()
            else:
                time.sleep(wait)
            continue

        if ev_hit:
            time.sleep(EVENT_SETTLE)

        mons = _monitors()
        wins = _windows()

        for w in wins:
            wx, wy, ww, wh = w["x"], w["y"], w["w"], w["h"]
            if _visibility(wx, wy, ww, wh, mons) >= VIS_THRESHOLD:
                continue

            nx, ny = _snap_pos(wx, wy, ww, wh, mons)
            if nx == wx and ny == wy:
                continue

            _hyprctl_dispatch("movewindowpixel", f"exact {nx} {ny},address:{w['a']}")

            if verbose:
                lbl = w.get("cls") or w.get("ttl") or w["a"]
                print(f"  snap '{lbl}' ({wx},{wy})->({nx},{ny})")

            recent[w["a"]] = time.monotonic()

        last_poll = time.monotonic()


if __name__ == "__main__":
    main()
