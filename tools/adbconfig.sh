adbconfig_check
echo -e "\n\n"
echo -e "项目地址: https://github.com/MasterDevX/Termux-ADB"
echo -e "ADB 安装状态:" $adbconfigstatus
echo -e "\n\n1 安装 ADB\n"
sleep 0.016
echo -e "2 卸载 ADB\n"
sleep 0.016
echo -e "3 查看 ADB 版本\n"
sleep 0.016
echo -e "0 退出\n"
sleep 0.016
echo -en "\t\tEnter an option: "
read adbinstall
case $adbinstall in
	1)
		if network_check_oversea; then
			pkg up -y
			cd $ToolPATH
			wget https://github.com/MasterDevX/Termux-ADB/raw/master/InstallTools.sh
			bash InstallTools.sh
		else
			red "网络异常，无法完成 ADB 安装！"
		fi
		source $ToolPATH/main/tools/adbconfig.sh
		return 0 ;;
	2)
		if [ ! -f "/data/data/com.termux/files/usr/bin/adb" ];then
			red "您并未安装 ADB,无需进行此过程"
			source $ToolPATH/main/tools/adbconfig.sh
		fi
		if network_check_oversea; then
			plg up -y
			cd $ToolPATH
			wget https://github.com/MasterDevX/Termux-ADB/raw/master/RemoveTools.sh
			bash RemoveTools.sh
		else
			red "网络异常，无法获取安装脚本以完成安装…"
		fi
		source $ToolPATH/main/tools/adbconfig.sh
		return 0 ;;
	3)
		if [ -f "/data/data/com.termux/files/usr/bin/adb" ];then
			adb version
		else
			red "请先安装 ADB"
		fi
		source $ToolPATH/main/tools/adbconfig.sh
		return 0 ;;
	0)
		source $ToolPATH/main/tools/menu.sh 
		return 0 ;;
	*)
		red "无效输入,请重试" 
		source $ToolPATH/main/tools/adbconfig.sh
		return 0 ;;
esac


