#!/bin/bash
#for no command line arguments it exits

if["$#" -lt 1]; then

exit

fi

#following is code for command line argument1

fname=$1

#assignning current time to the variable last_time

last_time=$(date+"%T")

#assigning commandline argument 2 to the variable datestr

datestr="$2"

date "%T" -d "$datestr" > /dev/null 2>&1

#check whether $2 is time format or not

#if true update last_time variable with $2 value

if [$? != 0]; then

last_time="datestr"

fi

#following code is for command line arguments greater than 2

var1='echo $((($var*2)/2))'

interval=60

if["$#" -gt 2]; then

if["$3"=="$var1"]; then

internal=$3*60

fi

fi

while read p; do
    echo "4"
    [[ "$p" =~ $reg ]] || continue

    echo "3"

    strtime=$(echo $p | grep -P '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' -o)

    utime=$(date -d "$strtime" +"%s")
end=$(expr $utime - $last_time)

echo "5"

if [ $end -le $interval ]; then
    echo $p
fi

done <$1
