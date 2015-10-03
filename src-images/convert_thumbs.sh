#!/bin/bash

echo "Convert jpg-thumbs-crops..."

for i in ./jpg-thumbs-crops/*.jpg; do
  echo -n "$i ... "
  name=`basename -s .jpg $i`
  ../scripts/img2pdf.py --output thumbs-300dpi/"$name"_thumb.pdf jpg-thumbs-crops/`basename $i` && \
  convert "$i" -compress zip -adaptive-resize 360x thumbs-360px/"$name"_thumb.pdf
  if [ "$?" != "0" ]; then
    echo "ERROR"
    exit 2
  fi
  echo "OK"
done

