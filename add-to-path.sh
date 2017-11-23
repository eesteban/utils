#!/bin/sh
for i in `find $(pwd)/scripts -type f  -iname \*.sh`
do
  scripts/link-it.sh $i
done
