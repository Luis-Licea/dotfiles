#!/usr/bin/env bash

# Exit on errors, undefined variables, and unmask pipeline errors.
set -euo pipefail
# No Internal Field Separator. To split spaces, newlines, and tabs: IFS=$' \n\t'
unset IFS

#######################################
# Selects a random element from the given list.
# Arguments:
#   1: The list name-ref.
# Standard output:
#   1: A random element from the list.
# Example:
#   $ list=("choice 1", "choice 2")
#   $ choice list
#   choice 2
#######################################
choice() {
    declare -nr arguments=$1
    readonly count=${#arguments[@]}
    readonly choice=${arguments[RANDOM%${count}]}
    printf "%s" "$choice"
}

# List of pretty #RRGGBB colors.
readonly colors=(
    "#6C5B7B"
    "#355C7D"
    "#A8E6CE"
)

#######################################
# Set the wallpaper to a solid color.
# Dependencies: huepaper choice swaybg
#######################################
set_wallpaper() {
    readonly wallpaper_path=$(mktemp -t "background-XXXXXXX.png")
    rm "$wallpaper_path"
    huepaper -c "$(choice colors)" -o $wallpaper_path
    if [[ $(pgrep swaybg) != "" ]]; then
        pkill swaybg
    fi
    swaybg -i "$wallpaper_path"
}

# List of commands to execute at boot time.
declare -A commands=(
    # Set a low volume at login to protect hearing.
    ["amixer"]="amixer sset Master 15%"
    # Run dunst as a notification daemon.
    ["dunst"]="dunst &"
    # Run fcitx5 in the background as a daemon for keyboard switching.
    ["fcitx"]="fcitx5 -d"
    # Search for devices in the network and re-establish connections.
    ["kdeconnect-cli"]="kdeconnect-cli --refresh"
    # Show the status bar.
    ["waybar"]="waybar &"
)

# List of wallpaper commands listed in order of preference.
declare -A wallpapers=(
    # Set an auto-generated wallpaper.
    ["huepaper"]="set_wallpaper"
    # Set background color.
    ["swaybg"]="swaybg -c '$(choice colors)'"
)

# Execute the expression if the executable exists.
for executable in ${!commands[@]}; do
    if [[ -n $(command -v $executable) ]]; then
        eval ${commands[$executable]}
    fi
done

# Set the background and quit for-loop.
for executable in ${!wallpapers[@]}; do
    if [[ -n $(command -v $executable) ]]; then
        eval ${wallpapers[$executable]} &
        break
    fi
done

