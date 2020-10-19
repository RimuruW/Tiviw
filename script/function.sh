#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

name="Tovow"
sh_ver="1.0.1"
ToolPATH="$PREFIX/etc/tconfig"

# Color configure
blue(){
	echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
	echo -e "\033[32m\033[01m$1\033[0m"
}
red(){
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

# Check
if [[ $EUID -eq 0 ]]; then
	red "检测到您正在尝试使用 ROOT 权限运行该脚本"
	red "这是不建议且不被允许的"
	red "该脚本不需要 ROOT 权限,且以 ROOT 权限运行可能会带来一些无法预料的问题"
	red "为了您的设备安全，请避免在任何情况下以 ROOT 用户运行该脚本"
	exit 1
fi
if [[ -d /system/app && -d /system/priv-app ]]; then
	systeminfo="Android $(getprop ro.build.version.release)"
else
	red "This operating system is not supported."
	exit 1
fi

source $ToolPATH/main/permission.sh

if [ ! -f "$ToolPATH/branch" ]; then
	branch="master"
else
	branch=$(cat $ToolPATH/branch)
fi

if [ ! -f "$PREFIX/bin/wget" ];then
	pkg in wget -y >/dev/null
fi

mkdir -p $ToolPATH
[[ ! -f "$ToolPATH/ok" ]] && bash $ToolPATH/main/script/init.sh
[[ -f "$ToolPATH/gh-proxy" ]] && ghproxy=$(cat $ToolPATH/gh-proxy)


# The most important functions
network_check() {
	echo "正在检查网络连接…"
	ping -c 1 baidu.com  > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		green "网络连接正常"
		return 0
	else
		red "无法连接到网络，请检查！"
		exit 1
	fi
}

network_check_sea() {
	network_check
	ping -c 1 google.com  > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		green "网络可用，不使用代理"
		return 0
	else
		red "网络连接受限，尝试启用代理"
		return 1
	fi
}


aria2_check() {
if [ -f "$PREFIX/bin/aria2c" ];then
	aria2status=`green "true"`
else
	aria2status=`red "false"`
fi
}

bilibilitools_check() {
if [ -f "$HOME/bilibilitools/main.py" ];then
	bilibilitoolstatus=`green "true"`
else
	bilibilitoolstatus=`red "false"`
fi
}

sudo_check() {
if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
	sudostatus=`green "true"`
else
	sudostatus=`red "false"`
fi
}

httpconfig_check() {
	if [ -f "/data/data/com.termux/files/usr/lib/node_modules/http-server/bin/http-server" ];then
		httpconfigstatus=`green "true"`
	else
		httpconfigstatus=`red "false"`
	fi
}

Enter=$(echo -en "\t\tEnter an option: ")
Step=$(echo -en "\n\n\t\t\t请回车以继续" && read -n 1 line)
Abort() {
	abort_echo=$1
	red "$abort_echo"
	exit 0
}

echo "校验完毕，请回车以启动脚本！"
clear
