#!/usr/bin/env bash

function run() {
	if ! pgrep -f "$1"; then
		$@ >"/tmp/bspwm.autorun.$(echo $@ | tr '/' '__')" &
	fi
}

function set_minimum_backlight_brigtness() {
	command -v light >/dev/null && light -N 0.01
}

function set_auto_lock_handler() {
	xss-lock -l -- multilockscreen --lock blur
}

function apply_xrandr_screen_settings() {
	SCRIPT_DIR="$HOME/.screenlayout"
	SCRIPT="ltr.sh"

	N_MONITORS="$(xrandr | grep ' connected' | grep -c '^DP-')"

	if [ "$N_MONITORS" -gt 2 ]; then
		SCRIPT="ltr-no-laptop.sh"
	fi

	if [ -f "$SCRIPT_DIR/mon-$N_MONITORS.sh" ]; then
		SCRIPT="mon-$N_MONITORS.sh"
	fi

	if [ -f "$SCRIPT_DIR/defalt.sh" ]; then
		SCRIPT="defalt.sh"
	fi

	SCRIPT="$SCRIPT_DIR/$SCRIPT"
	if [ -f "$SCRIPT" ]; then
		. "$SCRIPT"
	fi
}

function run_auth_agents() {
	if [ ! -f '/usr/lib/polkit-kde-authentication-agent-1' ]; then
		return 1
	fi

	/usr/lib/polkit-kde-authentication-agent-1 &
	eval "$(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)"
}

function set_desktop_wallpaper() {
	if ! command -v nitrogen >/dev/null; then
		return 1
	fi

	until nitrogen --restore; do
		continue
	done
}

function set_hid_libinput_settings() {
	for id in $(xinput list --short | grep -E '^⎜\s+↳' | perl -n -e'/id=(\d+)/ && print "$1\n"'); do
		xinput set-prop "$id" 'libinput Accel Speed' 0.4 &>/dev/null
		xinput set-prop "$id" 'libinput Accel Profile Enabled' 0 1 &>/dev/null
	done

	for touchpad_id in $(xinput list --short | grep -E '^⎜\s+↳' | grep -i ' touchpad' | perl -n -e'/id=(\d+)/ && print "$1\n"'); do
		xinput set-prop "$touchpad_id" 'libinput Tapping Enabled' 1 &>/dev/null
		xinput set-prop "$touchpad_id" 'libinput Natural Scrolling Enabled' 1
	done
}

function run_user_autostart() {
	if ! command -v xrdb &>/dev/null; then
		return 1
	fi

	if ! command -v dex &>/dev/null; then
		return 1
	fi

	if (xrdb -query | grep -q '^bspwm\.autostart\.done:\s*true$'); then
		return 0
	fi

	xrdb -merge <<<"bspwm.autostart.done:true"
	dex --environment bspwm --autostart
}

######### RUN EVERY TIME

run_user_autostart &
apply_xrandr_screen_settings &
run_auth_agents &
set_desktop_wallpaper &
set_hid_libinput_settings &
set_minimum_backlight_brigtness &
set_auto_lock_handler &
setxkbmap -layout 'us,hr' -option 'caps:escape' -option 'grp:win_space_toggle'
xset r rate 350 50

######### RUN ONCE

# run slack --startup
# run blueman-applet
# run nm-applet
# run /usr/lib/xfce4/notifyd/xfce4-notifyd

# Run bar
$HOME/.config/polybar/launch.sh

LOCAL_OVERRIDES="$(dirname $0)/autorun.local.sh"
if [ -f "$LOCAL_OVERRIDES" ]; then
	source "$LOCAL_OVERRIDES"
fi
