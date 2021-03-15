#!/bin/bash

# 如果参数为空，就推出
if [ -z "$1" ]
  then
    exit 0
fi


# 创建时间点，默认当前 unix 时间
last_time=$(date +"%s")


if [ $# -ne 1 ] ; then
    # 如果参数不是 1 个，说明 2 个以上
    # 尝试解析第 2 个参数，如果成功，则以参数 2 的时间为准，否则还是当前时间
    last_time=$(date -d "$2" +"%s")
    if [ $? -ne 0 ]; then
        last_time=$(date +"%s")
    fi
fi

# 默认过滤参数 2 时间后的 60 秒内的日志
interval=60
if [ $# -eq 3 ] ; then
    # 如果设置了参数 3，则解析 参数3（倍数）* interval
    int_regex='^[0-9]+$'
    if [[ "$3" =~ $int_regex ]]; then 
        interval=`expr $interval \* $3`
    fi
fi

reg="^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}.*"
# 读参数 1 指定的文件
while read p; do

    # 如果这一行没有以日期时间开始，则继续下一行。
    [[ "$p" =~ $reg ]] || continue
    
    # 提取时间 date-time 转换为 unix time
    # 如何在 date-time 时间后的 interval 内则输出
    strtime=$(echo $p | grep -P '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' -o)

    utime=$(date -d "$strtime" +"%s")
    end=$(expr $utime - $last_time)

    if [ $end -le $interval ] ; then
        # 在时间间隔内的输出
        echo $p
    fi

done <$1
