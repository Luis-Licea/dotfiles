#!/usr/bin/env bash

# wayar-dwl.sh - display dwl tags, layout, and active title
#   This script is based on a script by "novakane" (Hugo Machet) for yambar.
#   https://codeberg.org/novakane/yambar/src/branch/master/examples/scripts/dwl-tags.sh

# PARAMETERS: waybar-dwl.sh MONITOR COMPONENT
#   "COMPONENT" is an integer representing a dwl tag OR "layout" OR "title".
#   "MONITOR" is an id like "HDMI-A-1". Use wlr-randr to get the monitor id.
#   For multi-monitor setups, see https://github.com/Alexays/Waybar/wiki/Configuration

# REQUIREMENTS:
#  - inotifywait ( 'inotify-tools' on arch )
#  - Launch dwl with `dwl > ~.cache/dwltags` or change $fname
#  - Use auto-start patch to execute the startup script

# Variables
declare output title layout activetags selectedtags
declare -a tags name
readonly fname="$HOME"/.cache/dwltags

tags=( "1" "2" "3" "4" "5" "6" "7" "8" "9" )
# name=( "" "" "" "" "" "" "7" "8" "9" ) # Array of labels for tags
name=( "1" "2" "3" "4" "5" "6" "7" "8" "9" ) # Array of labels for tags

monitor="${1}"
component="${2}"

_cycle() {

    case "${component}" in
    [012345678])
        this_tag="${component}"
        unset this_status
        # local this_status
        mask=$((1<<this_tag))

        if (( "${activetags}"   & mask )) 2>/dev/null; then this_status+='"active",'  ; fi
        if (( "${selectedtags}" & mask )) 2>/dev/null; then this_status+='"selected",'; fi
        if (( "${urgenttags}"   & mask )) 2>/dev/null; then this_status+='"urgent",'  ; fi

        if [[ "${this_status}" ]]; then
            printf -- '{"text":" %s ","class":[%s]}\n' "${name[this_tag]}" "${this_status}"
        else
            printf -- '{"text":" %s "}\n' "${name[this_tag]}"
        fi
        ;;
    layout)
        printf -- '{"text":"%s"}\n' "${layout}"
        ;;
    title)
        printf -- '{"text":"%s"}\n' "${title}"
        ;;
    *)
        printf -- '{"text":"INVALID INPUT"}\n'
        ;;
    esac
}

while [[ -n "$(pgrep waybar)" ]] ; do

    [[ ! -f "${fname}" ]] && printf -- '%s\n' \
                    "You need to redirect dwl stdout to ~/.cache/dwltags" >&2

    # Get info from the file
    output="$(grep  "${monitor}" "${fname}" | tail -n7)"
    title="$(echo   "${output}" | grep '^[[:graph:]]* title'  | cut -d ' ' -f 3-  | sed s/\"/“/g )" # Replace quotes - prevent waybar crash
    layout="$(echo  "${output}" | grep '^[[:graph:]]* layout' | cut -d ' ' -f 3- )"
    #selmon="$(echo "${output}" | grep 'selmon')"

    # Get the tag bit mask as a decimal
    tag="$(echo "${output}" | grep '^[[:graph:]]* tags')"
    activetags="$(echo "${tag}" | awk '{print $3}')"
    selectedtags="$(echo "${tag}" | awk '{print $4}')"
    urgenttags="$(echo "${tag}" | awk '{print $6}')"

    _cycle

    # 60-second timeout keeps this from becoming a zombified process when waybar is no longer running
    inotifywait -t 60 -qq --event modify "${fname}"

done

unset -v activetags layout name output selectedtags tags title

