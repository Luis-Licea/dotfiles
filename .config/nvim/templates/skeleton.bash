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
