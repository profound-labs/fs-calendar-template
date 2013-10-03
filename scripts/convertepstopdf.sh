#!/bin/bash

EPS_DIR="./eps/"
PDF_DIR="./pdf-tmp/"

if [ ! -d "$EPS_DIR" ]; then
    echo "Folder not found: $EPS_DIR"
    exit 2
fi
if [ ! -d "$PDF_DIR" ]; then
    mkdir "$PDF_DIR"
fi

# 300dpi
# ======

#if [ ! -d "$PDF_DIR/300dpi" ]; then
#    mkdir "$PDF_DIR/300dpi"
#fi
#
#for i in "$EPS_DIR"/*.eps
#do
#    basename=`basename $i`
#    name=`echo "$basename" | sed 's/\.[^\.]\+$//'`
#
#    out="$PDF_DIR/300dpi/$name.pdf"
#
#    if [ -f "$out" ]; then
#        echo "$out already exists; skipping"
#        continue
#    fi
#
#    echo -n "$basename to $out ... "
#    epspdf --hires --target=prepress --custom="-dUseFlateCompression=true -sDEVICE=pdfwrite -sProcessColorModel=DeviceCMYK -sColorConversionStrategy=CMYK -sColorConversionStrategyForImages=CMYK" "$i" "$out"
#    # alternative command:
#    # ? convert "$i" -compress zip -resample 300 "$out"
#    # convert "$i" -compress zip -density 300 "$out"
#    echo $?
#
#    out="$PDF_DIR/300dpi/$name""_thumb.pdf"
#
#    if [ -f "$out" ]; then
#        echo "$out already exists; skipping"
#        continue
#    fi
#
#    echo -n "$basename to $out ... "
#    convert "$i" -compress zip -adaptive-resize 360x "$out"
#    echo $?
#
#done

# 30 dpi
# ======

#if [ ! -d "$PDF_DIR/30dpi" ]; then
#    mkdir "$PDF_DIR/30dpi"
#fi
#
#for i in "$EPS_DIR"/*.eps
#do
#    basename=`basename $i`
#    name=`echo "$basename" | sed 's/\.[^\.]\+$//'`
#
#    out="$PDF_DIR/30dpi/$name.pdf"
#
#    if [ -f "$out" ]; then
#        echo "$out already exists; skipping"
#        continue
#    fi
#
#    echo -n "$basename to $out ... "
#    convert "$i" -compress zip -resample 30 "$out"
#    #convert "$i" -compress zip -density 30 "$out"
#    echo $?
#
#    out="$PDF_DIR/30dpi/$name""_thumb.pdf"
#
#    if [ -f "$out" ]; then
#        echo "$out already exists; skipping"
#        continue
#    fi
#
#    echo -n "$basename to $out ... "
#    convert "$i" -compress zip -adaptive-resize 360x "$out"
#    echo $?
#
#done

# 72 dpi
# ======

if [ ! -d "$PDF_DIR/72dpi" ]; then
    mkdir "$PDF_DIR/72dpi"
fi

for i in "$EPS_DIR"/*.eps
do
    basename=`basename $i`
    name=`echo "$basename" | sed 's/\.[^\.]\+$//'`

    out="$PDF_DIR/72dpi/$name.pdf"

    if [ -f "$out" ]; then
        echo "$out already exists; skipping"
        continue
    fi

    echo -n "$basename to $out ... "
    convert "$i" -compress jpeg -quality 90 -resample 72 "$out"
    echo $?

    out="$PDF_DIR/72dpi/$name""_thumb.pdf"

    if [ -f "$out" ]; then
        echo "$out already exists; skipping"
        continue
    fi

    echo -n "$basename to $out ... "
    convert "$i" -compress zip -adaptive-resize 360x "$out"
    echo $?

done
