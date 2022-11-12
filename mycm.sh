#!/bin/bash

cd ../
catkin_make install
cd install
./encrypt_param.sh
rm etc/*.json

