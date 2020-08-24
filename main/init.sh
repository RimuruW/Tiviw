#!$PREFIX/bin/bash
#-----------------------------------
# Author: Qingxu (huanruomengyun)
# Description: Termux Tools
# Repository Address: https://github.com/huanruomengyun/Tokka
# Version: 1.6.30
# Copyright (c) 2020 Qingxu
#-----------------------------------
name="Tokka"
sh_ver="1.8.14"
ToolPATH=$PREFIX/etc/tconfig
function blue(){
	echo -e "\033[34m\033[01m$1\033[0m"
}
function green(){
	echo -e "\033[32m\033[01m$1\033[0m"
}
function red(){
	echo -e "\033[31m\033[01m$1\033[0m"
}
if [ -t 1 ]; then
	RED=$(printf '\033[31m')
	GREEN=$(printf '\033[32m')
	YELLOW=$(printf '\033[33m')
	BLUE=$(printf '\033[34m')
	BOLD=$(printf '\033[1m')
	RESET=$(printf '\033[m')
else
	RED=""
	GREEN=""
	YELLOW=""
	BLUE=""
	BOLD=""
	RESET=""
fi
if [[ $EUID -eq 0 ]]; then
	red "检测到您正在尝试使用 ROOT 权限运行该脚本"
	red "这是不建议且不被允许的"
	red "该脚本不需要 ROOT 权限,且以 ROOT 权限运行可能会带来一些无法预料的问题"
	red "为了您的设备安全，请避免在任何情况下以 ROOT 用户运行该脚本"
	exit 0
fi
if [[ -d /system/app && -d /system/priv-app ]]; then
	systeminfo="Android $(getprop ro.build.version.release)"
else
	red "This operating system is not supported."
	exit 1
fi
blue "为确保脚本正常运行，每次运行脚本都将会强制进行初始化"
blue "给您带来的不便还请见谅"
green "Initializing……"

if [ ! -f "$PREFIX/etc/tconfig/branch" ]; then
	branch="master"
else
	branch=$(cat $PREFIX/etc/tconfig/branch)
fi

if [ ! -f "$PREFIX/bin/wget" ];then
	pkg in wget -y >/dev/null
fi

mkdir -p $ToolPATH

if [ -f "$PREFIX/etc/tconfig/mirrorstatus" ];then
	apt-get update >/dev/null
else
	echo "Skip..."
fi

sh_new_ver=$(wget -qO- -t1 -T3 "https://raw.githubusercontent.com/huanruomengyun/$name/$branch/tconfig" | grep 'sh_ver="' | awk -F "=" '{print $NF}' | sed 's/\"//g' | head -1) && sh_new_type="github"

if [ -z ${sh_new_ver} ]; then
	echo "****************"
	echo "无法链接到 Github!"
	echo "请注意,该脚本绝大多数功能都需要与 GitHub 建立连接,若无法连接 GitHub,则脚本大多数功能无法使用!!"
	echo "****************"
	echo -en "\n\n\t\t\t点击任意键以继续"
	read -n 1 line
	sh_new_ver=$(wget -qO- -t1 -T3 "gh.qingxu.ga/https://raw.githubusercontent.com/huanruomengyun/$name/$branch/termux-config.sh"
| grep 'sh_ver="' | awk -F "=" '{print $NF}' | sed 's/\"//g' | head -1) && sh_new_type="github"
fi

#[[ $sh_new_ver -lt $sh_ver ]] && red "警告！本地脚本版本号高于云端版本号。\n这可能是因为您正在使用 dev 分支，而脚本默认拉取 master 分支。\n建议不要在任何情况下使用 dev 分支以获取更佳的使用体验\n" && canautoupdate=warning
#if [ -f "$PREFIX/etc/tconfig/startautoupdate" ]; then
	#if [ $canautoupdate = warning ]; then
	#	red "本地版本号高于云端版本号，是否仍然拉取云端最新版本覆盖本地？"
	#	echo -en "\t\t [y/N] 默认 N :"
	#	read updatecover
	#	case $updatecover in
	#		y)
	#			wget -N "https://raw.githubusercontent.com/huanruomengyun/Termux-Tools/master/termux-config.sh" && chmod +x termux-config.sh
	#			echo -e "脚本更新为云端最新[ $sh_ver --> $sh_new_ver ]"
	#			;;
	#		*)
	#			echo "Skip..."
	#			;;
	#	esac
	#else
	#	wget -N "https://raw.githubusercontent.com/huanruomengyun/Termux-Tools/master/termux-config.sh" && chmod +x termux-config.sh
	#	echo -e "脚本更新为云端最新[ $sh_ver --> $sh_new_ver ]"
	#fi
#fi
if [ -f "$PREFIX/etc/tconfig/autoupdate" && ! -z ${sh_new_ver} ]; then
	wget -N "https://raw.githubusercontent.com/huanruomengyun/$name/$branch/termux-config.sh" -P $PREFIX/etc/tconfig/
	chmod +x $PREFIX/etc/tconfig/termux-config.sh
	echo -e "脚本已更新为最新版本[ $sh_ver --> $sh_new_ver ]"
fi

if [ -f "$PREFIX/etc/tconfig/autoupdate" && -z ${sh_new_ver} ]; then
	wget -N "gh.qingxu.ga/https://raw.githubusercontent.com/huanruomengyun/$name/$branch/termux-config.sh" -P $PREFIX/etc/tconfig/
	chmod +x $PREFIX/etc/tconfig/termux-config.sh
	echo -e "脚本已更新为最新版本[ $sh_ver --> $sh_new_ver ]"
fi

if [ $sh_ver=$sh_new_ver ]; then
	echo "脚本已为最新版本"
else
	echo "$sh_ver ->> $sh_new_ver" >> $PREFIX/etc/tconfig/logs/update_log.log
fi

mkdir -p $PREFIX/etc/tconfig
if [ -f /system/addon.d/*magisk* ]; then
	testsustatus=`green "MagiskSU"`
else
	testsustatus=`red "UNKOWN"`
fi
[[ -f "$PREFIX/etc/tconfig/aria2btauto" ]] && bash <(wget -qO- git.io/tracker.sh) $HOME/.aria2/aria2.conf >/dev/null

abort() {
	abort_echo=$1
	red "$abort_echo"
	exit 0
}

green "初始化完成!"
green "确认您的设备信息中……"
date=$(date)
log=log_init.log
mkdir -p $PREFIX/etc/tconfig/logs
rm -f $PREFIX/etc/tconfig/logs/*log_*.log
touch $PREFIX/etc/tconfig/logs/tmp_$log
echo -e "====Device info====\n" >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "Date:" >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "$date\n\n" >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "<----Props---->" >> $PREFIX/etc/tconfig/logs/tmp_$log
getprop >> $PREFIX/etc/tconfig/logs/tmp_$log
echo -e "\n\n" >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "<----System info---->" >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "Logged In users:" >> $PREFIX/etc/tconfig/logs/tmp_$log
whoami >> $PREFIX/etc/tconfig/logs/tmp_$log
echo $systeminfo >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "Package Installed" >> $PREFIX/etc/tconfig/logs/tmp_$log
pkg list-installed >> $PREFIX/etc/tconfig/logs/tmp_$log 2>/dev/null
echo -e "\n\n" >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "<----Hardware info---->" >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "CPU info:" >> $PREFIX/etc/tconfig/logs/tmp_$log
lscpu >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "Memory and Swap info:" >> $PREFIX/etc/tconfig/logs/tmp_$log
free -h >> $PREFIX/etc/tconfig/logs/tmp_$log
echo "Internet info:" >> $PREFIX/etc/tconfig/logs/tmp_$log
ifconfig >> $PREFIX/etc/tconfig/logs/tmp_$log 2>/dev/null
echo "Disk Usages :" >> $PREFIX/etc/tconfig/logs/tmp_$log
df -h >> $PREFIX/etc/tconfig/logs/tmp_$log
mv -f $PREFIX/etc/tconfig/logs/tmp_$log $PREFIX/etc/tconfig/logs/$log
green "系统信息确认完毕!!"
green "您马上就可以进入脚本!"
clear
bash $PREFIX/etc/tconfig/main/menu.sh