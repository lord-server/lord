#!/bin/sh
# Script-helper for converting old door textures to new.

set -e

if [ "$#" -lt 4 ]; then
  cat <<EOF
Usage:
  script.sh <tile_top> <tile_bottom> <edge> <output texture name>
EOF
  exit 1
fi
a_top=$1
b_bottom=$2
edge=$3
output_name=$4

# mirror
a_top_mirrored=${a_top%.*}-mirrored.png
convert -flop "$a_top" "$a_top_mirrored"
b_bottom_mirrored=${b_bottom%.*}-mirrored.png
convert -flop "$b_bottom" "$b_bottom_mirrored"

# two sides for door
output_name_without_edges=${output_name%.*}_without_edges.png
montage "$a_top" "$a_top_mirrored" "$b_bottom" "$b_bottom_mirrored" \
  -geometry +0+0+0+0 \
  -tile 2x2 \
  -background transparent \
  "$output_name_without_edges"

# sides
height=$(identify -ping -format '%H' "$output_name_without_edges")
width=6; [ "$height" = 64 ] && width=12
output_name_edge=${output_name%.*}_edge.png
magick "$edge" \
  -virtual-pixel tile \
  -set option:distort:viewport "$width"x"$height" \
  -distort SRT 0 \
  "$output_name_edge"

# finally
montage "$output_name_without_edges" "$output_name_edge" \
  -tile 2x -geometry +0+0 -background transparent "$output_name"

# tmp deleting
rm -f \
  "$a_top_mirrored" \
  "$b_bottom_mirrored" \
  "$output_name_without_edges" \
  "$output_name_edge"
