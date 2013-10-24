#!/bin/bash

# Using img2pdf for high-res lossless convert, but somehow its --dpi
# option doesn't work, so using imagemagick convert for those.

for i in ./jpg/*.jpg; do
  echo -n "$i ... "
  name=$(echo "`basename $i`" | sed 's/\..*$//;')
  ../scripts/img2pdf.py --output pdf/"$name".pdf "$i" && \
  cp pdf/"$name".pdf 300dpi/ && \
  convert "$i" -compress jpeg -quality 90 -resample 92 92dpi/"$name".pdf && \
  convert "$i" -compress jpeg -quality 90 -resample 30 30dpi/"$name".pdf && \
  convert "$i" -compress zip -adaptive-resize 360x thumbs/"$name"_thumb.pdf
  if [ "$?" != "0" ]; then
    echo "ERROR"
    exit 2
  fi
  echo "OK"
done
