#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

name="Tovow"
sh_ver="1.0.1"

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
	exit 1
fi
if [[ -d /system/app && -d /system/priv-app ]]; then
	systeminfo="Android $(getprop ro.build.version.release)"
else
	red "This operating system is not supported."
	exit 1
fi

green "检查基础配置中…"

ToolPATH=$PREFIX/etc/tconfig

if [ ! -f "$PREFIX/etc/tconfig/branch" ]; then
	branch="master"
else
	branch=$(cat $PREFIX/etc/tconfig/branch)
fi

if [ ! -f "$PREFIX/bin/wget" ];then
	pkg in wget -y >/dev/null
fi


mkdir -p $ToolPATH

[[ ! -f "$PREFIX/etc/tconfig/ok" ]] && bash $PREFIX/etc/tconfig/main/script/init.sh
[[ -f "$PREFIX/etc/tconfig/gh-proxy" ]] && ghproxy=$(cat $PREFIX/etc/tconfig/gh-proxy)

abort() {
	abort_echo=$1
	red "$abort_echo"
	exit 0
}

step=$(echo -en "\n\n\t\t\t请回车以继续" && read -n 1 line)


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