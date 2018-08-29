#!/bin/bash
if [ $# -lt 2 ]; then
	echo usage: replace-file-name.sh [text] [replacement]
	exit 1
fi

for file in *${1}
do
	mv "$file" "${file%$1}$2"
done