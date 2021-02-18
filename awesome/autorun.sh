#!/usr/bin/env bash

function run() {
  if ! pgrep -f $1; then
    $@ &
  fi
}

run slack --startup
run mattermost-desktop
run setxkbmap -layout 'us,hr'
