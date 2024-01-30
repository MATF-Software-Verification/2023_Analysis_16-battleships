#!/usr/bin/bash

set -xe

valgrind --tool=callgrind --log-file="report-callgrind" ./16-battleships/build-battleships-Desktop_Qt_6_5_3_GCC_64bit-Release/battleships

echo "callgrind finished"
