#!/bin/sh
# ~/.local/bin/volume-control

if pactl info >/dev/null 2>&1; then
    SINK="@DEFAULT_SINK@"

    get_vol() {
        pactl get-sink-volume "$SINK" | awk '{print $5}' | tr -d '%'
    }

    case "$1" in
        up)
            pactl set-sink-mute "$SINK" 0
            current=$(get_vol)
            if [ "$current" -lt 100 ]; then
                pactl set-sink-volume "$SINK" +5%
            fi
            ;;
        down)
            pactl set-sink-mute "$SINK" 0
            pactl set-sink-volume "$SINK" -5%
            ;;
        toggle)
            pactl set-sink-mute "$SINK" toggle
            ;;
        *)
            echo "Usage: $0 {up|down|toggle}"
            exit 1
            ;;
    esac
else
    case "$1" in
        up)    amixer set Master 5%+ unmute ;;
        down)  amixer set Master 5%- unmute ;;
        toggle) amixer set Master toggle ;;
        *) echo "Usage: $0 {up|down|toggle}"; exit 1 ;;
    esac
fi

# notify dwmstatus
pkill -USR1 -x dwmstatus 2>/dev/null || true

