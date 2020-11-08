echo -e "\n\n"
blue "该功能可以在 Termux 的私有文件夹下持续生成某无实际意义的文件以占用存储空间"
blue "该功能并没有任何实际意义，实质上只是一个极为无聊的功能"
blue "就像有这个无聊的功能一样，说不定也会有一个无聊的人需要它呢？"
red "注意，使用本功能的风险由用户自行承担，脚本作者不承担与之相应的任何责任！"
echo -e "\n\n"
echo -e "1 生成无效文件\n"
sleep 0.016
echo -e "2 删除无效文件\n"
sleep 0.016
echo -e "0 退出\n"
echo -en "\t\tEnter an option: "
read aaachoose
case $aaachoose in
	1)
		red "请密切关注您设备的剩余存储空间!"
		red "在设备剩余存储空间不足时建议立即按 Ctrl + C 中止！"
		echo -en "\n\n\t\t请回车以示您已阅读完毕"
		read -n 1 line
		blue "开始生成无效文件…"
		yes >> $ToolPATH/aaa.txt
		return 0 ;;
	2)
		rm -f $ToolPATH/aaa.txt
		if [ ! -f $ToolPATH/aaa.txt ];then
			green "删除完成！"
		else
			red "删除失败！"
		fi
		source $ToolPATH/main/termuxplugin/menu.sh && return 0 ;;
	0)
		source $ToolPATH/main/termuxplugin/menu.sh && return 0 ;;
	*)
		red "无效输入，请重试"
		aaachoose=null
		source $ToolPATH/main/termuxplugin/aaa.sh && return 0;;
esac
