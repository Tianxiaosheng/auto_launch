#!/bin/bash
  
# 1.获取当前install包对应的包文件名, 从而确定对应映射docker地址
# 前提: 映射与被映射地址绝对地址相同
tmp_var=$(cd .. && pwd)
echo "1. curr uos dir is:" ${tmp_var}

# 2.检查容器是否在运行
IS_RUNNING=$(docker ps -a -f "name=u1604-3")
echo ${IS_RUNNING}
if [ -z "$IS_RUNNING" ]; then
    # 如果容器未运行，则启动容器
	echo "2. Container not exit"
elif [[ "$IS_RUNNING" == *"Exited"* ]]; then
    echo "2. Exit state, docker start..."
    docker start u1604-3
elif [[ "$IS_RUNNING" == *"Up"* ]]; then
    echo "2. Docker running"
fi

# 3.进入容器

echo "3. exec u1604-3"
docker exec -it u1604-3 /bin/bash  /my_script/cat_mak.sh ${tmp_var}

## 4. 进入容器的映射uos目录
#echo "4. 进入对应映射地址"
#cd ${tmp_var}
#echo pwd

## 5. 编译
#catkin_make install

## 6.退出容器
#exit

cd ../

# 7.调整install权限为uisee
echo "woshiVjjj" | sudo -S chown -R uisee:uisee install

# 8.调整本地launch环境
cd install
./encrypt_param.sh
rm etc/*.json

