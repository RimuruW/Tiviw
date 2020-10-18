sudo_check
echo -e "\n\n"
echo -e "sudo 安装状态:" $sudostatus
echo -e "\n\n"
echo -e "1 安装 sudo\n"
echo -e "2 卸载 sudo\n"
echo -e "0 退出\n"
echo -en "\t\tEnter an option: "
read sudoinstall
case $sudoinstall in
	1)
		if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
			blue "您已安装 sudo,请勿重复安装"
			source $ToolPATH/main/termuxplugin/sudo.sh
		fi
		git clone https://gitlab.com/st42/termux-sudo.git $HOME/termux-sudo
		cat $HOME/termux-sudo/sudo > /data/data/com.termux/files/usr/bin/sudo
		chmod 700 /data/data/com.termux/files/usr/bin/sudo
		if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
			green "sudo 已成功安装到了您的 Termux"
		else
			green "脚本运行失败!请检查网络连接或提交日志"
		fi
		echo "安装脚本运行完毕"
		source $ToolPATH/main/termuxplugin/menu.sh
		;;
	2)
		if [ ! -f "/data/data/com.termux/files/usr/bin/sudo" ];then
			red "您并未安装 sudo"
		fi
		rm -f /data/data/com.termux/files/usr/bin/sudo
		if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
			red "sudo 卸载失败!"
		else
			green "sudo 卸载成功!"
		fi
		source $ToolPATH/main/termuxplugin/menu.sh
		;;
	0)
		source $ToolPATH/main/termuxplugin/menu.sh
		;;
	*)
		red "无效输入!"
		source $ToolPATH/main/termuxplugin/sudo.sh
		;;
esac
