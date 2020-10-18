#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

if [ ! -d "$HOME/storage/shared/Android" ]; then
	termux-setup-storage
	if [ -d "$HOME/storage/shared/Android" ]; then
		green "存储权限获取成功！"
		step
	else
		red "存储权限获取失败！"
		step
	fi
else
	red "您已获取存储权限，是否继续操作？[y/n]"
	echo -en "\t\tEnter an option: "
	read STORAGE_SETUP
	case $STORAGE_SETUP in
		y)
			termux-setup-storage
			;;
		n)
			blue "已取消…"
			step
			;;
		*)
			blue "默认跳过…"
			step
			;;
	esac
fi
