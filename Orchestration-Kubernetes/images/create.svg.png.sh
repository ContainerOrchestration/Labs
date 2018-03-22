#!/bin/bash


SVG_FILES=*.svg

[ ! -z "$1" ] && SVG_FILES=$*

for SVG_FILE in $SVG_FILES; do
    [ "$SVG_FILE" != "${SVG_FILE%.svg}" ] && {
        convert $SVG_FILE ${SVG_FILE}.png
        ls -altr $SVG_FILE ${SVG_FILE}.png
    }
done

