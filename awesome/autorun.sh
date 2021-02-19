#!/usr/bin/env bash

function run() {
  if ! pgrep -f $1; then
    $@ &
  fi
}

run slack --startup
run mattermost-desktop
run setxkbmap -layout 'us,hr'

for id in $(xinput list --short | grep -E '^⎜\s+↳' | perl -n -e'/id=(\d+)/ && print "$1\n"'); do
  xinput set-prop "$id" 'libinput Accel Speed' 0.4 &>/dev/null
  xinput set-prop "$id" 'libinput Accel Profile Enabled' 0 1 &>/dev/null
done
