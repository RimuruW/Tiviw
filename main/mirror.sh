#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (RimuruW)
# Description: Termux Tools
# Repository Address: https://github.com/RimuruW/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

if check_mirror; then
	mirrorsstatus="${GREEN}True${RESET}"
else
	mirrorsstatus="${RED}False${RESET}"
fi
if check_npm_mirror; then
	npmmirrorsstatus="${GREEN}True${RESET}"
else
	npmmirrorsstatus="${RED}False${RESET}"
fi
if check_pip_mirror; then
	pipmirrorsstatus="${GREEN}True${RESET}"
else
	pipmirrorsstatus="${RED}False${RESET}"
fi
mirrorschoose=null
echo -e "\n\n"
echo "Termux 镜像源状态：" $mirrorsstatus
echo "NPM 淘宝源状态:" $npmmirrorsstatus
echo "pip 清华源状态:" $pipmirrorsstatus
echo -e "\n\n"
echo "1 Termux 清华源配置"
sleep 0.016
echo "2 NPM 淘宝源配置"
sleep 0.016
echo "3 pip 清华源配置"
sleep 0.016
echo "0 退出"
echo -en "\t\tEnter an option: "
read mirrorschoose
case $mirrorschoose in
	1)
		[[ ! -z "mirrors_status" ]] && red "您已配置镜像源，无需进行该步骤" && return 0
		sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
		sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
		sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
		touch $ToolPATH/mirrorstatus
		apt update && apt upgrade -y
		source $ToolPATH/core/main/mirror.sh
		return 0
	;;
	2)
		if [[ ! -f "$PREFIX/bin/npm" ]]; then
			echo "${RED}[!]${RESET} Node.js 未安装！"
			if ask "是否安装 Node.js？" "Y"; then
				if check_apt_ability; then
					pkg i nodejs-lts -y
				else
					echo "${RED}[!]${RESET} 无法完成镜像源更换，请先安装 Node.js！" && source $ToolPATH/core/main/mirror.sh && return 1
				fi
			else
				echo "${RED}[!]${RESET} 无法完成镜像源更换，请先安装 Node.js！" && source $ToolPATH/core/main/mirror.sh && return 1
			fi
		fi
		echo "${BLUE}[*]${RESET} 尝试添加设置 NPM 镜像源…"
		npm config set registry https://registry.npm.taobao.org
		if check_npm_mirror; then
			echo "${GREEN}[✓]${RESET} NPM 镜像源已设置！"
		else
			echo "${RED}[!]${RESET} NPM 镜像源设置失败！请提交 bug 反馈至开发者！"
			exit 1
		fi
		source $ToolPATH/core/main/mirror.sh
		return 0
		;;
	3)
		if [[ ! -f "$PREFIX/bin/python" ]]; then
			echo "${RED}[!]${RESET} Python 未安装！"
			if ask "是否安装 Python？" "Y"; then
				if check_apt_ability; then
					pkg i python -y
				else
					echo "${RED}[!]${RESET} 无法完成镜像源更换，请先安装 Python！" && source $ToolPATH/core/main/mirror.sh && return 1
				fi
			else
				echo "${RED}[!]${RESET} 无法完成镜像源更换，请先安装 Python！" && source $ToolPATH/core/main/mirror.sh && return 1
			fi
		fi
		pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
		pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
		if check_pip_mirror; then
			echo "${GREEN}[✓]${RESET} pip 镜像源已设置！"
		else
			echo "${RED}[!]${RESET} pip 镜像源设置失败！请提交 bug 反馈至开发者！"
			exit 1
		fi
		source $ToolPATH/core/main/mirror.sh
		return 0
		;;
	0)
		return 0 ;;
	*)
		red "无效输入,请重试"
		mirrorschoose=null
		source $ToolPATH/core/main/mirror.sh
		return 1
	 ;;
esac

