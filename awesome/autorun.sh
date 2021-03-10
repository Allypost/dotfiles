#!/usr/bin/env bash

function run() {
  if ! pgrep -f $1; then
    $@ &
  fi
}

function apply_xrandr_screen_settings() {
  [ -f '~/.screenlayout/defalt.sh' ] && ~/.screenlayout/defalt.sh
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
  xinput --set-prop 'Elan Touchpad' 'libinput Natural Scrolling Enabled' 1
}

######### RUN EVERY TIME

apply_xrandr_screen_settings &
run_auth_agents &
set_desktop_wallpaper &
set_hid_libinput_settings &

######### RUN ONCE

run slack --startup
run mattermost-desktop
run setxkbmap -layout 'us,hr'
run blueman-applet
run nm-applet
