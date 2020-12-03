sudo_check() {
if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
	sudostatus=$(green "true")
else
	sudostatus=$(red "false")
fi
}
sudo_check
sudoinstall=null
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
			Step
			source $ToolPATH/core/termuxplugin/sudo.sh
			return 1
		fi
		if network_check; then
			mkdir $ToolPATH/termuxplugin/termux-sudo
			wget -O $ToolPATH/termuxplugin/termux-sudo/sudo https://one.qingxu.ga/onedrive/Termux/Tiviw/termux-sudo/sudo.bin
			cat $ToolPATH/termuxplugin/termux-sudo/sudo > /data/data/com.termux/files/usr/bin/sudo
			chmod 700 /data/data/com.termux/files/usr/bin/sudo
		else
		    Step
			red "请连接网络后安装 sudo"
		fi
		if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
			green "sudo 已成功安装到了您的 Termux"
		else
			green "脚本运行失败!请检查网络连接或提交日志"
		fi
		echo "安装脚本运行完毕"
		Step
		source $ToolPATH/core/termuxplugin/menu.sh
		return 0
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
		Step
		source $ToolPATH/core/termuxplugin/menu.sh
		return 0
		;;
	0)
		source $ToolPATH/core/termuxplugin/menu.sh
		return 0
		;;
	*)
		red "无效输入!"
		sudoinstall=null
		source $ToolPATH/core/termuxplugin/sudo.sh
		return 1
		;;
esac
