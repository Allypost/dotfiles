#!/usr/bin/env bash

function run() {
  if ! pgrep -f $1; then
    $@ &
  fi
}

function set_minimum_backlight_brigtness() {
  command -v light >/dev/null && sudo light -N 0.01
}

function apply_xrandr_screen_settings() {
  [ -f "$HOME/.screenlayout/defalt.sh" ] && "$HOME/.screenlayout/defalt.sh"
}

function run_auth_agents() {
  if [ ! -f '/usr/lib/polkit-kde-authentication-agent-1' ]; then
    return 1
  fi

  /usr/lib/polkit-kde-authentication-agent-1 &
  eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)
}

function set_desktop_wallpaper() {
  nitrogen --restore
  until [ $? -eq 0 ]; do
    nitrogen --restore
  done
}

function set_hid_libinput_settings() {
  for id in $(xinput list --short | grep -E '^⎜\s+↳' | perl -n -e'/id=(\d+)/ && print "$1\n"'); do
    xinput set-prop "$id" 'libinput Accel Speed' 0.4 &>/dev/null
    xinput set-prop "$id" 'libinput Accel Profile Enabled' 0 1 &>/dev/null
  done
  xinput set-prop 'Elan Touchpad' 'libinput Natural Scrolling Enabled' 1
  
  TOUCHPAD_ID="$(xinput list | grep -i touchpad | head | sed -E 's/.*\sid=([0-9]+)\s.*/\1/')"
  if [ ! -z "$TOUCHPAD_ID" ]; then
    xinput set-prop "$TOUCHPAD_ID" 'libinput Natural Scrolling Enabled' 1
  fi
}

######### RUN EVERY TIME

apply_xrandr_screen_settings &
run_auth_agents &
set_desktop_wallpaper &
set_hid_libinput_settings &
set_minimum_backlight_brigtness &

######### RUN ONCE

run slack --startup
run mattermost-desktop
run setxkbmap -layout 'us,hr'
run blueman-applet
run nm-applet
