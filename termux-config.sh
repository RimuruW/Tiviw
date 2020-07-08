#!/bin/bash
#-----------------------------------
# Author: Qingxu (huanruomengyun)
# Description: Termux Tools
# Repository Address: https://github.com/huanruomengyun/Termux-Tools
# Version: 1.6.30
# Copyright (c) 2020 Qingxu
#-----------------------------------
sh_ver="1.6.30"
function blue(){
	echo -e "\033[34m\033[01m$1\033[0m"
}
function green(){
	echo -e "\033[32m\033[01m$1\033[0m"
}
function red(){
	echo -e "\033[31m\033[01m$1\033[0m"
}
if [ -t 1 ]; then
	RED=$(printf '\033[31m')
	GREEN=$(printf '\033[32m')
	YELLOW=$(printf '\033[33m')
	BLUE=$(printf '\033[34m')
	BOLD=$(printf '\033[1m')
	RESET=$(printf '\033[m')
else
	RED=""
	GREEN=""
	YELLOW=""
	BLUE=""
	BOLD=""
	RESET=""
fi
if [[ $EUID -eq 0 ]]; then
	red "检测到您正在尝试使用 ROOT 权限运行该脚本"
	red "这是不建议且不被允许的"
	red "该脚本不需要 ROOT 权限,且以 ROOT 权限运行可能会带来一些无法预料的问题"
	red "为了您的设备安全，请避免在任何情况下以 ROOT 用户运行该脚本"
	exit 0
fi
if [[ -d /system/app && -d /system/priv-app ]]; then
	systeminfo="Android $(getprop ro.build.version.release)"
else
	red "This operating system is not supported."
	exit 1
fi
blue "为确保脚本正常运行，每次运行脚本都将会强制进行初始化"
blue "给您带来的不便还请见谅"
green "Initializing……"
if [ ! -f "$PREFIX/bin/wget" ];then
	pkg in wget -y
fi
mkdir -p $PREFIX/etc/tconfig
if [ -f "$PREFIX/etc/tconfig/mirrorstatus" ];then
	apt update && apt upgrade -y
else
	echo "Skip..."
fi
[[ -f "$PREFIX/etc/tconfig/aria2btauto" ]] && bash <(wget -qO- git.io/tracker.sh) $HOME/.aria2/aria2.conf
sh_new_ver=$(wget -qO- -t1 -T3 "https://raw.githubusercontent.com/huanruomengyun/Termux-Tools/master/termux-config.sh" | grep 'sh_ver="' | awk -F "=" '{print $NF}' | sed 's/\"//g' | head -1) && sh_new_type="github"
[[ -z ${sh_new_ver} ]] && red "无法链接到 Github! 脚本最新版本信息获取失败!" && red "请注意,该脚本绝大多数功能都需要与 GitHub 建立连接,若无法连接 GitHub,则脚本大多数功能无法使用!!" && echo -en "\n\n\t\t\t点击任意键以继续" && read -n 1 line
#[[ $sh_new_ver -lt $sh_ver ]] && red "警告！本地脚本版本号高于云端版本号。\n这可能是因为您正在使用 dev 分支，而脚本默认拉取 master 分支。\n建议不要在任何情况下使用 dev 分支以获取更佳的使用体验\n" && canautoupdate=warning
if [ -f "$PREFIX/etc/tconfig/startautoupdate" ]; then
	#if [ $canautoupdate = warning ]; then
	#	red "本地版本号高于云端版本号，是否仍然拉取云端最新版本覆盖本地？"
	#	echo -en "\t\t [y/N] 默认 N :"
	#	read updatecover
	#	case $updatecover in
	#		y)
	#			wget -N "https://raw.githubusercontent.com/huanruomengyun/Termux-Tools/master/termux-config.sh" && chmod +x termux-config.sh
	#			echo -e "脚本更新为云端最新[ $sh_ver --> $sh_new_ver ]"
	#			;;
	#		*)
	#			echo "Skip..."
	#			;;
	#	esac
	#else
	#	wget -N "https://raw.githubusercontent.com/huanruomengyun/Termux-Tools/master/termux-config.sh" && chmod +x termux-config.sh
	#	echo -e "脚本更新为云端最新[ $sh_ver --> $sh_new_ver ]"
	#fi
fi
if [ $sh_ver=$sh_new_ver ]; then
	echo "脚本已为最新版本"
else
	echo "$sh_ver ->> $sh_new_ver" >> $HOME/logs/update_log.log
fi
clear
green "初始化完成!"
green "确认您的系统信息中……"
date=$(date)
log=log_init.log
mkdir -p $HOME/logs
rm -f $HOME/logs/*log_*.log
touch $HOME/logs/tmp_$log
echo -e "====Device info====\n" >> $HOME/logs/tmp_$log
echo "Date:" >> $HOME/logs/tmp_$log
echo "$date\n\n" >> $HOME/logs/tmp_$log
echo "<----Props---->" >> $HOME/logs/tmp_$log
getprop >> $HOME/logs/tmp_$log
echo -e "\n\n" >> $HOME/logs/tmp_$log
echo "<----System info---->" >> $HOME/logs/tmp_$log
echo "Logged In users:" >> $HOME/logs/tmp_$log
whoami >> $HOME/logs/tmp_$log
echo $systeminfo >> $HOME/logs/tmp_$log
echo "Package Installed" >> $HOME/logs/tmp_$log
pkg list-installed >> $HOME/logs/tmp_$log
echo -e "\n\n" >> $HOME/logs/tmp_$log
echo "<----Hardware info---->" >> $HOME/logs/tmp_$log
echo "CPU info:"
lscpu >> $HOME/logs/tmp_$log
echo "Memory and Swap info:" >> $HOME/logs/tmp_$log
free -h >> $HOME/logs/tmp_$log
echo "Internet info:" >> $HOME/logs/tmp_$log
ifconfig >> $HOME/logs/tmp_$log
echo "Disk Usages :" >> $HOME/logs/tmp_$log
df -h >> $HOME/logs/tmp_$log
mv -f $HOME/logs/tmp_$log $HOME/logs/$log
green "系统信息确认完毕!!"
green "您马上就可以进入脚本!"
clear
function menu(){
	printf "$BLUE"
	cat <<-'EOF'
 _____                                _____           _      
|_   _|__ _ __ _ __ ___  _   ___  __ |_   _|__   ___ | |___  
  | |/ _ \ '__| '_ ` _ \| | | \ \/ /   | |/ _ \ / _ \| / __| 
  | |  __/ |  | | | | | | |_| |>  <    | | (_) | (_) | \__ \ 
  |_|\___|_|  |_| |_| |_|\__,_/_/\_\   |_|\___/ \___/|_|___/ 
	EOF
	printf "$RESET"
        echo -e "\t\t\t\t\t\tv" $sh_ver
	echo -e "\t\t\t\tBy Qingxu (huanruomengyun)"
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

function mirrors(){
	if [ -f "$PREFIX/etc/tconfig/mirrorstatus" ]; then
		tsinghua=`green "true"`
	else
		tsinghua=`red "false"`
	fi
	if [ -f "$PREFIX/etc/tconfig/npmmirrorsstatus" ]; then
		npmmirrorsstatus=`green "true"`
	else
		npmmirrorsstatus=`red "false"`
	fi
	if [ -d $HOME/.pip ]; then
		pipmirrorsstatus=`green "true"`
	else
		pipmirrorsstatus=`red "false"`
	fi
	echo "\n\n"
	echo "Termux 清华源状态：" $tsinghua
	echo "NPM 淘宝源状态:" $npmmirrorsstatus
	echo "pip 清华源状态:" $pipmirrorsstatus
	echo "\n\n"
	echo "1 Termux 清华源"
	sleep 0.016
	echo "2 NPM 淘宝源"
	sleep 0.016
	echo "3 pip 清华源"
	sleep 0.016
	echo "0 退出"
	echo -en "\t\tEnter an option: "
	read mirrorschoose
	case $mirrorschoose in
		1)
			[[ -f "$PREFIX/etc/tconfig/mirrorstatus" ]] && red "您已更换清华源，无需重复更换" && return 0
			sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
			sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
			sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
			touch $PREFIX/etc/tconfig/mirrorstatus
			apt update && apt upgrade -y
			;;
		2)
			[[ ! -f "$PREFIX/bin/npm" ]] && red "请先安装 Node.js" && return 0
			npm config set registry https://registry.npm.taobao.org
			touch $PREFIX/etc/tconfig/npmmirrorsstatus
			;;
		3)
			[[ ! -f "$PREFIX/bin/python" ]] && red "请先安装 Python " && return 0
			[[ -d $HOME/.pip ]] && red "您已更换清华源，无需重复更换" && return 0
			mkdir -p ~/.pip/
			echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple\n[install]\ntrusted-host=mirrors.aliyun.com" > ~/.pip/pip.conf
			;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试"
			mirrors ;;
	esac
}

function storage(){
	termux-setup-storage
	return 0
}

function board(){
	mkdir -p ~/.termux
	echo -e "extra-keys = [['TAB','>','-','~','/','*','$'],['ESC','(','HOME','UP','END',')','PGUP'],['CTRL','[','LEFT','DOWN','RIGHT',']','PGDN']]" > ~/.termux/termux.properties
	termux-reload-settings
	green  "请重启终端使小键盘显示正常"
	return 0
}

function installzsh(){
       	rc=~/.zshrc
        pkg in zsh git curl -y
        green "如果下面需要您进行确认，请输入 y 确认"
        sh -c "$(sed -e "/exec zsh -l/d" <<< $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
        git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
        sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" $rc
        sed -i "s/plugins=(git)/plugins=(git extract web-search zsh-autosuggestions zsh-completions zsh-syntax-highlighting)/g" $rc
        green "ZSH 配置完成，你可在 ~/.zshrc 中修改主题"
}

function sudoconfig(){
	if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
		sudostatus=`green "true"`
	else
		sudostatus=`red "false"`
	fi
	echo -e "\n\n"
	echo -e "sudo 安装状态:" $sudostatus
	echo -e "SU 状态:" $testsustatus
	echo -e "\n\n"
	echo -e "1 安装 sudo\n"
	echo -e "2 修复 sudo\n"
	echo -e "3 卸载 sudo\n"
	echo -e "0 退出\n"
	echo -en "\t\tEnter an option: "
	read sudoinstall
	case $sudoinstall in
		1)
			if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
				blue "您已安装 sudo,请勿重复安装"
				blue "如果 sudo 使用出现问题,请选择 修复sudo"
				return 0
			fi
			git clone https://gitlab.com/st42/termux-sudo.git $HOME/termux-sudo
			cat $HOME/termux-sudo/sudo > /data/data/com.termux/files/usr/bin/sudo
			chmod 700 /data/data/com.termux/files/usr/bin/sudo
			if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
				green "sudo 已成功安装到了您的 Termux"
			else
				green "脚本运行失败!请检查网络连接或提交日志"
			fi
			echo "安装脚本运行完毕"
			return 0 ;;
		2)
			echo "脚本开发中,敬请期待"
			return 0 ;;
		3)
			if [ ! -f "/data/data/com.termux/files/usr/bin/sudo" ];then
				red "您并未安装 sudo"
				sudoconfig
			fi
			rm -f /data/data/com.termux/files/usr/bin/sudo
			if [ -f "/data/data/com.termux/files/usr/bin/sudo" ];then
				red "sudo 卸载失败!"
			else
				green "sudo 卸载成功!"
			fi
			return 0 ;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试"
			sudoconfig ;;
	esac
}

function termuxplugin(){
	echo -e "1 修改启动问候语\n"
	sleep 0.016
	echo -e "2 sudo 安装\n"
	sleep 0.016
	echo -e "3 图形化界面安装\n"
	sleep 0.016
	echo -e "4 生成无效文件占据存储空间\n"
	sleep 0.016
	echo -e "0 退出\n"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read termuxchoose
	case $termuxchoose in
	1)
		termuxopen ;;
	2)
		sudoconfig ;;
	3)
		termuxgui ;;
	4)
		aaa ;;
	0)
		return 0 ;;
	*)
		red "无效输入,请重试" 
		termuxplugin ;;
esac
}

function termuxopen(){
	rm -f $PREFIX/etc/motd.tmp
	if [ -f "$HOME/.hushlogin" ];then
		hushloginstatus=`green "已关闭"`
	else
		hushloginstatus=`red "未关闭"`
	fi
	if [ -f "$PREFIX/etc/termuxopen" ];then
		termuxloginstatus=`green "已修改"`
	else
		termuxloginstatus=`red "未修改"`
	fi
	[[ ! -f "$PREFIX/etc/motd.init" ]] && cp $PREFIX/etc/motd $PREFIX/etc/motd.init
	echo -e "\n\n"
	echo -e "问候语状态:"
	echo -e "问候语" $hushloginstatus
	echo -e "问候语" $termuxloginstatus
	echo -e "\n\n"
	echo -e "1 使用编辑器编辑[适合有 Linux 使用经验的用户,默认使用 vim]\n"
	sleep 0.016
	echo -e "2 使用简易编辑器进行修改[适合纯新手]\n"
	sleep 0.016
	echo -e "3 查看当前启动问候语\n"
	sleep 0.016
	echo -e "4 恢复默认启动问候语\n"
	sleep 0.016
	echo -e "5 关闭问候语\n"
	sleep 0.016
	echo -e "6 开启问候语\n"
	sleep 0.016
	echo -e "0 退出\n"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read etermuxopen
	case $etermuxopen in
		1)
			if [ ! -f "$PREFIX/etc/motd.bak" ];then
				mv $PREFIX/etc/motd $PREFIX/etc/motd.bak
			else
				rm -f $PREFIX/etc/motd
				touch $PREFIX/etc/motd
			fi
			vim $PREFIX/etc/motd
			if [ ! -f "$PREFIX/etc/motd" ];then
				mv $PREFIX/etc/motd.bak $PREFIX/etc/motd
			else
				touch $PREFIX/etc/termuxopen
			fi
			return 0 ;;
		2)
			if [ ! -f "$PREFIX/etc/motd.bak" ];then
				mv $PREFIX/etc/motd $PREFIX/etc/motd.bak
			fi
			echo -e "\n请在下方直接输入您想要更换的启动问候语\n可以直接回车换行,输入 wq 保存退出,输入 q 直接退出\n"
			while [ 1 ]
			do
				echo -en "\033[34m\033[01m--> ~  \033[0m"
				read texttermuxopen
				case $texttermuxopen in
					wq)
						green "已保存"
						if [ ! -f "$PREFIX/etc/motd.bak" ];then
							mv $PREFIX/etc/motd $PREFIX/etc/motd.bak
							mv $PREFIX/etc/motd.tmp $PREFIX/etc/motd
						else
							rm -f $PREFIX/etc/motd.bak
							mv $PREFIX/etc/motd $PREFIX/etc/motd.bak
			mv $PREFIX/etc/motd.tmp $PREFIX/etc/motd
						fi
						touch $PREFIX/etc/termuxopen
						green "修改完成!"
						return 0 ;;
					q)
						rm -f $PREFIX/etc/motd.tmp
						echo "已退出"
						return 0
						;;
					*)
						echo -e "${texttermuxopen}" >> $PREFIX/etc/motd.tmp
						;;
				esac
			done
			;;
		3)
			cat $PREFIX/etc/motd
			return 0 ;;
		4)
			if [ ! -f "$PREFIX/etc/termuxopen" ];then
				red "问候语已为默认状态"
				return 0
			fi
			if [ -f "$PREFIX/etc/motd.init" ];then
				rm -f $PREFIX/etc/motd
				cp $PREFIX/etc/motd.init $PREFIX/etc/motd
				rm -f $PREFIX/etc/termuxopen
				green "恢复成功!"
			else
				red "备份丢失,默认问候语恢复失败!!"
			fi
			;;
		5)
			if [ -f "$HOME/.hushlogin" ];then
				red "您已关闭问候语,无需重复关闭"
				termuxopen
				return 0
			fi
			touch ~/.hushlogin
			if [ ! -f "$HOME/.hushlogin" ];then
				red "问候语关闭失败!"
				termuxopen
				return 0
			fi
			green "问候语关闭成功!"
			;;
		6)
			if [ ! -f "$HOME/.hushlogin" ];then
				red "您已开启问候语,无需重复关闭"
				termuxopen
				return 0
			fi
			rm -f  $HOME/.hushlogin
			if [ -f "$HOME/.hushlogin" ];then
				red "问候语开启失败!"
				termuxopen
				return 0
			fi
			green "问候语开启成功!"
			;;
		0)
			return 0 ;;
	esac
}

function termuxgui(){
	if [ -f "/data/data/com.termux/files/usr/bin/startvnc" ];then
		termuxguistatus=`green "true"`
	else
		termuxguistatus=`red "false"`
	fi
	echo -e "\n\n安装方法来自于 酷安@萌系生物研究员"
	echo -e "\n图形化界面安装状态:" $termuxguistatus
	echo -e "\n\n"
	echo -e "1 安装\n"
	sleep 0.016
	echo -e "2 使用方法\n"
	sleep 0.016
	echo -e "0 退出\n"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read termuxguiinstall
	case $termuxguiinstall in
		1)
			if [ -f "/data/data/com.termux/files/usr/bin/startvnc" ];then
				blue "您已安装图形化界面,不必重复进行安装"
				return 0
			fi
			pkg i -y x11-repo
			pkg up -y
			pkg i -y xfce tigervnc openbox aterm
			echo -e "#\!/bin/bash -e\nam start com.realvnc.viewer.android/com.realvnc.viewer.android.app.ConnectionChooserActivity\nexport DISPLAY=:1\nXvnc -geometry 720x1440 --SecurityTypes=None \$DISPLAY&\nsleep 1s\nopenbox-session&\nthunar&\nstartxfce4">~/startvnc
			chmod +x ~/startvnc
			mv -f ~/startvnc $PREFIX/bin/
			if [ -f "$PREFIX/bin/startvnc" ];then
				echo "Termux GUI 安装完成!"
				green "输入 startvnc 即可启动 VNC 服务"
				green "输入 Ctrl+C 即可终止 VNC 服务"
				green "在启动 VNC 服务前，请安装 VNC Viewer"
				green "下载链接: https://play.google.com/store/apps/details?id=com.realvnc.viewer.android"
			else
				echo "Termux GUI 安装失败"
			fi
			;;
		2)
			green "输入 startvnc 即可启动 VNC 服务"
			green "输入 Ctrl+C 即可终止 VNC 服务"
			green "在启动 VNC 服务前，请安装 VNC Viewer"
			green "下载链接: https://play.google.com/store/apps/details?id=com.realvnc.viewer.android"
			;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试" 
			termuxgui ;;
	esac
	return 0
}

function aaa(){
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
			yes >> $PREFIX/etc/tconfig/aaa.txt
			return 0 ;;
		2)
			rm -f $PREFIX/etc/tconfig/aaa.txt
			if [ ! -f $PREFIX/etc/tconfig/aaa.txt ];then
				green "删除完成！"
			else
				ref "删除失败！"
			fi
			return 0 ;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试"
			aaa ;;
	esac
	return 0
}

function tools(){
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
			tools ;;
	esac
}

function aria2config(){
	if [ -f "$PREFIX/bin/aria2c" ];then
		aria2status=`green "true"`
	else
		aria2status=`red "false"`
	fi
	echo "\n\n"
	echo "项目地址: https://github.com/huanruomengyun/Aria2-Termux"
	echo "\n\n"
	echo "Aria2 安装状态: " $aria2status
	echo "\n\n"
	echo "1 Aria2 安装与管理\n"
	sleep 0.016
	echo "2 AriaNG 启动\n"
	sleep 0.016
	echo "0 退出"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read aria2choose
	case $aria2choose in
		1)
			[[ ! -f "$PREFIX/etc/tconfig/aria2.sh" ]] && wget -P $PREFIX/etc/tconfig https://raw.githubusercontent.com/huanruomengyun/Aria2-Termux/master/aria2.sh && chmod +x $PREFIX/etc/tconfig/aria2.sh
			[[ ! -f "$PREFIX/etc/tconfig/aria2.sh" ]] && red "Aria2 一键安装管理脚本下载失败！请检查您是否能正常连接 GitHub！" && echo "请回车确认" && read tmp && aria2config
			bash $PREFIX/etc/tconfig/aria2.sh
			;;
		2)
			ariang ;;
		0)
			return 0 ;;
		*)
			red "无效输入，请重试"
			aria2config
			;;
	esac
}

function ariang(){
	[[ ! -f "$PREFIX/bin/aria2c" ]] && red "请先安装 Aria2" && echo "请回车确认" && read tmp && aria2config
	blue "AriaNG 只是一个静态网页,直接打开在线网页和使用本地客户端在功能上并没有什么不同."
	blue "但是对于 Android 用户，我推荐安装 AriaNG GUI 客户端以便于连接和管理 Aria2"
	blue "故此，该界面给出了两个选择，您可以根据您的需求和使用偏好选择对于您来说的最佳选项."
	echo "1 安装 AriaNG 客户端［该选项会自动跳转客户端下载网页]"
	echo "2 直接打开在线网页"
	echo "0 退出"
	echo -en "您的选择是："
	read ariangconfig
	case $ariangconfig in
		1)
			termux-open-url https://github.com/Xmader/aria-ng-gui-android/releases ;;
		2)
			termux-open-url http://ariang.mayswind.net/latest ;;
		0)
			aria2config ;;
		*)
			red "无效输入，请重试" 
			ariang
			;;
	esac
}
function bilibilitools(){
	if [ -f "$HOME/bilibilitools/main.py" ];then
		bilibilitoolstatus=`green "true"`
	else
		bilibilitoolstatus=`red "false"`
	fi
	echo -e "\n项目地址: https://github.com/Dawnnnnnn/bilibili-live-tools\nWiki: https://github.com/Dawnnnnnn/bilibili-live-tools/wiki"
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
			if [ -f "$HOME/bilibilitools/main.py" ];then
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
			touch $HOME/bilibilitoolsinstall.sh
			echo -e "git clone https://github.com/Dawnnnnnn/bilibili-live-tools $HOME/bilibilitools && cd $HOME/bilibilitools && pip install -r requirements.txt" > $HOME/bilibilitoolsinstall.sh
			bash $HOME/bilibilitoolsinstall.sh
			rm -f $HOME/bilibilitoolsinstall.sh
			if [ -f "$HOME/bilibilitools/main.py" ];then
				green "BiliBili 挂机助手已安装成功!"
			else
				red "BiliBili 挂机助手安装失败"
				bilibilitools
			fi
			return 0
			;;
		2)
			if [ ! -f "$HOME/bilibilitools/main.py" ];then
				red "请先安装 BiliBili 挂机助手!"
				return 0
			fi
			if [ ! -f "/data/data/com.termux/files/usr/bin/python" ];then
				pkg in python -y
			fi
			touch $HOME/start-bilibilitools.sh
			echo "cd $HOME/bilibilitools && python main.py" > $HOME/start-bilibilitools.sh
			bash $HOME/start-bilibilitools.sh
			rm -f $HOME/start-bilibilitools.sh
			return 0 ;;
		3)
			echo "开始删除…"
			rm -rf $HOME/bilibilitools
			green "如果一切正常,BiliBili 挂机助手已删除完成!"
			return 0 ;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试" 
			bilibilitools ;;
	esac
	return 0
}

function httpconfig(){
	if [ -f "/data/data/com.termux/files/usr/lib/node_modules/http-server/bin/http-server" ];then
		httpconfigstatus=`green "true"`
	else
		httpconfigstatus=`red "false"`
	fi
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
			pkg in nodejs-lts -y
			npm install -g http-server
			green "安装结束!" ;;
		2)
			if [ ! -f "/data/data/com.termux/files/usr/lib/node_modules/http-server/bin/http-server" ]; then
				red "请先安装 HTTP 服务器"
				httpconfig
				return 0
			fi
			http-server

			return 0
			;;
		3)
			if [ ! -f "/data/data/com.termux/files/usr/lib/node_modules/http-server/bin/http-server" ]; then
				red "请先安装 HTTP 服务器"
				httpconfig
				return 0
			fi
		green "开始卸载..."
			npm uninstall http-server -g
			green "卸载完成!" ;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试"
			httpconfig ;;
	esac
}

function hexo(){
	wget https://raw.githubusercontent.comhttpserverchoose/huanruomengyun/Termux-Hexo-installer/master/hexo-installer.sh && sh hexo-installer.sh
	rm -f hexo-installer.sh
	return 0
}

function Linux(){
	echo -e "1 Ubuntu\n"
	sleep 0.016
	echo -e "2 Debian\n"
	sleep 0.016
	echo -e "3 Kali Linux\n"
	sleep 0.016
	echo -e "4 CentOS\n"
	sleep 0.016
	echo -e "5 Arch Linux\n"
	sleep 0.016
	echo -e "0 退出"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read installlinux
	case $installlinux in
		1)
			ubuntu ;;
		2)
			debian ;;
		3)
			kali ;;
		4)
			centos ;;
		5)
			archlinux ;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试"
	esac
	return 0
}

function ubuntu(){
	echo "\n\n 安装脚本来自于 Andronix"
	green "是否安装桌面环境?[y/n]"
	echo -en "\t\tEnter an option: "
	read ubuntude
	case $ubuntude in
		y)
			ubuntudechoose ;;
		n)
			pkg update -y && pkg install wget curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Ubuntu/ubuntu.sh && chmod +x ubuntu.sh && bash ubuntu.sh ;;
		t)
			echo "Working" ;;
		*)
			echo "无效输入，请重试" ;;
	esac
	return 0
}

function ubuntudechoose(){
	echo -e "1 XFCE"
	sleep 0.016
	echo -e "2 LXDE"
	sleep 0.016
	echo -e "3 LXQT"
	sleep 0.016
	echo -e "0 取消"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read udechoose
	case $udechoose in
		1)
			pkg update -y && pkg install curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Ubuntu/ubuntu-xfce.sh && chmod +x ubuntu-xfce.sh && bash ubuntu-xfce.sh ;;
		2)
			pkg update -y && pkg install curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Ubuntu/ubuntu-lxde.sh && chmod +x ubuntu-lxde.sh && bash ubuntu-lxde.sh ;;
		3)
			pkg update -y && pkg install curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Ubuntu/ubuntu-lxqt.sh && chmod +x ubuntu-lxqt.sh && bash ubuntu-lxqt.sh ;;
		0)
			return 0 ;;
		*)
			red "无效输入，请重试" 
			ubuntudechoose;;
	esac
	return 0
}

function debian(){
	echo "\n\n安装脚本来自于 Andronix"
	green "是否安装桌面环境?[y/n]"
	echo -en "\t\tEnter an option: "
	read debiande
	case $debiande in
		y)
			debiandechoose ;;
		n)
			pkg update -y && pkg install curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian.sh && chmod +x debian.sh && bash debian.sh ;;
		t)
			echo "Working" ;;
		*)
			echo "无效输入，请重试" ;;
	esac
	return 0
}

function debiandechoose(){
	echo -e "1 XFCE"
	sleep 0.016
	echo -e "2 LXDE"
	sleep 0.016
	echo -e "3 LXQT"
	sleep 0.016
	echo -e "0 取消"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read ddechoose
	case $ddechoose in
		1)
			pkg update -y && pkg install curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian-xfce.sh && chmod +x debian-xfce.sh &&  bash debian-xfce.sh ;;
		2)
			pkg update -y && pkg install curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian-lxde.sh && chmod +x debian-lxde.sh bash debian-lxde.sh ;;
		3)
			pkg update -y && pkg install curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Debian/debian-lxqt.sh && chmod +x debian-lxqt.sh bash debian-lxqt.sh ;;
		0)
			return 0 ;;
		*)
			red "无效输入，请重试" 
			debiandechoose;;
	esac
	return 0
}

function centos(){
	echo "\n\n安装脚本来自于 Andronix"
	echo -e "\n\n"
	echo -e "1 安装 CentOS\n"
	sleep 0.016
	echo -e "2 卸载 CentOS\n"
	sleep 0.016
	echo -e "0 退出\n"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read centosde
	case $centosde in
		1)
			pkg install openssl-tool proot tar -y && hash -r && wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/CentOS/centos.sh && bash centos.sh ;;
		2)
			wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Uninstaller/CentOS/UNI-centos.sh && bash UNI-centos.sh ;;
		*)
			red "无效输入，请重试" 
			centos ;;
	esac
	return 0
}

function kali(){
	wget -O install-nethunter-termux https://offs.ec/2MceZWr
	chmod +x install-nethunter-termux
	./install-nethunter-termux
	return 0
}

function archlinux(){
	echo -e "\n\n"
	echo -e "1 安装 Arch Linux\n"
	sleep 0.016
	echo -e "2 修复 Arch Linux 安装\n"
	sleep 0.016
	echo -e "0 退出"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read archlinuxinstall
	case $archlinuxinstall in
		1)
			termuxarch ;;
		2)
			echo "脚本制作中,敬请期待" ;;
		0)
			return 0 ;;
		*)
			red "无效输入，请重试"
			archlinux ;;
	esac
	return 0
}

function termuxarch(){
	pkg i bsdtar nano proot
	wget -c https://raw.githubusercontent.com/TermuxArch/TermuxArch/master/setupTermuxArch.bash 
	bash setupTermuxArch.bash
	cp ~/arch/startarch $PREFIX/bin/startarch
	if [ -f "$PREFIX/bin/startarch" ];then
		echo "Arch Linux 安装完成!"
	else
		echo "Arch Linux 安装失败，请运行修复脚本"
	fi
	return 0
}

function adbconfig(){
	if [ -f "/data/data/com.termux/files/usr/bin/adb.bin" ];then
		adbconfigstatus=`green "true"`
	else
		adbconfigstatus=`red "false"`
	fi
	echo -e "\n\n"
	echo -e "项目地址: https://github.com/MasterDevX/Termux-ADB"
	echo -e "ADB 安装状态:" $adbconfigstatus
	echo -e "\n\n1 安装 ADB\n"
	sleep 0.016
	echo -e "2 卸载 ADB\n"
	sleep 0.016
	echo -e "3 查看 ADB 版本\n"
	sleep 0.016
	echo -e "0 退出\n"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read adbinstall
	case $adbinstall in
		1)
			apt update
			wget https://github.com/MasterDevX/Termux-ADB/raw/master/InstallTools.sh
			bash InstallTools.sh
			return 0 ;;
		2)
			if [ ! -f "/data/data/com.termux/files/usr/bin/adb" ];then
				red "您并未安装 ADB,无需进行此过程"
				return 0
			fi
			apt update
			wget https://github.com/MasterDevX/Termux-ADB/raw/master/RemoveTools.sh
			bash RemoveTools.sh
			return 0 ;;
		3)
			if [ -f "/data/data/com.termux/files/usr/bin/adb" ];then
				adb version
			else
				red "请先安装 ADB"
			fi
			return 0 ;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试" 
			adbconfig ;;
	esac
}

function yougetconfig(){
	if [ -f "/data/data/com.termux/files/usr/bin/you-get" ];then
		yougetconfigstatus=`green "true"`
	else
		yougetconfigstatus=`red "false"`
	fi
	if [ ! -f "/data/data/com.termux/files/usr/bin/python" ];then
		green "检测到未安装 Python，正在自动安装 Python…"
		pkg in python
	fi
	echo -e "\n\n项目地址: https://github.com/soimort/you-get/\n\n"
	echo -e "you-get 安装状态:" $yougetconfigstatus
	echo -e "\n\n"
	echo -e "1 安装 you-get\n"
	sleep 0.016
	echo -e "2 升级 you-get\n"
	sleep 0.016
	echo -e "3 you-get 使用方法\n"
	sleep 0.016
	echo -e "4 you-get 简易版[适合超小白用户]\n"
	sleep 0.016
	echo -e "5 卸载 you-get\n"
	sleep 0.016
	echo -e "0 退出\n"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read yougetoption
	case $yougetoption in
		1)
			pip3 install you-get
			green "done!"
			return 0 ;;
		2)
			pip3 install --upgrade you-get
			green "done!"
			return 0 ;;
		3)
			if [ -f "/data/data/com.termux/files/usr/bin/you-get" ];then
				you-get -h
				return 0
			else
				red "请先安装 you-get"
			fi
			yougetconfig ;;
		4)
			if [ -f "/data/data/com.termux/files/usr/bin/you-get" ];then
				yougeteasy
			else
				red "请先安装 you-get"
				return 0
			fi
			;;
		5)
			yes | pip uninstall you-get
			if [ ! -f "/data/data/com.termux/files/usr/bin/you-get" ];then
				green "卸载完成!"
			else
				red "卸载失败!"
			fi
			return 0 ;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试" 
			yougetconfig ;;
	esac
}

function yougeteasy(){
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
			youget1 ;;
		0)
			return 0 ;;
	
		*)
			red "无效输入,请重试"
			yougeteasy ;;
	esac 
}

function youget1(){
	echo -e "\n\n"
	echo "you-get 支持的链接种类: https://github.com/soimort/you-get/wiki/%E4%B8%AD%E6%96%87%E8%AF%B4%E6%98%8E#%E6%94%AF%E6%8C%81%E7%BD%91%E7%AB%99"
	echo "you-get 也可以下载网页上的视频和图片"
	echo -e "请输入您的下载链接[必填]"
	echo -en "\t\tEnter: "
	read yougetlink
	echo -e "请输入您的下载路径[选填,路径默认指向内置存储.比如,如果您输入 Download,则文件会下载至内置存储的 Download 文件夹中]"
	green "看不懂就直接回车"
	echo -en "\t\tEnter: "
	read tmpdiryouget
	echo -e "如果您输入的链接属于某一播放列表里面的一个,您是否想下载该列表里面的所有视频?[y/n]"
	echo -en "\t\tEnter: "
	read tmpyougetlist
	if  [ $tmpyougetlist = y ]; then
		yougetlist=--playlist
	fi
	yougetdownloaddir=/sdcard/$tmpdiryouget
	blue "下载即将开始..."
	you-get -o $yougetdownloaddir $yougetlist $yougetlink
	green "下载已停止!"
	green "这可能是因为所需下载内容已下载完毕,或者下载中断"
	return 0
}

function termuxapi(){
	if [ ! -f "/data/data/com.termux/files/usr/libexec/termux-api" ];then
		pkg in termux-api
	fi
	need=`blue "Need"`
	echo -e "\n\n"
	blue "注意,该界面部分功能需要安装并授权 Termux:API 才能使用"
	echo "Termux:API 链接: https://play.google.com/store/apps/details?id=com.termux.api"
	echo "需要 Termux:API 支持的选项会标注" $need
	echo -e "\n1 获取电池信息" $need
	sleep 0.016
	echo -e "\n2 获取相机信息" $need
	sleep 0.016
	echo -e "\n3 查看红外载波频率" $need
	sleep 0.016
	echo -e "\n4 获取无线电信息" $need
	sleep 0.016
	echo -e "\n5 获取 tts 语言引擎信息" $need
	sleep 0.016
	echo -e "\n6 获取当前 WiFi 连接信息" $need
	sleep 0.016
	echo -e "\n7 获取 WiFi 扫描信息[高版本 Android 不可用]" $need
	sleep 0.016
	echo -e "\n8 查看当前剪切板内容" $need
	sleep 0.016
	echo -e "\n9 获取手机 IMEI 号[规范的 Android 10 及以上设备不可用]"
	sleep 0.016
	echo -e "\n10 获取 CPU 信息"
	sleep 0.016
	echo -e "\n11 内存和交换空间使用状态"
	sleep 0.016
	echo -e "\n12 存储使用状态"
	sleep 0.016
	echo -e "\n99 将所有信息输出到日志" $need
	sleep 0.016
	echo -e "\n0 退出"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read termuxapichoose
	case $termuxapichoose in
		1)
			termux-battery-status
			sleep 3
			termuxapi ;;
		2)
			termux-camera-info
			sleep 3
			termuxapi ;;
		3)
			termux-infrared-frequencies
			sleep 3
			termuxapi ;;
		4)
			termux-telephony-cellinfo
			sleep 3
			termuxapi ;;
		5)
			termux-tts-engines
			sleep 3
			termuxapi ;;
		6)
			termux-wifi-connectioninfo
			sleep 3
			termuxapi ;;
		7)
			termux-wifi-scaninfo
			sleep 3
			termuxapi ;;
		8)
			termux-clipboard-get
			sleep 3
			termuxapi ;;
		9)
			getprop |grep imei
			sleep 3
			termuxapi ;;
		10)
			lscpu
			sleep 3
			termuxapi ;;
		11)
			free -h
			sleep 3
			termuxapi ;;
		12)
			df -h
			sleep 3
			termuxapi ;;
		0)
			return 0 ;;
		99)
			echo -e "\n请输入您想要保存的 log 的名字[必填]"
			echo -en "\t\tEnter: "
			read tmplogsname
			userlogname=$userlogsname.txt
			logspwdname=$HOME/logs/$userlogname
			mkdir -p $HOME/logs
			green "正在写入日志…"
			green "如果未安装 Termux:API 并授权则会一直卡在该界面"
			termux-battery-status >> $logspwdname
			termux-camera-info >> $logspwdname
			termux-infrared-frequencies >> $logspwdname
			termux-telephony-cellinfo >> $logspwdname
			termux-tts-engines >> $logspwdname
			termux-wifi-connectioninfo >> $logspwdname
			termux-wifi-scaninfo >> $logspwdname
			termux-clipboard-get >> $logspwdname
			getprop |grep imei >> $logspwdname
			lscpu >> $logspwdname
			free -h >> $logspwdname
			df -h >> $logspwdname
			green "日志写入完成!"
			termuxapi ;;
	esac
}

function logsgen(){
	date=$(date)
	log=log_gen.log
	mkdir -p $HOME/logs
	touch $HOME/logs/tmp_$log
	echo -e "====Device info====\n\n" >> $HOME/lo8gs/tmp_$log
	echo -e "$log" >> $HOME/logs/tmp_$log
	echo "<----Props---->" >> $HOME/logs/tmp_$log
	getprop >> $HOME/logs/tmp_$log
	echo -e "\n\n" >> $HOME/logs/tmp_$log
	echo "<----System info---->" >> $HOME/logs/tmp_$log
	echo "Logged In users:" >> $HOME/logs/tmp_$log
	whoami >> $HOME/logs/tmp_$log
	echo -e "\n\n" >> $HOME/logs/tmp_$log
	echo "<----Hardware info---->" >> $HOME/logs/tmp_$log
	echo "CPU info:"
	lscpu >> $HOME/logs/tmp_$log
	echo "Memory and Swap info:" >> $HOME/logs/tmp_$log
	free -h >> $HOME/logs/tmp_$log
	echo "Internet info:" >> $HOME/logs/tmp_$log
	ifconfig >> $HOME/logs/tmp_$log
	echo "Disk Usages :" >> $HOME/logs/tmp_$log
	df -h >> $HOME/logs/tmp_$log
	mv -f $HOME/logs/tmp_$log $HOME/logs/$log
	if [ -f "$HOME/logs/$log" ];then
	  	green "日志生成成功!"
	else
	  	red "日志生成失败!"
	fi
	return 0
}

function logs(){
	mkdir -p $HOME/logs
	red "请不要在任何非必要的情况下将日志发送给任何人!!"
	green "初始化日志会在每次脚本初始化时自动生成"
	green "旧的初始化日志会在每次脚本初始化时自动删除"
	echo -e "\n\n"
	echo -e "1 查看日志\n"
	sleep 0.016
	echo -e "2 立即生成日志\n"
	sleep 0.016
	echo -e "3 清空日志\n"
	sleep 0.016
	echo -e "0 退出\n"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read logschoose
	case $logschoose in
		1)
			echo -e "\n日志列表如下:\n"
			ls $HOME/logs/
			echo "请输入您想要查看的日志的名字"
			echo -en "\t\tEnter: "
			read logsname
			cat $HOME/logs/$logsname
			return 0 ;;
		2)
			logsgen
		        return 0 ;;
		3)
			rm -rf $HOME/log
			mkdir $HOME/logs
			return 0 ;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试"
			logs ;;
	esac
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
clear
