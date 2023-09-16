#!/usr/bin/env bash

# Exit on errors, undefined variables, and unmask pipeline errors.
set -euo pipefail
# No Internal Field Separator. To split spaces, newlines, and tabs: IFS=$' \n\t'
unset IFS

#######################################
# Split a string using the given character, and store the array in the name-ref.
# Arguments:
#   1: The string to split.
#   2: The separator character, like ' ', $'\n', or $'\t'.
#   3: The variable name-ref.
# Example:
#   $ split $'hello\nworld' $'\n' words
#   $ declare -p words
#   declare -a words=([0]="hello" [1]="world")
#######################################
split() {
    declare -nr array="$3"
    local IFS="$2"
    array=($1)
}

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
