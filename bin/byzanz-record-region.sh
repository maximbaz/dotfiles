#!/bin/bash

DURATION=$1

sleep 3
ARGUMENTS=$(xrectsel "--x=%x --y=%y --width=%w --height=%h") || exit -1
byzanz-record --verbose --delay=0 ${ARGUMENTS} --duration=$1 ${@:2}
