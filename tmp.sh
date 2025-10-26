#!/bin/bash

DOWNLOAD="~/Downloads"

char=`ls -lt ${DOWNLOAD}  | grep "tar.gz"| awk '{print $9; exit}'`
echo "newest log:" $char
