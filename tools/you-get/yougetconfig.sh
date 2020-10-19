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
		if python_check; then
			red "Python 未安装！"
			blue "是否安装 Python？[y/n]"
			Enter
			read PYTHON_INSTALL_CHOOSE
			case $PYTHON_INSTALL_CHOOSE in
				y)
					if mirror_check; then
						green "Termux 镜像源已配置"
						pkg in python
					else
						if network_check_sea; then
							pkg in python
							if python_check; then
								green "Python 安装成功！"
							else
								red "Python 安装失败，请检查网络连接！"
								source $ToolPATH/main/tools/you-get/yougetconfig.sh
							fi
						else
							red "根据检测结果，脚本认定你当前网络环境无法完成安装！"
							red "对于国内用户，请配置镜像源以完成安装！"
							blue "是否跳转到 Termux 镜像源配置？[y/n]"
							Enter
							read MIRROR_CHOOSE
							case $MIRROR_CHOOSE in
								y)
									source $ToolPATH/main/script/mirror.sh
									;;
								*)
									red "跳过镜像源配置！"
									red "警告，根据网络环境和镜像源配置检测结果，脚本认为你无法完成安装！"
									red "安装强制中止！"
									source $ToolPATH/main/tools/you-get/yougetconfig.sh
									;;
							esac
						fi
					fi
					;;
				n)
					red "未安装 Python 无法安装  you-get！"
					red "安装失败！"
					source $ToolPATH/main/tools/you-get/yougetconfig.sh
					;;
				*)
					red "无效输入，请重试！"
					Step
					source $ToolPATH/main/tools/you-get/yougetconfig.sh
					;;
			esac
		fi
		if PIP_mirror_check; then
			pip3 install you-get
			if youget_check; then
				green "Done!"
			else
				red "you-get 安装失败，请检查网络连接！"
				source $ToolPATH/main/tools/you-get/yougetconfig.sh
			fi
		else
			if network_check_sea; then
				pip3 install you-get
				if youget_check; then
					green "Done!"
				else
					red "you-get 安装失败，请检查网络连接！"
					source $ToolPATH/main/tools/you-get/yougetconfig.sh
				fi
			else
				red "根据检测结果，脚本认定你当前网络环境无法完成安装！"
				red "对于国内用户，请配置镜像源以完成安装！"
				blue "是否跳转到 PIP 镜像源配置？[y/n]"
				Enter
				read PIP_MIRROR_CHOOSE
				case $PIP_MIRROR_CHOOSE in
					y)
						source $ToolPATH/main/script/mirror.sh
						;;
					n)
						red "跳过镜像源配置！"
						red "警告，根据网络环境和镜像源配置检测结果，脚本认为你无法完成安装！"
						red "安装强制中止！"
						source $ToolPATH/main/tools/you-get/yougetconfig.sh
						;;
					*)
						red "无效输入，请重试！" 
						Step
						source $ToolPATH/main/tools/you-get/yougetconfig.sh
						;;
				esac
				pip3 install you-get
				if youget_check; then
					green "Done!"
				else
					red "you-get 安装失败，请检查网络连接！"
					source $ToolPATH/main/tools/you-get/yougetconfig.sh
				fi
			fi
		fi
		;;

	2)
		pip3 install --upgrade you-get
		green "done!"
		source $ToolPATH/main/tools/you-get/yougetconfig.sh ;;
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
		yes | pip uninstall you-get
		if [ ! -f "/data/data/com.termux/files/usr/bin/you-get" ];then
			green "卸载完成!"
		else
			red "卸载失败!"
		fi
		source $ToolPATH/main/tools/you-get/yougetconfig.sh ;;
	0)
		source $ToolPATH/main/script/menu.sh ;;
	*)
		red "无效输入,请重试" 
		source $ToolPATH/main/tools/you-get/yougetconfig.sh ;;
esac


