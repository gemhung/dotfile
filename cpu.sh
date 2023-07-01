#!/bin/bash
top -l  2 | grep -E "^CPU" | tail -1 | awk '{ printf $3+$5 }'
#
