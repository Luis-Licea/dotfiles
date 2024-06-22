#!/usr/bin/env nix-shell
# shellcheck disable=2155
#! nix-shell -i bash -p jq socat


storeState() {
  local activeWindow=$(hyprctl -j activewindow)
  fullscreenMode=$(echo "$activeWindow" | jq -r '.fullscreenMode')
  fullscreen=$(echo "$activeWindow" | jq -r '.fullscreen')
}

toggleFullscreen() {
  hasFullscreen=$(hyprctl -j activeworkspace | jq -r '.hasfullscreen')
  if $fullscreen && ! $hasFullscreen; then
    hyprctl dispatch fullscreen "$fullscreenMode"
  fi
}

handle() {
  case "$1" in
    fullscreen* | workspace*) storeState ;;
    closewindow*) toggleFullscreen ;;
  esac
}

storeState

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
