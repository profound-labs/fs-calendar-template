#!/bin/bash

SRC_DIR="./300dpi"
DEST_DIR="./pdf-tmp"

DPI=72
DPI_DIR="$DEST_DIR/$DPI""dpi"

if [ ! -d "$SRC_DIR" ]; then
    echo "Folder not found: $SRC_DIR"
    exit 2
fi

if [ ! -d "$DEST_DIR" ]; then
    mkdir "$DEST_DIR"
fi

if [ ! -d "$DPI_DIR" ]; then
    mkdir "$DPI_DIR"
fi

for i in "$SRC_DIR"/*.pdf
do
    basename=`basename $i`
    name=`echo "$basename" | sed 's/\.[^\.]\+$//'`
    out="$DPI_DIR/$basename"

    if [ -f "$out" ]; then
        echo "$out already exists; skipping"
        continue
    fi

    echo -n "$basename to $out ... "
    convert "$i" -compress jpeg -quality 90 -resample "$DPI" "$out"
    echo $?

    out="$DPI_DIR/$name""_thumb.pdf"

    if [ -f "$out" ]; then
        echo "$out already exists; skipping"
        continue
    fi

    echo -n "$basename to $out ... "
    convert "$i" -compress zip -adaptive-resize 360x "$out"
    echo $?

done
