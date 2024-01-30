#!/usr/bin/bash

set -xe

valgrind --show-leak-kinds=all --leak-check=full --track-origins=yes --log-file="report-memecheck.txt" ./16-battleships/build-battleships-Desktop_Qt_6_5_3_GCC_64bit-Debug/battleships

echo "memcheck finished"
