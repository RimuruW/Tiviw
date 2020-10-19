#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

blue(){
	echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
	echo -e "\033[32m\033[01m$1\033[0m"
}
red(){
	echo -e "\033[31m\033[01m$1\033[0m"
}

green "正在进行初始化…"
green "这一过程只会在您第一次运行脚本时进行"
green "确认您的设备信息中……"
log=log_init.log
mkdir -p $PREFIX/etc/tiviw/logs
rm -f $PREFIX/etc/tiviw/logs/*log_*.log
touch $PREFIX/etc/tiviw/logs/tmp_$log
echo -e "====Device info====\n" >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "Date:" >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "$(date)\n\n" >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "<----Props---->" >> $PREFIX/etc/tiviw/logs/tmp_$log
getprop >> $PREFIX/etc/tiviw/logs/tmp_$log
echo -e "\n\n" >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "<----System info---->" >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "Logged In users:" >> $PREFIX/etc/tiviw/logs/tmp_$log
whoami >> $PREFIX/etc/tiviw/logs/tmp_$log
echo $systeminfo >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "Package Installed" >> $PREFIX/etc/tiviw/logs/tmp_$log
pkg list-installed >> $PREFIX/etc/tiviw/logs/tmp_$log 2>/dev/null
echo -e "\n\n" >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "<----Hardware info---->" >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "CPU info:" >> $PREFIX/etc/tiviw/logs/tmp_$log
lscpu >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "Memory and Swap info:" >> $PREFIX/etc/tiviw/logs/tmp_$log
free -h >> $PREFIX/etc/tiviw/logs/tmp_$log
echo "Internet info:" >> $PREFIX/etc/tiviw/logs/tmp_$log
ifconfig >> $PREFIX/etc/tiviw/logs/tmp_$log 2>/dev/null
echo "Disk Usages :" >> $PREFIX/etc/tiviw/logs/tmp_$log
df -h >> $PREFIX/etc/tiviw/logs/tmp_$log
mv -f $PREFIX/etc/tiviw/logs/tmp_$log $PREFIX/etc/tiviw/logs/$log
green "系统信息确认完毕!!"
check_mirrors() {
	mirrors_status=$(cat $PREFIX/etc/apt/sources.list | grep "mirror" | grep -v '#')
	if [ -z "$mirrors_status" ]; then
		red "Termux 镜像源未配置！"
		echo -e "对于国内用户，添加清华源作为镜像源可以有效增强 Termux 软件包下载速度"
		echo -en "是否添加清华源？[y/n]"
		read mirror_choose
		case $mirror_choose in
			y)
				sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
				sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
				sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
				apt update && apt upgrade -y
				;;
			n)
				blue "使用默认源进行安装"
				;;
			*)
				blue "使用默认源进行安装"
				;;
		esac
	fi

}

check_mirrors

blue "- 节点选择 -"
blue "因为某些众所周知的原因，GitHub 在国内连接速度极为感人，对于无法正常连接 GitHub 的用户，你可以使用 GitHub 加速节点"
echo -en "是否使用 GitHub 加速节点?[y/n]"
read ghproxychoose
case $ghproxychoose in
	y)
		echo "gh.qingxu.ga/" > $PREFIX/etc/tiviw/gh-proxy
		;;
	*)
		green "Skip..."
		;;
esac


green "您马上就可以进入脚本!"
green "初始化完毕，请回车以启动脚本！"

touch $PREFIX/etc/tiviw/ok
