#!/bin/bash

# Using img2pdf for high-res lossless convert, but somehow its --dpi
# option doesn't work, so using imagemagick convert for those.

echo "Convert jpg..."

for i in ./jpg/*.jpg; do
  echo -n "$i ... "
  name=`basename -s .jpg $i`
  ../scripts/img2pdf.py --output pdf/"$name".pdf "$i" && \
  cp pdf/"$name".pdf 300dpi/ && \
  convert "$i" -compress jpeg -quality 90 -density 300 -resample 92 92dpi/"$name".pdf && \
  if [ "$?" != "0" ]; then
    echo "ERROR"
    exit 2
  fi
  echo "OK"
done

