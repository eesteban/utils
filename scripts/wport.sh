#!/bin/sh
if [ $# -lt 1 ]; then
	echo usage: wport [port]
	exit 1
fi

netstat -lpan | grep :$1 | awk '{print $7}'