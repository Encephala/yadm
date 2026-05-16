#!/bin/bash
SINK=$(pactl get-default-sink)
ACTIVE=$(pactl list sinks | awk -v sink="$SINK" '
    $0 ~ ("Name: " sink) { f=1 }
    f && /Active Port:/ { print $3; exit }
')
NEXT=$(pactl list sinks | awk -v sink="$SINK" -v active="$ACTIVE" '
    $0 ~ ("Name: " sink) { f=1 }
    f && /Ports:/ { p=1; next }
    p && /^\t\t[a-z]/ { gsub(/:$/, "", $1); if ($1 != active) { print $1; exit } }
')
pactl set-sink-port "$SINK" "$NEXT"
