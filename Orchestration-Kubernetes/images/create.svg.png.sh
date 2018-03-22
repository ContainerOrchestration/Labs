#!/bin/bash


SVG_FILES=*.svg

[ ! -z "$1" ] && SVG_FILES=$*

#for i in *.svg; do

for i in $SVG_FILES; do
    convert $i ${i}.png
    ls -altr $i ${i}.png
done

