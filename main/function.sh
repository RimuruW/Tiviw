#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

name="Tiviw"
export name
sh_ver="1.0.4"
ver_code=202012100205
ToolPATH="$PREFIX/etc/tiviw"

if [ -t 1 ]; then
	RED=$(printf	'\033[31m')
	GREEN=$(printf	'\033[32m')
	YELLOW=$(printf '\033[33m')
	BLUE=$(printf	'\033[34m')
	LIGHT=$(printf	'\033[1;96m')
	RESET=$(printf	'\033[0m')
else
	RED=""
	GREEN=""
	YELLOW=""
	BLUE=""
	LIGHT=""
	RESET=""
fi

red() {
	echo -e "${RED}$1${RESET}"
}

green() {
	echo -e "${GREEN}$1${RESET}"
}

yellow() {
	echo -e "${YELLOW}$1${RESET}"
}

blue() {
	echo -e "${BLUE}$1${RESET}"
}

light() {
	echo -e "${LIGHT}$1${RESET}"
}

ask() {
    # http://djm.me/ask
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question
		printf '%s\n' "${LIGHT}"
        printf "[?] "
        read -r -p "$1 [$prompt] " REPLY

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

		printf '%s\n' "${RESET}"

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}
 
# Check
if [[ $EUID -eq 0 ]]; then
	red "
[!] 检测到您正在尝试使用 ROOT 权限运行该脚本
[!] 这是不建议且不被允许的
[!] 该脚本不需要以 ROOT 权限直接启动，且以 ROOT 权限直接启动可能会带来一些无法预料的问题
[!] 为了您的设备安全，请避免在任何情况下以 ROOT 用户运行该脚本
	"
	exit 1
fi
if [[ -d /system/app && -d /system/priv-app ]]; then
	systeminfo="Android $(getprop ro.build.version.release)"
	export systeminfo
else
	red "This operating system is not supported."
	exit 1
fi

if [ "$(uname -o)" != "Android" ]; then
	PREFIX=/data/data/com.termux/files/usr
fi

source "$ToolPATH/core/permission.sh"

check_dependency() {
        blue "[*] 检查依赖中…"
		apt-get update -y &> /dev/null
		for i in $1; do
			if apt list --installed 2>/dev/null | grep "$i"; then
				echo "${GREEN}[√]${RESET}  $i 已安装！"
			else
				echo  "Installing $i..."
				apt-get install -y "$i" || {
					red "
[!] 依赖安装失败!
[*] 退出中……
									"
									exit 1
								}
			fi
		done
		apt-get upgrade -y
}

mkdir -p "$ToolPATH"
[[ ! -f "$ToolPATH/ok" ]] && bash "$ToolPATH/core/main/init.sh"

network_check() {
	echo "正在检查网络连接…"
	if ping -q -c 1 -W 1 baidu.com >/dev/null; then
		green "[√] 网络已连接"
		return 0
	else
		red "[!] 网络未连接！"
		exit 1
	fi
}

network_check_sea() {
	network_check
	green "[*] 尝试检查网络可用性…"
	if ping -q -c 1 -W 1 google.com >/dev/null; then
		green "[✓] 网络可用！"
		return 0
	else
		red "[!] 网络不可用，尝试启用代理！"
		return 1
	fi
}

remote_status() {
	if git remote -v | grep "https://github.com/QingxuMo/Tiviw"; then
		green "[√] 远程仓库地址为源地址!"
		return 0
	else
		red "[!] 远程仓库地址异常！"
		return 1
	fi
}

update_remote_status() {
	if git remote -v | grep "https://gitee.com/QingxuMo/tiviw"; then
		green "[√] 远程仓库地址修改成功!"
	else
		red "[!] 远程仓库地址修改失败！"
	fi
}

update_tiviw() {
	if network_check_sea; then
		cd "$ToolPATH/main" || { red "[!] 目录跳转失败！" >&2;  exit 1; }
		git pull 2>/dev/null
		cp tiviw $PREFIX/bin/tiviw
		green "
[*] 已拉取最新版本！
[*] 请重启脚本以应用更新！
		"
	else
		cd "$ToolPATH/core" || { red "[!] 目录跳转失败！" >&2;  exit 1; }
		git remote set-url origin https://gitee.com/QingxuMo/tiviw
		if update_remote_status; then
			green "[*] 尝试拉取最新版本…"
			git checkout . && git clean -xd -f
			git pull 2>/dev/null
			cp tiviw $PREFIX/bin/tiviw
			green "[*] 拉取结束！"
			green "[*] 请重启脚本以应用更新！"
		else
			red "[*] 仍然尝试拉起最新版本…"
			red "	 拉取可能会失败！"
			git checkout . && git clean -xd -f
			git pull 2>/dev/null
			cp tiviw $PREFIX/bin/tiviw
			green "[*] 拉取结束！"
			green "[*] 请重启脚本以应用更新！"
		fi
		git remote set-url origin https://github.com/QingxuMo/Tiviw
		if remote_status; then
			green "[√] 远程仓库地址恢复成功！"
		else
			red "
[!] 远程仓库地址恢复失败！
请手动输入 cd $ToolPATH/main && git remote set-url origin https://github.com/QingxuMo/Tiviw 恢复远程仓库地址
提交该界面截图至开发者以帮助开发者解决该问题！
"
			exit 1
		fi
	fi
	cd "$HOME" || { red "[!] 目录跳转失败!" >&2;  exit 1; }
}

branch=$(cd $PREFIX/etc/tiviw/core && git branch |grep "\*" | awk -F " " '{print $NF}')

dev_auto_update() {
	red "您正在使用 dev 分支！"
	red "dev 分支强制开启自动更新以避免异常。"
	red "如果您不希望自动更新，请在「关于脚本」-「切换分支」处切换 master 分支"
	echo "开始检查云端版本号…"
	remote_ver=$(curl -s https://raw.githubusercontent.com/QingxuMo/Tiviw/dev/main/function.sh | grep -v "#" | grep "ver_code=" | awk -F "=" '{print $NF}' | sed 's/\"//g' | head -1)
	[[ -z "$remote_ver" ]] && remote_ver=$(curl -s https://gitee.com/QingxuMo/tiviw/raw/dev/main/function.sh | grep -v "#" | grep "ver_code=" | awk -F "=" '{print $NF}' | sed 's/\"//g' | head -1)
	if [ "$remote_ver" -gt "$ver_code" ]; then
		green "云端版本大于本地版本，开始强制覆盖更新…"
		green "云端版本号：$remote_ver"
		green "本地版本号：$ver_code"
		update_tiviw
	else
		green "本地已为最新版本！"
		sleep 1
		clear
	fi
}

youget_check() {
	if [ -f "/data/data/com.termux/files/usr/bin/you-get" ];then
		yougetconfigstatus=$(green "true")
		return 0
	else
		yougetconfigstatus=$(red "false")
		return 1
	fi
	export yougetconfigstatus
}

python_check() {
	if [ ! -f "/data/data/com.termux/files/usr/bin/python" ];then
		return 1
	else
		return 0
	fi
}

mirror_check() {
mirrors_status=$(grep "mirror" $PREFIX/etc/apt/sources.list | grep -v '#')
if [ -n "$mirrors_status" ]; then
	mirrorsstatus=$(green "true")
	return 0
else
	mirrorsstatus=$(red "false")
	return 1
fi
	export mirrorsstatus
}

npm_mirror_check() {
if [ -f "$ToolPATH/npmmirrorsstatus" ]; then
	npmmirrorsstatus=$(green "true")
	return 0
else
	npmmirrorsstatus=$(red "false")
	return 1
fi
	export npmmirrorsstatus
}

pip_mirror_check() {
if [ -d "$HOME/.pip" ]; then
	pipmirrorsstatus=$(green "true")
	return 0
else
	pipmirrorsstatus=$(red "false")
	return 1
fi
	export pipmirrorsstatus
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
			read -r MIRROR_CHOOSE
			case $MIRROR_CHOOSE in
				y)
					source "$ToolPATH/core/main/mirror.sh"
					return 0
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
		read -r PYTHON_INSTALL_CHOOSE
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
			read -r PIP_MIRROR_CHOOSE
			case $PIP_MIRROR_CHOOSE in
				y)
					source "$ToolPATH/core/main/mirror.sh"
					return 0
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
	echo "you-get 支持的链接种类: ${GREEN}https://github.com/soimort/you-get/wiki/%E4%B8%AD%E6%96%87%E8%AF%B4%E6%98%8E#%E6%94%AF%E6%8C%81%E7%BD%91%E7%AB%99${RESET}"
	echo "${BLUE}[*]${RESET} you-get 也可以下载网页上的视频和图片"
	echo -e "请输入您的下载链接[必填]"
	echo -en "\t\tEnter: "
	read -r yougetlink
	echo -e "请输入您的下载路径[选填,路径默认指向内置存储.比如，如果您输入 Download，则文件会下载至内置存储的 Download 文件夹中]"
	green "看不懂就直接回车"
	echo -en "\t\tEnter: "
	read -r tmpdiryouget
	echo -e "如果您输入的链接属于某一播放列表里面的一个,您是否想下载该列表里面的所有视频?[y/n]"
	green "看不懂就直接回车"
	echo -en "\t\tEnter: "
	read -r tmpyougetlist
	case $tmpyougetlist in
		y*)
			yougetlist=--playlist
			;;
		*)
			:
			;;
	esac
	yougetdownloaddir=/sdcard/$tmpdiryouget
	mkdir -p "$yougetdownloaddir"
	blue "下载即将开始..."
	you-get -o "$yougetdownloaddir" "$yougetlist" "$yougetlink"
	green "下载已停止！"
	green "这可能是因为所需下载内容已下载完毕，或者下载中断"
}

if [ "$branch" = master ]; then
	VERSION="v$sh_ver"
else
	VERSION="$ver_code"
	dev_auto_update
fi
export VERSION
Enter() {
echo -en "\t\tEnter an option: "
}

Step() {
echo -en "\n\n\t\t\t请回车以确认"
read -r -n 1 line
}

sp() {
echo -e "\n"
}

Abort() {
	abort_echo=$1
	red "$abort_echo"
	exit 0
}

[[ $branch = master ]] && clear
