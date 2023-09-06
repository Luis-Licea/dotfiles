#!/bin/sh
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=dwl

# Run emacs deamon so that clients start up quickly.
emacs --daemon
# Redirect tag information into file.
dwl > "$HOME/.cache/dwltags"
