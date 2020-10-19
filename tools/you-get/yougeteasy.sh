echo -e "\n\n"
blue "简易版脚本制作非常粗糙"
blue "简易版仅面向极端小白用户/终端无操作能力者"
blue "如果可以,我强烈建议使用原版 you-get 而非简易版"
echo -e "\n\n"
echo -e "1 开始\n"
echo -e "0 退出\n"
echo -en "\t\tEnter an option: "
read tmpyouget
case $tmpyouget in
	1)
		youget_download
		source $ToolPATH/main/tools/you-get/yougeteasy.sh ;;
	0)
		source $ToolPATH/main/tools/you-get/yougetconfig.sh ;;

	*)
		red "无效输入,请重试"
		Step
		source $ToolPATH/main/tools/you-get/yougeteasy.sh ;;
esac 

