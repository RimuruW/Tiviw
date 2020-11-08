echo -e "1 更新脚本"
sp
sleep 0.016
echo -e "2 切换分支"
sp
sleep 0.016
echo -e "0 退出脚本"
sp
sp
Enter
read ABOUT_CHOOSE
case $ABOUT_CHOOSE in
	1)
		update_tiviw
		Step
		source $ToolPATH/main/script/menu.sh
		return 0
		;;
	2)
		red "注意，该选项是仅面向开发者测试的选项，普通用户请使用默认的 master 分支！"
		red "作者不保证 dev 分支代码的可用和安全性，请谨慎切换！"
		blue "请输入你想切换的分支[master or dev]"
		cd $ToolPATH/main
		echo -en "Enrer an option:"
		read SWICHBRANCH
		case $SWICHBRANCH in
			dev)
				red "正在切换 dev 分支，注意，这是一个高危操作！"
				git checkout dev
				cp tiviw $PREFIX/bin/tiviw
				;;
			master)
				green "正在切换 master 分支…"
				git checkout master
				cp tiviw $PREFIX/bin/tiviw
				;;
			*)
				red "不存在的分支名称！"
				red "请输入 master 或 dev！"
				source $ToolPATH/main/script/about.sh
				return 0
				;;
		esac
		cd $HOME
		source $ToolPATH/main/script/function.sh
		green "分支切换完毕！"
		green "默认重启脚本以应用更改…"
		exit 0
		;;
	0)
		source $ToolPATH/main/script/menu.sh
		return 0
		;;
	*)
		red "无效输入，请重试！"
		Step
		source $ToolPATH/main/script/about.sh && return 1
		;;
esac




