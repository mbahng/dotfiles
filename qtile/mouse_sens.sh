#!/bin/bash
# Usage: mouse_sens.sh [up|down]
# Adjusts or reads the Coordinate Transformation Matrix scale for the primary pointer device.

STEP=0.1
MIN=0.1

DEVICE_ID=$(xinput list --short | grep -i pointer | grep -iv xtest | grep -iv virtual | grep -iv master | head -1 | grep -oP 'id=\K\d+')

if [ -z "$DEVICE_ID" ]; then
    echo "N/A"
    exit 1
fi

CURRENT=$(xinput list-props "$DEVICE_ID" | grep "Coordinate Transformation Matrix" | cut -d: -f2 | grep -oP '[\d.]+' | head -1)

case "$1" in
    up)
        NEW=$(python3 -c "print(round($CURRENT + $STEP, 2))")
        xinput set-prop "$DEVICE_ID" "Coordinate Transformation Matrix" "$NEW" 0 0 0 "$NEW" 0 0 0 1
        ;;
    down)
        NEW=$(python3 -c "print(round(max($MIN, $CURRENT - $STEP), 2))")
        xinput set-prop "$DEVICE_ID" "Coordinate Transformation Matrix" "$NEW" 0 0 0 "$NEW" 0 0 0 1
        ;;
    *)
        printf "%.1fx\n" "$CURRENT"
        ;;
esac
