#!/bin/bash

if [ -f tracked.robot ]; then
	rm tracked.robot
fi
if [ -f delay.robot ]; then
        rm delay.robot
fi
if [ -f execute_script.robot ]; then
        rm execute_script.robot
fi
if [ -f apache.robot ]; then
        rm apache.robot
fi

sed "s/IPADDR/$1/g" tracked.robot.tpl > tracked.robot
sed "s/IPADDR/$1/g" delay.robot.tpl > delay.robot
sed "s/IPADDR/$1/g" apache.robot.tpl > apache.robot
sed "s/IPADDR/$1/g" execute_script.robot.tpl > execute_script.robot
sed -i "s/TOPICNAME/$2/g" tracked.robot
sed -i "s/TOPICNAME/$3/g" delay.robot
sed -i "s/TOPICNAME/$4/g" apache.robot
