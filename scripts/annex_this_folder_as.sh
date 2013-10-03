#!/bin/bash

if [ "$1" == "" ]; then
  echo "Give the name of the git-annex as first argument."
fi

git init . && git annex init "$1" && git add . && git commit -m "annexed"

if [ "$?" == "0" ]; then
  echo "---"
  echo 'Annexed as "$1"'
  echo "Stack the files, in piles like twisted trees."
else
  echo "---"
  echo "There was and error."
  echo "A hideous silence is moving in the air."
fi

