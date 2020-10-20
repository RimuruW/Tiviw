youget_check
echo -e "\n\n项目地址: https://github.com/soimort/you-get/\n\n"
echo -e "you-get 安装状态:" $yougetconfigstatus
echo -e "\n\n"
echo -e "1 安装 you-get\n"
sleep 0.016
echo -e "2 升级 you-get\n"
sleep 0.016
echo -e "3 you-get 使用方法\n"
sleep 0.016
echo -e "4 you-get 简易版[适合超小白用户]\n"
sleep 0.016
echo -e "5 卸载 you-get\n"
sleep 0.016
echo -e "0 退出\n"
sleep 0.016
echo -en "\t\tEnter an option: "
read yougetoption
case $yougetoption in
	1)
		if youget_check; then
			red "已安装 you-get，无需重复安装！"
		else
			if check_pip_ability; then
				pip3 install you-get
				if youget_check; then
					green "you-get 安装成功！"
				else
					red "you-get 安装失败！"
					red "请检查你的网络连接！"
				fi
			else
				red "不满足所需环境条件，无法完成安装！"
			fi
		fi
		source $ToolPATH/main/tools/you-get/yougetconfig.sh
		;;

	2)
		if youget_check; then
			if python_check; then
				pip3 install --upgrade you-get
				green "Done!"
			else
				red "未安装 Python，无法进行该操作！"
			fi
		else
			red "请先安装 you-get！"
		fi
		source $ToolPATH/main/tools/you-get/yougetconfig.sh 
		;;
	3)
		if [ -f "/data/data/com.termux/files/usr/bin/you-get" ];then
			you-get -h
			source $ToolPATH/main/tools/you-get/yougetconfig.sh
		else
			red "请先安装 you-get"
		fi
		source $ToolPATH/main/tools/you-get/yougetconfig.sh ;;
	4)
		if [ -f "/data/data/com.termux/files/usr/bin/you-get" ];then
			source $ToolPATH/main/tools/you-get/yougeteasy.sh
		else
			red "请先安装 you-get"
			source $ToolPATH/main/tools/you-get/yougetconfig.sh
		fi
		;;
	5)
		if youget_check; then
			if python_check; then
				yes | pip uninstall you-get
				if youget_check; then
					red "卸载失败！请提交错误至开发者！"
				else
					green "卸载成功！"
				fi
			else
				red "未安装 Python，无法执行该命令！"
			fi
		else
			red "you-get 未安装！"
		fi
		source $ToolPATH/main/tools/you-get/yougetconfig.sh ;;
	0)
		source $ToolPATH/main/script/menu.sh
		return 0
		;;
	*)
		red "无效输入,请重试"
		Step
		source $ToolPATH/main/tools/you-get/yougetconfig.sh ;;
esac


