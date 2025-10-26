#!/bin/bash

# 0 option
DOWNLOAD="~/Downloads"
INSTALL=`pwd`
SKIP=false
while getopts t:f:i:s: option
do
case "${option}"
in
f) DOWNLOAD=${OPTARG};;  ## -f option, tar.gz file directory
t) TIME=${OPTARG};; ## -t option, time point, eg. xxxx, or xxxxxx
i) INSTALL=${OPTARG};; ## -i option, install directory
s) SKIP=${OPTARG};; ## -s option, skip tar processing
esac
done

# 1. preprocessing input time point
while [ ${#TIME} -lt 6 ]; do
    TIME=${TIME}"0"
done

# 2.get newest log file
char=`ls -lt ~/Downloads |grep "tar.gz"| awk '{print $9; exit}'`
echo "newest log:" $char
rm -rf /tmp/log
mkdir /tmp/log
tar -xzvf ~/Downloads/${char} -C /tmp/log
cd /tmp/log

char=`ls -lt |grep "log"| awk '{print $9; exit}'`
echo $char

# 3.get the target ucdf file
cd ${char}
target="0"
for file in *.ucdf
do
    if [ ! -z ${file} ]; then
        curr_time=${file:12:6}
        echo ${curr_time} $TIME
        if [ "$curr_time" -gt "$TIME" ]; then
            break
        else
            target=$file
        fi  
    fi
done

if [ ${target}!="0" ]; then
    echo "get target ucdf! " ${target}

    echo "curr_dir:" `pwd`
    echo "install_dir:" $INSTALL "ucdf_dir:" ./$target

    replay_cli --install $INSTALL --ucdf ./$target
else
    echo "Fail to find target ucdf file!"
fi

