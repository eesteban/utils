#!/bin/sh
if [ $# -lt 3 ]; then
	echo usage: link-dep.sh [asset] [full_path_src] [full_path_dest]
	exit 1
fi

ASSET=$1
FULL_PATH_SRC=$2
FULL_PATH_DEST=$3

if [ -d "$FULL_PATH_SRC/$ASSET" ]; then
    rm -rf "$FULL_PATH_DEST/$ASSET"
    ln -s "$FULL_PATH_SRC/$ASSET/dist" "$FULL_PATH_DEST/$ASSET"
    echo "$ASSET linked !"
else
    echo "$ASSET doesn't exist in source"
fi
