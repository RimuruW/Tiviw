
function menu(){
	printf "$BLUE"
	cat <<-'EOF'
 _______  __   _____           _     
|_   _\ \/ /  |_   _|__   ___ | |___ 
  | |  \  /_____| |/ _ \ / _ \| / __|
  | |  /  \_____| | (_) | (_) | \__ \
  |_| /_/\_\    |_|\___/ \___/|_|___/
                                     
	EOF
	printf "$RESET"
        echo -e "\t\t\t\t\tv" $sh_ver
	echo -e "\t\t\tBy Qingxu (huanruomengyun)"
#if  [ $(which fortune) = /data/data/com.termux/files/usr/bin/fortune ]; then
#    fortune
#else
#    pkg in fortune -y
#    fortune
#fi
    echo -e "\n\n\n"
	echo -e " 1   镜像源管理\n"
	sleep 0.016
	echo -e " 2   底部小键盘扩展\n"
	sleep 0.016
	echo -e " 3   获取存储权限\n"
	sleep 0.016
	echo -e " 4   安装 ZSH\n"
	sleep 0.016
	echo -e " 5   Termux 扩展\n"
	sleep 0.016
	echo -e " 6   实用工具安装\n"
	sleep 0.016
	echo -e " 7   获取手机信息\n"
	sleep 0.016
	echo -e " 8   Linux 发行版安装\n"
	sleep 0.016
	echo -e " 9   终端小游戏          	 99 关于脚本  \n"
	sleep 0.016
	echo -e "                                0   退出\n\n\n"
	echo -en "\t\tEnter an option: "
	read option
}

while [ 1 ]
do
    menu
    case $option in
	    0)
	    	    exit 0 ;;
	    1)
	    	    mirrors ;;
	    2)
	    	    board ;;
	    3)
	    	    storage ;;
	    4)
	    	    installzsh ;;
	    5)
	    	    termuxplugin ;;
	    6)
	    	    tools ;;
	    7)
	    	    termuxapi ;;
	    8)
	    	    Linux ;;
	    99)
	    	    about ;;
	    *)
		    red "无效输入，请重试" ;;
    esac
    echo -en "\n\n\t\t\t点击任意键以继续"
    read -n 1 line
done

