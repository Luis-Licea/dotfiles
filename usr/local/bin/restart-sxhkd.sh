#!/usr/bin/bash

# NOTE: Using "pkill sxhkd" does not work as intended; use process id instead.

# Get the process id.
id=$(pidof sxhkd)

# Check if sxhdk is running.
if [ "$id" ]; then
        # Kill and restart sxhkd.
        echo "Killing sxhkd with id $id."
        kill "$id"
fi

# Run sxhkd.
echo "Restarting sxhkd."
sxhkd &
