#!/bin/bash
if [ $# -lt 1 ]; then
	echo usage: malias [command]
	exit 1
fi

if [ $# -lt 2 ]; then
	echo "alias $1" >> ~/.zshrc
	exit 0;
fi

COMMAND=${@:2}

malias "$1=\"${COMMAND[0]}\""
