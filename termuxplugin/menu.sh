echo -e "1 修改启动问候语\n"
sleep 0.016
echo -e "2 sudo 安装\n"
sleep 0.016
echo -e "3 图形化界面安装\n"
sleep 0.016
echo -e "4 生成无效文件填充存储空间\n"
sleep 0.016
echo -e "0 退出\n"
sleep 0.016
echo -en "\t\tEnter an option: "
read termuxchoose
case $termuxchoose in
1)
	source $ToolPATH/main/termuxplugin/termux-open.sh ;;
2)
	source $ToolPATH/main/termuxplugin/sudo.sh ;;
3)
	source $ToolPATH/main/termuxplugin/termuxgui.sh ;;
4)
	source $ToolPATH/main/termuxplugin/aaa.sh ;;
0)
	return 0 ;;
*)
	red "无效输入,请重试" 
	source $ToolPATH/main/termuxplugin/menu.sh ;;
esac
