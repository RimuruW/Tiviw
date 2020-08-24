#!$PREFIX/bin/sh
if [ -f $PREFIX/bin/tconfig]; then
	echo "您已安装启动器，无需重复安装"
	echo "您无需手动更新启动器，如果网络连接正常，启动器会在启动时自动更"
	exit 1
fi
if [ ! -f $PREFIX/bin/wget ]; then
	echo "***************"
	echo "请手动安装 wget 后运行该脚本"
	echo "***************"
else
	wget https://raw.githubusercontent.com/huanruomengyun/Tokka/dev/tconfig -P $PREFIX/bin
	if [ ! -f $PREFIX/bin/tconfig ]; then
		wget gh.qingxu.ga/https://raw.githubusercontent.com/huanruomengyun/Tokka/dev/tconfig -P $PREFIX/bin
	fi
	if [ ! -f $PREFIX/bin/tconfig ]; then
		echo "*************"
		echo "请检查网络连接状态"
		echo "*************"
		exit 1
	fi
	chmod +x $PREFIX/bin/tconfig
	echo -e "\n\n***********"
	ehco "请输入 tconfig 启动脚本"
	echo "***********"
fi
