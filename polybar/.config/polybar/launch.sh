#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

while pgrep -u $UID -x polybar >/dev/null; do
	sleep 0.5
done

if type "xrandr"; then
	for m in $(xrandr --query | grep ' connected' | cut -d' ' -f1); do
		MONITOR=$m polybar --reload example 2>&1 | tee -a "/tmp/polybar-$m.log" &
		disown
	done
else
	polybar --reload example 2>&1 | tee -a "/tmp/polybar-monitor-main.log" &
	disown
fi
