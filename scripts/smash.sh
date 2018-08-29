#!/bin/sh
if [ $# -lt 1 ]; then
	echo usage: smash [pid]
	exit 1
fi

kill $1 -9