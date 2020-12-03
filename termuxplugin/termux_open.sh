rm -f $PREFIX/etc/motd.tmp
if [ -f "$HOME/.hushlogin" ];then
	hushloginstatus=`green "已关闭"`
else
	hushloginstatus=`red "未关闭"`
fi
if [ -f "$PREFIX/etc/termuxopen" ];then
	termuxloginstatus=`green "已修改"`
else
	termuxloginstatus=`red "未修改"`
fi
[[ ! -f "$PREFIX/etc/motd.init" ]] && cp $PREFIX/etc/motd $PREFIX/etc/motd.init
etermuxopen=null
echo -e "\n\n"
echo -e "问候语状态:"
echo -e "问候语" $hushloginstatus
echo -e "问候语" $termuxloginstatus
echo -e "\n\n"
echo -e "1 使用编辑器编辑[适合有 Linux 使用经验的用户,默认使用 vim]\n"
sleep 0.016
echo -e "2 使用简易编辑器进行修改[适合纯新手]\n"
sleep 0.016
echo -e "3 查看当前启动问候语\n"
sleep 0.016
echo -e "4 恢复默认启动问候语\n"
sleep 0.016
echo -e "5 关闭问候语\n"
sleep 0.016
echo -e "6 开启问候语\n"
sleep 0.016
echo -e "0 退出\n"
sleep 0.016
echo -en "\t\tEnter an option: "
read etermuxopen
case $etermuxopen in
	1)
		if [ ! -f "$PREFIX/etc/motd.bak" ];then
			mv $PREFIX/etc/motd $PREFIX/etc/motd.bak
		else
			rm -f $PREFIX/etc/motd
			touch $PREFIX/etc/motd
		fi
		vim $PREFIX/etc/motd
		if [ ! -f "$PREFIX/etc/motd" ];then
			mv $PREFIX/etc/motd.bak $PREFIX/etc/motd
		else
			touch $PREFIX/etc/termuxopen
		fi
		source $ToolPATH/core/termuxplugin/termux_open.sh && return 0 ;;
	2)
		if [ ! -f "$PREFIX/etc/motd.bak" ];then
			mv $PREFIX/etc/motd $PREFIX/etc/motd.bak
		fi
		echo -e "\n请在下方直接输入您想要更换的启动问候语\n可以直接回车换行,输入 wq 保存退出,输入 q 直接退出\n"
		while [ 1 ]
		do
			echo -en "\033[34m\033[01m--> ~  \033[0m"
			read texttermuxopen
			case $texttermuxopen in
				wq)
					green "已保存"
					if [ ! -f "$PREFIX/etc/motd.bak" ];then
						mv $PREFIX/etc/motd $PREFIX/etc/motd.bak
						mv $PREFIX/etc/motd.tmp $PREFIX/etc/motd
					else
						rm -f $PREFIX/etc/motd.bak
						mv $PREFIX/etc/motd $PREFIX/etc/motd.bak
						mv $PREFIX/etc/motd.tmp $PREFIX/etc/motd
					fi
					touch $PREFIX/etc/termuxopen
					green "修改完成!"
					source $ToolPATH/core/termuxplugin/termux_open.sh
					return 0 ;;
				q)
					rm -f $PREFIX/etc/motd.tmp
					echo "已退出"
					source $ToolPATH/core/termuxplugin/termux_open.sh
					return 0
					;;
				*)
					echo -e "$texttermuxopen" >> $PREFIX/etc/motd.tmp
					;;
			esac
		done
		;;
	3)
		cat $PREFIX/etc/motd
		source $ToolPATH/core/termuxplugin/termux_open.sh
		return 0 ;;
	4)
		if [ ! -f "$PREFIX/etc/termuxopen" ];then
			red "问候语已为默认状态"
			source $ToolPATH/core/termuxplugin/termux_open.sh
			return 0
		fi
		if [ -f "$PREFIX/etc/motd.init" ];then
			rm -f $PREFIX/etc/motd
			cp $PREFIX/etc/motd.init $PREFIX/etc/motd
			rm -f $PREFIX/etc/termuxopen
			green "恢复成功!"
		else
			red "备份丢失,默认问候语恢复失败!!"
		fi
		source $ToolPATH/core/termuxplugin/termux_open.sh
		return 0
		;;
	5)
		if [ -f "$HOME/.hushlogin" ];then
			red "您已关闭问候语,无需重复关闭"
			source $ToolPATH/core/termuxplugin/termux_open.sh && return 0
		fi
		touch ~/.hushlogin
		if [ ! -f "$HOME/.hushlogin" ];then
			red "问候语关闭失败!"
			source $ToolPATH/core/termuxplugin/termux_open.sh && return 0
		fi
		green "问候语关闭成功!"
		source $ToolPATH/core/termuxplugin/termux_open.sh
		return 0
		;;
	6)
		if [ ! -f "$HOME/.hushlogin" ];then
			red "您已开启问候语,无需重复关闭"
			source $ToolPATH/core/termuxplugin/termux_open.sh && return 0
		fi
		rm -f  $HOME/.hushlogin
		if [ -f "$HOME/.hushlogin" ];then
			red "问候语开启失败!"
			source $ToolPATH/core/termuxplugin/termux_open.sh
		fi
		green "问候语开启成功!"
		source $ToolPATH/core/termuxplugin/termux_open.sh && return 0
		;;
	0)
		source $ToolPATH/core/termuxplugin/menu.sh && return 0 ;;
	*)
	    red "无效输入，请重试！"
	    etermuxopen=null ;;
esac
