#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

mirrors_status=$(cat $PREFIX/etc/apt/sources.list | grep "mirror" | grep -v '#')
if [ ! -z "$mirrors_status" ]; then
	mirrorsstatus=`green "true"`
else
	mirrorsstatus=`red "false"`
fi
if [ -f "$ToolPATH/npmmirrorsstatus" ]; then
	npmmirrorsstatus=`green "true"`
else
	npmmirrorsstatus=`red "false"`
fi
if [ -d $HOME/.pip ]; then
	pipmirrorsstatus=`green "true"`
else
	pipmirrorsstatus=`red "false"`
fi
echo -e "\n\n"
echo "Termux 镜像源状态：" $mirrorsstatus
echo "NPM 淘宝源状态:" $npmmirrorsstatus
echo "pip 清华源状态:" $pipmirrorsstatus
echo -e "\n\n"
echo "1 Termux 清华源"
sleep 0.016
echo "2 NPM 淘宝源"
sleep 0.016
echo "3 pip 清华源"
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
	;;
	2)
		[[ ! -f "$PREFIX/bin/npm" ]] && red "请先安装 Node.js" && return 0
		npm config set registry https://registry.npm.taobao.org
		touch $ToolPATH/npmmirrorsstatus
		;;
	3)
		[[ ! -f "$PREFIX/bin/python" ]] && red "请先安装 Python " && return 0
		[[ -d $HOME/.pip ]] && red "您已添加镜像源，无需重复添加" && return 0
		mkdir -p ~/.pip/
		echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple\n[install]\ntrusted-host=mirrors.aliyun.com" > ~/.pip/pip.conf
		;;
	0)
		return 0 ;;
	*)
		red "无效输入,请重试"
		bash $ToolPATH/main/script/mirror.sh
	 ;;
esac

