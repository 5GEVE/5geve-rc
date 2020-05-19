#!/bin/bash

if [ -f equipments.robot ]; then
	rm equipments.robot
fi
if [ -f delay.robot ]; then
        rm delay.robot
fi
if [ -f apache.robot ]; then
        rm apache.robot
fi
if [ -f execute_script.robot ]; then
        rm execute_script.robot
fi

sed "s/IPADDR/$1/g" equipments.robot.tpl > equipments.robot
sed "s/IPADDR/$1/g" delay.robot.tpl > delay.robot
sed "s/IPADDR/$1/g" apache.robot.tpl > apache.robot
sed "s/IPADDR/$1/g" execute_script.robot.tpl > execute_script.robot
sed -i "s/TOPICNAME/$2/g" equipments.robot
sed -i "s/TOPICNAME/$3/g" delay.robot
sed -i "s/TOPICNAME/$4/g" apache.robot
