#!/bin/bash
#hub-ctrl -h 0 -P 2 -p 0 | SHUTDOWN
#hub-ctrl -h 0 -P 2 -p 1 | POWERON
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))

echo $cpuTemp1

if [ $cpuTemp1 -gt 54 ]
then 
	sudo hub-ctrl -h 0 -P 2 -p 1 ; sleep 60; sudo hub-ctrl  -h 0 -P 2 -p 0  
fi

