#!/usr/bin/bash

set -xe

flawfinder --html ./16-battleships > flawfinder_result.html

echo "flawfinder finished"
