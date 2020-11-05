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
		if network_check_sea; then
			cd $ToolPATH/main
			git pull 2>/dev/null
			cp tiviw $PREFIX/bin/tiviw
			green "已拉取最新版本！"
			green "请重启脚本以应用更新！"
		else
			cd $ToolPATH/main
			git remote set-url origin https://github.com.cnpmjs.org/QingxuMo/Tiviw
			if update_remote_status; then
				green "尝试拉取最新版本…"
				git checkout . && git clean -xdf
				git pull 2>/dev/null
				cp tiviw $PREFIX/bin/tiviw
				green "拉取结束！"
				green "请重启脚本以应用更新！"
			else
				red "仍然尝试拉起最新版本…"
				red "拉取可能会失败！"
				git checkout . && git clean -xdf
				git pull 2>/dev/null
				cp tiviw $PREFIX/bin/tiviw
				green "拉取结束！"
				green "请重启脚本以应用更新！"
			fi
			git remote set-url origin https://github.com/QingxuMo/Tiviw
			if remote_status; then
				green "远程仓库地址恢复成功！"
			else
				red "请手动输入 cd $ToolPATH/main && git remote set-url origin https://github.com/QingxuMo/Tiviw 恢复远程仓库地址"
				red "提交该界面截图至开发者以帮助开发者解决该问题！"
				exit 1
			fi
		fi
		cd $HOME
		source $ToolPATH/main/script/function.sh
		source $ToolPATH/main/script/about.sh
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
				echo "dev" > $ToolPATH/branch
				;;
			master)
				green "正在切换 master 分支…"
				git checkout master
				cp tiviw $PREFIX/bin/tiviw
				rm -f $ToolPATH/branch
				;;
			*)
				red "不存在的分支名称！"
				red "请输入 master 或 dev！"
				source $ToolPATH/main/script/about.sh
				return 0
				;;
		esac
		cd $HOME
		;;
	0)
		source $ToolPATH/main/script/menu.sh
		return 0
		;;
	*)
		red "无效输入，请重试！"
		Step
		source $ToolPATH/main/script/about.sh
		;;
esac




