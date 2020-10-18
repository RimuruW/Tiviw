ping -c 1 google.com > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo 检测网络正常
else
    echo 检测网络连接异常
fi
