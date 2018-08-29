#!/bin/sh
if [ $# -lt 2 ]; then
	echo usage: link-deps.sh [full_path_src] [full_path_dest]
	exit 1
fi

FULL_PATH_SRC=$1
FULL_PATH_DEST=$2

DIR="$(ls $FULL_PATH_DEST)"

for dir in $DIR
do
    link-dep $dir $FULL_PATH_SRC $FULL_PATH_DEST
done
