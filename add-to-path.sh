#!/bin/sh
for i in `find $(pwd)/scripts -type f  -iname \*.sh`
do
  NO_EXTENSION="${i%.sh}"
  FILENAME="${NO_EXTENSION##*/}"
  echo 'Adding' $FILENAME
  sudo ln -s $i /usr/local/bin/$FILENAME
  chmod +x $i
done
