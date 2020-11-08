#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

name="Tiviw"
sh_ver="1.0.2"
ver_code=20201108
ToolPATH="$PREFIX/etc/tiviw"

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

RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')

# Check
if [[ $EUID -eq 0 ]]; then
	red "检测到您正在尝试使用 ROOT 权限运行该脚本"
	red "这是不建议且不被允许的"
	red "该脚本不需要以 ROOT 权限直接启动，且以 ROOT 权限直接启动可能会带来一些无法预料的问题"
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

branch=$(cd $PREFIX/etc/tiviw/main && git branch |grep "*" | awk -F " " '{print $NF}')

dev_auto_update() {
	red "您正在使用 dev 分支！"
	red "dev 分支强制开启自动更新以避免异常。"
	red "如果您不希望自动更新，请在「关于脚本」-「切换分支」处切换 master 分支"
	echo "开始检查云端版本号…"
	remote_ver=$(curl -s https://raw.githubusercontent.com/QingxuMo/Tiviw/dev/script/function.sh | grep -v "#" | grep "ver_code=" | awk -F "=" '{print $NF}')
	if [ $remote_ver > $ver_code ]; then
		green "云端版本高于本地版本，开始强制自动更新…"
		tiviw_update
	else
		green "本地已为最新版本！"
	fi
}

if [ $branch = master ]; then
	VERSION="v$sh_ver"
else
	VERSION="$ver_code"
	dev_auto_update
fi

if [ ! -f "$PREFIX/bin/wget" ];then
	red "警告，wget 未安装！"
	blue "wget 是 Linux 平台一个轻量便捷的下载工具"
	blue "本脚本大量功能依赖 wget 实现"
	green "尝试安装 wget…"
	if check_apt_ability; then
		pkg in wget -y >/dev/null
	else
		red "警告！无法完成 wget 安装！"
	fi
	if [ ! -f "$PREFIX/bin/wget" ];then
		red "警告！wget 未安装！"
		red "脚本强制中止"
		exit 1
	fi

fi

mkdir -p $ToolPATH
[[ ! -f "$ToolPATH/ok" ]] && bash $ToolPATH/main/script/init.sh

# The most important functions
network_check() {
	echo "正在检查网络连接…"
	ping -c 1 baidu.com  > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		green "网络已连接"
		return 0
	else
		red "无法连接到网络，请检查！"
		exit 1
	fi
}

network_check_sea() {
	network_check
	green "尝试检查网络可用性…"
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

adbconfig_check() {
	if [ -f "/data/data/com.termux/files/usr/bin/adb.bin" ];then
		adbconfigstatus=`green "true"`
	else
		adbconfigstatus=`red "false"`
	fi
}

youget_check() {
	if [ -f "/data/data/com.termux/files/usr/bin/you-get" ];then
		yougetconfigstatus=`green "true"`
		return 0
	else
		yougetconfigstatus=`red "false"`
		return 1
	fi
}

python_check() {
	if [ ! -f "/data/data/com.termux/files/usr/bin/python" ];then
		return 1
	else
		return 0
	fi
}

mirror_check() {
mirrors_status=$(cat $PREFIX/etc/apt/sources.list | grep "mirror" | grep -v '#')
if [ ! -z "$mirrors_status" ]; then
	mirrorsstatus=`green "true"`
	return 0
else
	mirrorsstatus=`red "false"`
	return 1
fi
}

npm_mirror_check() {
if [ -f "$ToolPATH/npmmirrorsstatus" ]; then
	npmmirrorsstatus=`green "true"`
	return 0
else
	npmmirrorsstatus=`red "false"`
	return 1
fi
}

pip_mirror_check() {
if [ -d $HOME/.pip ]; then
	pipmirrorsstatus=`green "true"`
	return 0
else
	pipmirrorsstatus=`red "false"`
	return 1
fi
}

check_apt_ability() {
	if mirror_check; then
		green "Termux 镜像源已配置"
		return 0
	else
		if network_check_sea; then
			return 0
		else
			red "根据检测结果，脚本认定你当前网络环境无法完成安装！"
			red "对于国内用户，请配置镜像源以完成安装！"
			blue "是否跳转到 Termux 镜像源配置？[y/n]"
			Enter
			read MIRROR_CHOOSE
			case $MIRROR_CHOOSE in
				y)
					source $ToolPATH/main/script/mirror.sh
					;;
				*)
					red "跳过镜像源配置！"
					red "警告，根据网络环境和镜像源配置检测结果，脚本认为你无法完成安装！"
					red "安装强制中止！"
					Step
					return 1
					;;
			esac
		fi
	fi
}

check_pip_ability() {
	if python_check; then
		green "Python 已安装"
	else
		red "Python 未安装！"
		blue "是否安装 Python？[y/n]"
		Enter
		read PYTHON_INSTALL_CHOOSE
		case $PYTHON_INSTALL_CHOOSE in
			y)
				if check_apt_ability; then
					pkg in python -y
					if python_check; then
						green "Python 安装成功！"
					else
						red "Python 未安装成功，请检查网络连接！"
						Step
					fi
				else
					red "无法完成 Python 安装！"
					Step
					return 1
				fi
				;;
			n)
				red "拒绝安装 Python！"
				Step
				return 1
				;;
			*)
				red "无效输入！"
				Step
				return 1
				;;
		esac				
	fi
	if pip_mirror_check; then
		return 0
	else
		if network_check_sea; then
			return 0
		else
			red "根据检测结果，脚本认定你当前网络环境无法完成安装！"
			red "对于国内用户，请配置镜像源以完成安装！"
			blue "是否跳转到 PIP 镜像源配置？[y/n]"
			Enter
			read PIP_MIRROR_CHOOSE
			case $PIP_MIRROR_CHOOSE in
				y)
					source $ToolPATH/main/script/mirror.sh
					;;
				n)
					red "跳过镜像源配置！"
					red "警告，根据网络环境和镜像源配置检测结果，脚本认为你无法完成安装！"
					red "安装强制中止！"
					Step
					return 1
					;;
				*)
					red "无效输入，请重试！"
					Step
					return 1
					;;
			esac
		fi
	fi
}

youget_download() {
	echo -e "\n\n"
	echo "you-get 支持的链接种类: https://github.com/soimort/you-get/wiki/%E4%B8%AD%E6%96%87%E8%AF%B4%E6%98%8E#%E6%94%AF%E6%8C%81%E7%BD%91%E7%AB%99"
	echo "you-get 也可以下载网页上的视频和图片"
	echo -e "请输入您的下载链接[必填]"
	echo -en "\t\tEnter: "
	read yougetlink
	echo -e "请输入您的下载路径[选填,路径默认指向内置存储.比如，如果您输入 Download，则文件会下载至内置存储的 Download 文件夹中]"
	green "看不懂就直接回车"
	echo -en "\t\tEnter: "
	read tmpdiryouget
	echo -e "如果您输入的链接属于某一播放列表里面的一个,您是否想下载该列表里面的所有视频?[y/n]"
	green "看不懂就直接回车"
	echo -en "\t\tEnter: "
	read tmpyougetlist
	case $tmpyougetlist in
		y*)
			yougetlist=--playlist
			;;
		*)
			:
			;;
	esac
	yougetdownloaddir=/sdcard/$tmpdiryouget
	mkdir -p $yougetdownloaddir
	blue "下载即将开始..."
	you-get -o $yougetdownloaddir $yougetlist $yougetlink
	green "下载已停止！"
	green "这可能是因为所需下载内容已下载完毕，或者下载中断"
}

remote_status() {
	git remote -v | grep "https://github.com/QingxuMo/Tiviw"
	if [ $? -eq 0 ]; then
		green "远程仓库地址为源地址!"
		return 0
	else
		red "远程仓库地址异常！"
		return 1
	fi
}

update_remote_status() {
	git remote -v | grep "https://github.com.cnpmjs.org/QingxuMo/Tiviw"
	if [ $? -eq 0 ]; then
		green "远程仓库地址修改成功!"
	else
		red "远程仓库地址修改失败！"
	fi
}

update_tiviw() {
	if network_check_sea; then
		cd $ToolPATH/main
		git pull 2>/dev/null
		cp tiviw $PREFIX/bin/tiviw
		green "已拉取最新版本！"
		green "请重启脚本以应用更新！"
	else
		cd $ToolPATH/main
		git remote set-url origin https://github.com.cnpmjs.org/QingxuMo/Tiviw
		if update_remote_status; then
			green "尝试拉取最新版本…"
			git checkout . && git clean -xd
			git pull 2>/dev/null
			cp tiviw $PREFIX/bin/tiviw
			green "拉取结束！"
			green "请重启脚本以应用更新！"
		else
			red "仍然尝试拉起最新版本…"
			red "拉取可能会失败！"
			git checkout . && git clean -xd
			git pull 2>/dev/null
			cp tiviw $PREFIX/bin/tiviw
			green "拉取结束！"
			green "请重启脚本以应用更新！"
		fi
		git remote set-url origin https://github.com/QingxuMo/Tiviw
		if remote_status; then
			green "远程仓库地址恢复成功！"
		else
			red "请手动输入 cd $ToolPATH/main && git remote set-url origin https://github.com/QingxuMo/Tiviw 恢复远程仓库地址"
			red "提交该界面截图至开发者以帮助开发者解决该问题！"
			exit 1
		fi
	fi
	cd $HOME
}

Enter() {
echo -en "\t\tEnter an option: "
}

Step() {
echo -en "\n\n\t\t\t请回车以确认"
read -n 1 line
}

sp() {
echo -e "\n"
}

Abort() {
	abort_echo=$1
	red "$abort_echo"
	exit 0
}

clear
