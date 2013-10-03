#/bin/bash

echo "Something missing about the color profiles, images come out weird."
exit 2

for i in ./*.eps; do
    b=${i%.*}
    o="$b.png"
    echo -n "$i -> $o... "
    if [ -f $o ]; then
        echo "$o already exists. skipping."
        continue
    fi
    echo -n "extracting color profile... "
    convert $i $b.xmp
    echo -n $?" "
    echo -n "converting... "
    convert -density 300 $i -profile $b.xmp -profile $b.xmp -flatten $o
    echo $?
done

