#!/bin/bash

# We want to preserve:
#
# * parapraph breaks
# * line breaks
# * italic and bold text
# * correct quoting characters
# * unicode characters
#

SRC="$1"

# Abiword will preserve paragraph breaks and line breaks, but will convert the
# accented characters to LaTeX accent commands:
abiword --to=tex --to-name="$SRC.tmp.tex" "$SRC"

# Fix markup with extra space as in: lorem \emph{ipsum dolor, }sit el amet
sed -ie 's_\(\\emph[{]\)\(\s\+\)_\2\1_g; s_\(\s\+\)[}]_}\1_g;' "$SRC.tmp.tex"

# Replace LaTeX accent commands with unicode characters:
# ...

# Insert newlines at linebreaks:
sed -i 's_\\\\_&\n_g' "$SRC.tmp.tex"

# Clean up.
#rm "$SRC.tmp.md" "$SRC.tmp.tex"

