echo -e "\n\n"
echo -e "1 Hexo 配置安装\n"
sleep 0.016
echo -e "2 ADB 配置安装\n"
sleep 0.016
echo -e "3 you-get 配置安装\n"
sleep 0.016
echo -e "4 HTTP 服务器搭建\n"
sleep 0.016
echo -e "5 BiliBili 挂机助手\n"
sleep 0.016
echo -e "6 Aria2 安装配置\n"
sleep 0.016
echo -e "0 退出\n"
sleep 0.016
echo -en "\t\tEnter an option: "
read toolsinstall
case $toolsinstall in
	1)
		hexo ;;
	2)
		adbconfig ;;
	3)
		yougetconfig ;;
	4)
		httpconfig ;;
	5)
			bilibilitools ;;
	6)
		aria2config ;;
	0)
		return 0 ;;
	*)
		red "无效输入,请重试" 
		source $PREFIX/etc/tconfig/main/tools/menu.sh ;;
esac
