httpconfig_check
httpserverchoose=null
echo -e "\n\n"
echo -e "HTTP 服务器安装状态:" $httpconfigstatus
echo -e "\n\n"
echo -e "1 安装 HTTP 服务器\n"
sleep 0.016
echo -e "2 启动 HTTP 服务器\n"
sleep 0.016
echo -e "3 卸载 HTTP 服务器\n"
sleep 0.016
echo -e "0 退出\n"
sleep 0.016
echo -en "\t\tEnter an option: "
read httpserverchoose
case $httpserverchoose in
	1)
		[[ -f "/data/data/com.termux/files/usr/lib/node_modules/http-server/bin/http-server" ]] && red "您已安装 HTTP 服务器，无需重复安装！" && source source $PREFIX/etc/tiviw/main/tools/httpconfig.sh  && return 0
		if check_apt_ability; then
			pkg in nodejs-lts -y
		else
			red "当前 Termux 环境不满足安装所需条件，仍尝试安装…"
		fi
		if npm_mirror_check; then
			npm install -g http-server
		else
			red "脚本认定你当前网络环境无法完成安装！"
			red "安装中止！"
			exit 1
		fi
		green "安装结束!" ;;
	2)
		if [ ! -f "/data/data/com.termux/files/usr/lib/node_modules/http-server/bin/http-server" ]; then
			red "请先安装 HTTP 服务器"
			source $PREFIX/etc/tiviw/main/tools/httpconfig.sh && return 0
		fi
		http-server
		return 0
		;;
	3)
		if [ ! -f "/data/data/com.termux/files/usr/lib/node_modules/http-server/bin/http-server" ]; then
			red "请先安装 HTTP 服务器"
			source $PREFIX/etc/tiviw/main/tools/httpconfig.sh && return 0
		fi
		green "开始卸载..."
		npm uninstall http-server -g
		green "卸载完成!"
		source $ToolPATH/main/tools/menu.sh && return 0 ;;
	0)
		source $ToolPATH/main/tools/menu.sh ;;
	*)
		red "无效输入,请重试"
		source $PREFIX/etc/tiviw/main/tools/httpconfig.sh && return 0 ;;
esac
