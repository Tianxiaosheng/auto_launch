#!/bin/bash

#===============Version 1.0====================
# file_name:
#    mybin.sh
#----------------------------------------------
# description: 
#    1->compile uos
#    2->kill uos_planner
#    3->waiting uos_planner being killed
#    4->start uos_planner
#----------------------------------------------
# updated date:
#    2022-11-12
#----------------------------------------------
# auther:
#    tianxiaosheng
#---------------------------------------------
# email:
#    tianxiaoshengbjut@126.com
#==============================================

# 1.compile 
cd ../
catkin_make install
cd install
./encrypt_param.sh
rm etc/*.json

# 2.kill uos_planner
echo "killing uos_planner..."
killall uos_planner

# 3.waiting being killed
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

# 4.start uos_planner
. set_env.sh
echo "start uos_planner"
bin/uos_planner

