termuxchoose=null
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
	source $ToolPATH/core/termuxplugin/termux_open.sh 
	return 0 ;;
2)
	source $ToolPATH/core/termuxplugin/sudo.sh 
	return 0 ;;
3)
	source $ToolPATH/core/termuxplugin/termuxgui.sh 
	return 0 ;;
4)
	source $ToolPATH/core/termuxplugin/aaa.sh 
	return 0;;
0)
	return 0 ;;
*)
	red "无效输入,请重试" 
	termuxchoose=null
	source $ToolPATH/core/termuxplugin/index.sh
	return 0 ;;
esac
