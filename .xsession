#!/usr/bin/env bash

# Set a low volume at login to protect hearing.
    amixer -D pulse sset Master 14%

# Mount drive. Configure fstab for read-write access.
    udisksctl mount -b /dev/sdb1

# Run fcitx5 in the background as a daemon for keyboard switching.
    fcitx5 -d

# Search for devices in the network and re-establish connections.
    kdeconnect-cli --refresh

# Only run the following programs, not intended for KDE or GNOME, with DWM.
if [ "$DESKTOP_SESSION" = "dwm" ]; then
    # Run picom compositor for blurring windows and rounding corners.
        picom -b

    # Set wallpaper randomly and change it every 60 seconds.
        nowater -d "$HOME/Pictures/wallpapers/nordic" -t 60

    # Suckless status bar for dwm.
        slstatus &

    # Run dunst as a notification daemon.
        dunst &

    # Start music player daemons.
        # Provide mpris protocol support. Used by playerctl.
        mpDris2 &
        # Start the music player daemon.
        mpd
fi

