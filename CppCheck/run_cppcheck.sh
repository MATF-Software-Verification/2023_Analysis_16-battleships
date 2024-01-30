#!/usr/bin/bash

set -xe

cppcheck --quiet --inconclusive --enable=all --suppress=missingInclude --output-file="cppcheck-output.txt" ./16-battleships

echo "cppcheck finished"
