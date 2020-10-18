#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

green "正在进行初始化…"
green "这一过程只会在您第一次运行脚本时进行"
green "确认您的设备信息中……"
log=log_init.log
mkdir -p $ToolPATH/logs
rm -f $ToolPATH/logs/*log_*.log
touch $ToolPATH/logs/tmp_$log
echo -e "====Device info====\n" >> $ToolPATH/logs/tmp_$log
echo "Date:" >> $ToolPATH/logs/tmp_$log
echo "$(date)\n\n" >> $ToolPATH/logs/tmp_$log
echo "<----Props---->" >> $ToolPATH/logs/tmp_$log
getprop >> $ToolPATH/logs/tmp_$log
echo -e "\n\n" >> $ToolPATH/logs/tmp_$log
echo "<----System info---->" >> $ToolPATH/logs/tmp_$log
echo "Logged In users:" >> $ToolPATH/logs/tmp_$log
whoami >> $ToolPATH/logs/tmp_$log
echo $systeminfo >> $ToolPATH/logs/tmp_$log
echo "Package Installed" >> $ToolPATH/logs/tmp_$log
pkg list-installed >> $ToolPATH/logs/tmp_$log 2>/dev/null
echo -e "\n\n" >> $ToolPATH/logs/tmp_$log
echo "<----Hardware info---->" >> $ToolPATH/logs/tmp_$log
echo "CPU info:" >> $ToolPATH/logs/tmp_$log
lscpu >> $ToolPATH/logs/tmp_$log
echo "Memory and Swap info:" >> $ToolPATH/logs/tmp_$log
free -h >> $ToolPATH/logs/tmp_$log
echo "Internet info:" >> $ToolPATH/logs/tmp_$log
ifconfig >> $ToolPATH/logs/tmp_$log 2>/dev/null
echo "Disk Usages :" >> $ToolPATH/logs/tmp_$log
df -h >> $ToolPATH/logs/tmp_$log
mv -f $ToolPATH/logs/tmp_$log $ToolPATH/logs/$log
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
blue "是否使用 GitHub 加速节点?"
read ghproxychoose
case $ghproxychoose in
	y)
		echo "gh.qingxu.ga/" > $ToolPATH/gh-proxy
		;;
	*)
		green "Skip..."
		;;
esac


green "您马上就可以进入脚本!"
touch $ToolPATH/ok
clear 
bash $ToolPATH/main/script/menu.sh
