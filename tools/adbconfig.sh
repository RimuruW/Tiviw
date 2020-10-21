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
		apt update
		cd $HOME
		wget https://github.com/MasterDevX/Termux-ADB/raw/master/InstallTools.sh
		bash InstallTools.sh
		source $ToolPATH/main/tools/adbconfig.sh ;;
	2)
		if [ ! -f "/data/data/com.termux/files/usr/bin/adb" ];then
			red "您并未安装 ADB,无需进行此过程"
			source $ToolPATH/main/tools/adbconfig.sh
		fi
		apt update
		cd $HOME
		wget https://github.com/MasterDevX/Termux-ADB/raw/master/RemoveTools.sh
		bash RemoveTools.sh
		source $ToolPATH/main/tools/adbconfig.sh ;;
	3)
		if [ -f "/data/data/com.termux/files/usr/bin/adb" ];then
			adb version
		else
			red "请先安装 ADB"
		fi
		source $ToolPATH/main/tools/adbconfig.sh ;;
	0)
		source $ToolPATH/main/tools/menu.sh ;;
	*)
		red "无效输入,请重试" 
		source $ToolPATH/main/tools/adbconfig.sh ;;
esac


