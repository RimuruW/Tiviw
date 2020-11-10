bilibilitools_check
bilibilitools_core_path=$ToolPATH/extended/bilibilitools
biliconfig=null
echo -e "\n项目地址: https://github.com/Dawnnnnnn/bilibili-live-tools\nWiki: https://github.com/Dawnnnnnn/bilibili-live-tools/wiki"
red "该脚本可能无法正常使用，等待作者更新…"
echo -e "\nBiliBli 挂机助手安装状态:" $bilibilitoolstatus
echo -e "\n\n"
echo -e "1 安装 BiliBili 挂机助手\n"
sleep 0.016
echo -e "2 启动 BiliBili 挂机助手\n"
sleep 0.016
echo -e "3 删除 BiliBili 挂机助手\n"
sleep 0.016
echo -e "0 退出\n"
sleep 0.016
echo -en "\t\tEnter an option: "
read biliconfig
case $biliconfig in
	1)
		if [ -f "$bilibilitools_core_path/main.py" ];then
			red "您已安装 BiliBili 挂机助手,无需重复安装\n"
			red "如果您想重新安装,请先删除 BiliBili 挂机助手\n"
			bilibilitools
		fi
		if [ ! -f "/data/data/com.termux/files/usr/bin/python" ];then
			green "检测到未安装 Python，正在自动安装 Python…"
		pkg in python -y
		fi
		if [ ! -f "/data/data/com.termux/files/usr/bin/git" ];then
			green "检测到未安装 git，正在自动安装 git..."
			pkg in git -y
		fi
		source $ToolPATH/main/tools/bilibilitools/bilibilitools_installer.sh
		if [ -f "$bilibilitools_core_path/main.py" ];then
			green "BiliBili 挂机助手已安装成功!"
		else
			red "BiliBili 挂机助手安装失败"
				source $ToolPATH/main/tools/bilibilitools/bilibilitools.sh
			fi
			return 0
			;;
		2)
			if [ ! -f "$bilibilitools_core_path/main.py" ];then
				red "请先安装 BiliBili 挂机助手!"
				source $ToolPATH/main/tools/bilibilitools/bilibilitools.sh
			fi
			if [ ! -f "/data/data/com.termux/files/usr/bin/python" ];then
				pkg in python -y
			fi
			source $ToolPATH/main/tools/bilibilitools/start_bilibilitools.sh
			return 0 ;;
		3)
			echo "开始删除…"
			rm -rf $bilibilitools_core_path
			green "如果一切正常,BiliBili 挂机助手已删除完成!"
			return 0 ;;
		0)
			source $ToolPATH/main/tools/menu.sh ;;
		*)
			red "无效输入,请重试" 
			source $ToolPATH/main/tools/bilibilitools/bilibilitools.sh ;;
esac
