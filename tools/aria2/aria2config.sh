#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

aria2_check
echo -e "\n\n"
echo "项目地址: https://github.com/QingxuMo/Aria2-Termux"
echo -e "\n\n"
echo "Aria2 安装状态: " $aria2status
echo -e "\n\n"
echo -e "1 Aria2 安装与管理\n"
sleep 0.016
echo -e "2 AriaNG 启动\n"
sleep 0.016
echo "0 退出"
sleep 0.016
echo -en "\t\tEnter an option: "
read aria2choose
case $aria2choose in
	1)
		[[ ! -f "$PREFIX/etc/tiviw/aria2.sh" ]] && wget -P $PREFIX/etc/tiviw https://raw.githubusercontent.com/QingxuMo/Aria2-Termux/master/aria2.sh && chmod +x $PREFIX/etc/tiviw/aria2.sh
		[[ ! -f "$PREFIX/etc/tiviw/aria2.sh" ]] && wget -P $PREFIX/etc/tiviw gh.qingxu.ga/https://raw.githubusercontent.com/QingxuMo/Aria2-Termux/master/aria2.sh && chmod +x $PREFIX/etc/tiviw/aria2.sh
		[[ ! -f "$PREFIX/etc/tiviw/aria2.sh" ]] && red "Aria2 安装脚本下载失败，请检查网络连接状态" &&  echo "请回车确认" && read -n 1 line  && source $PREFIX/etc/tiviw/main/tools/aria2/aria2config.sh
		bash $PREFIX/etc/tiviw/aria2.sh
		;;
	2)
		source $PREFIX/etc/tiviw/main/tools/aria2/ariang.sh ;;
	0)
		return 0 ;;
	*)
		red "无效输入，请重试"
		source $PREFIX/etc/tiviw/main/tools/aria2/aria2config.sh
		;;
esac
