#!/bin/bash

# compile 
cd ../
catkin_make install
cd install
./encrypt_param.sh
rm etc/*.json

# kill uos_planner
echo "killing uos_planner..."
killall uos_planner

# waiting being killed
for ((i=1; i<=20; i++))
do
    PID=`ps aux | grep uos_planner | awk '{print $2}'`
    if [ -n "${PID}" ];then
        sleep 1
        echo "waiting ${i}s"
        if [ i>=20 ]; then
            echo "run outof time!"
        fi
    else
        echo "uos_planner has been killed!"
        break
    fi
done

. set_env.sh
echo "start uos_planner"
bin/uos_planner

