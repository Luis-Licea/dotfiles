#!/usr/bin/env nix-shell
#!nix-shell -p ghostscript bc -i bash

function crop_pdf() {
    input=$1
    output=$6

    pdf_info=$(pdfinfo -box "$input")
    currentWidth=$(echo "$pdf_info" | grep "Page size:" | awk '{print $3}')
    currentHeight=$(echo "$pdf_info" | grep "Page size:" | awk '{print $5}')

    left=$2
    bottom=$3
    right=$(echo "$currentWidth - $4" | bc)
    top=$(echo "$currentHeight - $5" | bc)

    gs -o "$output" -sDEVICE=pdfwrite -c "[/CropBox [$left $bottom $right $top] /PAGES pdfmark" -f "$input"
}


mm-to-pts() {
    # 1 mm = 2.8346456693 pts
    echo "$1 * 2.8346456693" | bc
}

function crop-to-size() {
    local pdf_info input width height output
    input=$1
    width=$2
    height=$3
    output=$4

    pdf_info=$(pdfinfo -box "$input")
    currentWidth=$(echo "$pdf_info" | grep "Page size:" | awk '{print $3}')
    currentHeight=$(echo "$pdf_info" | grep "Page size:" | awk '{print $5}')

    bottom=$(echo "$currentHeight - $(mm-to-pts "$height")" | bc)
    right=$(echo "$currentHeight - $(mm-to-pts "$width")" | bc)
    # right=$(echo "$currentWidth - $4" | bc)

    set -x
    # x1 y1 x2 y2
    gs -o "$output" -sDEVICE=pdfwrite -c "[/CropBox [0 $currentHeight $(mm-to-pts "$width") $bottom] /PAGES pdfmark" -f "$input"
    set +x
}

if [[ $# = 0 || $1 = -h || $1 = --help ]]; then
    # echo "$(basename "$0") input.pdf left bottom right top output.pdf"
    echo "$(basename "$0") input.pdf width-mm height-mm output.pdf"
else
    crop-to-size "$@"
fi
