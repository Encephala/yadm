#!/bin/bash
# Onboard audio: Line Out (speakers) <-> Headphones.
# If another sink (e.g. a USB controller) grabbed the default, the first click
# just switches back to onboard audio without changing the port.
SINK=alsa_output.pci-0000_18_00.6.analog-stereo

if [ "$(pactl get-default-sink)" = "$SINK" ]; then
    NEXT=$(pactl -f json list sinks | jq -r --arg sink "$SINK" '
        .[] | select(.name == $sink)
        | .active_port as $active
        | [.ports[].name | select(. != $active)][0]
    ')
    pactl set-sink-port "$SINK" "$NEXT"
else
    pactl set-default-sink "$SINK"
fi

# Move already-playing streams along with the default
for input in $(pactl list short sink-inputs | cut -f1); do
    pactl move-sink-input "$input" "$SINK"
done
