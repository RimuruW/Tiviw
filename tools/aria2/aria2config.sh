#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

aria2_check
if [ -f "$PREFIX/etc/tiviw/aria2/aria2.sh" ];then
	aria2termuxstatus=`green "true"`
else
	aria2termuxstatus=`red "false"`
fi
echo -e "\n\n"
echo -e "Aria2 是一个强大的多功能下载器，Aria2-Termux 是面向 Android 且深度适配 Termux 的强大的 Aria2 一键安装与管理脚本\n"
echo -e "项目地址: https://github.com/QingxuMo/Aria2-Termux"
echo -e "\n\n"
echo "Aria2 安装状态: " $aria2status
echo "Aria2-Termux 安装状态: " $aria2termuxstatus
echo -e "\n\n"
echo -e "1 Aria2-Termux\n"
sleep 0.016
echo -e "2 Aria2-Termux 更新\n"
sleep 0.016
echo -e "3 Aria2-Termux 回退版本(如果更新 Aria2-Termux 后出现异常请选择此选项)\n"
sleep 0.016
echo -e "3 AriaNG 启动\n"
sleep 0.016
echo "0 退出"
sleep 0.016
echo -en "\t\tEnter an option: "
read aria2choose
case $aria2choose in
	1)
		[[ ! -f "$PREFIX/etc/tiviw/aria2/aria2.sh" ]] && mkdir -p $PREFIX/etc/tiviw/aria2 && wget -P $PREFIX/etc/tiviw/aria2 https://raw.githubusercontent.com/QingxuMo/Aria2-Termux/master/aria2.sh && chmod +x $PREFIX/etc/tiviw/aria2/aria2.sh
		[[ ! -f "$PREFIX/etc/tiviw/aria2/aria2.sh" ]] && red "Aria2 安装脚本下载失败，请检查网络连接状态" &&  echo "请回车确认" && read -n 1 line  && source $PREFIX/etc/tiviw/main/tools/aria2/aria2config.sh && return 1
		bash $PREFIX/etc/tiviw/aria2/aria2.sh
		;;
	2)
		if network_check, then
			    if [ -f "$PREFIX/etc/tiviw/aria2.sh.bak2" ]; then
				    rm -f $PREFIX/etc/tiviw/aria2.sh.bak2
			    fi
			    if [ -f "$PREFIX/etc/tiviw/aria2.sh.bak" ]; then
				    mv $PREFIX/etc/tiviw/aria2.sh.bak $PREFIX/etc/tiviw/aria2.sh.bak2
			    fi
			mv $PREFIX/etc/tiviw/aria2/aria2.sh $PREFIX/etc/tiviw/aria2/aria2.sh.bak
			wget -P $PREFIX/etc/tiviw/aria2 https://raw.githubusercontent.com/QingxuMo/Aria2-Termux/master/aria2.sh && chmod +x $PREFIX/etc/tiviw/aria2/aria2.sh
			if [ -f $PREFIX/etc/tiviw/aria2/aria2.sh ]; then
				green "更新成功！"
			else
				red "更新失败！"
			fi
		else
			red "网络连接异常！"
			source $PREFIX/etc/tiviw/main/tools/aria2/aria2config.sh && return 1
		fi
		;;
	3)
		echo "检测到备份文件如下:"
		echo $(ls $PREFIX/etc/tiviw/aria2 | grep "bak")
		blue "aria2.sh.bak 代表上一次更新前本地版本\naria2.sh.bak2（如果存在）为上上次更新前本地版本"
		echo -en "请选择你要恢复的版本:"
		read $aria2termuxversion
		[[ -z $(echo $aria2termuxversion | grep "aria2.sh.bak") ]] && red "无效输入！" && source $PREFIX/etc/tiviw/main/tools/aria2/aria2config.sh && return 1
		mv -f $PREFIX/etc/tiviw/aria2/$aria2termuxversion $PREFIX/etc/tiviw/aria2/aria2.sh
		green "执行完成"
		;;

	4)
		source $PREFIX/etc/tiviw/main/tools/aria2/ariang.sh ;;
	0)
		return 0 ;;
	*)
		red "无效输入，请重试"
		source $PREFIX/etc/tiviw/main/tools/aria2/aria2config.sh
		;;
esac
