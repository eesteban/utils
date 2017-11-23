#!/bin/sh
if [ $# -lt 1 ]; then
	echo usage: link-it.sh [full_path]
	exit 1
fi

FULL_PATH=$1
NO_EXTENSION="${FULL_PATH%.*}"
FILENAME="${NO_EXTENSION##*/}"
LINK_FULL_PATH="/usr/local/bin/$FILENAME"

if [ -L "$LINK_FULL_PATH" ]
then
    echo "$FILENAME symlink already exists"
    exit 2
fi

echo 'Adding' $FILENAME
sudo ln -s $FULL_PATH $LINK_FULL_PATH
chmod +x $FULL_PATH
