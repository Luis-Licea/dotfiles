#!/bin/sh

# Set a low volume at login to protect hearing.
    amixer -D pulse sset Master 15%

# Mount drive. Configure fstab for read-write access.
    udisksctl mount -b /dev/sdb1

# Run fcitx5 in the background as a daemon for keyboard switching.
    fcitx5 -d

# Search for devices in the network and re-establish connections.
    kdeconnect-cli --refresh

# Run dunst as a notification daemon.
    dunst &

# Set the background.
    # Get path to a random background and set the background.
    find /usr/share/backgrounds/suckless-wallpapers \
    | shuf -n 1 \
    | xargs swaybg -i &

# Show the status bar.
    waybar &


