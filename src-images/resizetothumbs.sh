#/bin/bash

WD="./300dpi/"

if [ ! -d "$WD" ]; then
    echo "Folder doesn't exist: $WD"
    exit 2
fi

for i in "$WD"/*.png; do
    if [ ! -d "$WD/thumbs/" ]; then
        mkdir "$WD"/thumbs
    fi

    o="$WD/thumbs/"$(basename "$i")
    echo -n "$i -> $o... "
    if [ -f $o ]; then
        echo "$o already exists. skipping."
        continue
    fi
    echo -n "resizing... "
    convert $i -adaptive-resize 360x $o
    echo $?
done

