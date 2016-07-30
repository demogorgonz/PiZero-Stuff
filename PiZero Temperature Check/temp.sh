#!/bin/bash
temp=$(vcgencmd measure_temp)
echo $temp


#Utilize this if you have tweet script to post status on twitter.
# tweet HealthCheck Temp: $temp 


