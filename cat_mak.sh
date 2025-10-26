#!/bin/bash

echo $#
if [ $# -lt 1 ]; then
    echo "need specific uos directory!"
    get_dir=false
else
    get_dir=false
    tmp_var=$1

    echo ${tmp_var}
fi

if [ $get_dir ]; then
    cd $tmp_var
    echo pwd
    catkin_make install
fi

exit
