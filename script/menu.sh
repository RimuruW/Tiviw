#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

source $PREFIX/etc/tconfig/main/script/function.sh


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
		pkg in python -y >/dev/null
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
			yougetconfig ;;
		2)
			pip3 install --upgrade you-get
			green "done!"
			yougetconfig ;;
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
				yougetconfig
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
			yougetconfig ;;
	
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
	echo -e "请输入您的下载路径[选填,路径默认指向内置存储.比如，如果您输入 Download，则文件会下载至内置存储的 Download 文件夹中]"
	green "看不懂就直接回车"
	echo -en "\t\tEnter: "
	read tmpdiryouget
	echo -e "如果您输入的链接属于某一播放列表里面的一个,您是否想下载该列表里面的所有视频?[y/n]"
	green "看不懂就直接回车"
	echo -en "\t\tEnter: "
	read tmpyougetlist
	if  [ $tmpyougetlist = y ]; then
		yougetlist=--playlist
	fi
	yougetdownloaddir=/sdcard/$tmpdiryouget
	mkdir -p $yougetdownloaddir
	blue "下载即将开始..."
	you-get -o $yougetdownloaddir $yougetlist $yougetlink
	green "下载已停止!"
	green "这可能是因为所需下载内容已下载完毕,或者下载中断"
	yougetconfig
}

function termuxapi(){
	if [ ! -f "/data/data/com.termux/files/usr/libexec/termux-api" ];then
		pkg in termux-api -y
	fi
	unset termuxapichoose
	[[ ! -z $termuxapichoose ]] && red "程序出现了内部错误，强制返回标题界面" && echo -en "\n\n\t\t\t请回车以继续" && read -n 1 line &&  menu
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
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		2)
			termux-camera-info
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		3)
			termux-infrared-frequencies
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		4)
			termux-telephony-cellinfo
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		5)
			termux-tts-engines
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		6)
			termux-wifi-connectioninfo
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		7)
			termux-wifi-scaninfo
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		8)
			termux-clipboard-get
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		9)
			getprop |grep imei
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		10)
			lscpu
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		11)
			free -h
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		12)
			df -h
			echo -en "\n\n\t\t\t点击任意键以继续"
			read -n 1 line
			termuxapi ;;
		0)
			return 0 ;;
		99)
			echo -e "\n请输入您想要保存的 log 的名字[必填]"
			echo -en "\t\tEnter: "
			read tmplogsname
			[[ -z $tmplogsname ]] && red "请输入 log 的名字" && echo -en "\n\n\t\t\t请回车以继续" && read -n 1 line && termuxapi
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
			ls $HOME/logs/ $ToolPATH/logs/
			echo "请输入您想要查看的日志的名字"
			echo -en "\t\tEnter: "
			read logsname
			if [ -f "$HOME/logs/$logsname" ]; then
				cat $HOME/logs/$logsname
			else
				cat $ToolPATH/logs/$logsname
			fi
			return 0 ;;
		2)
			logsgen
		        return 0 ;;
		3)
			rm -rf $HOME/logs $ToolPATH/logs/*
			mkdir $HOME/logs 
			return 0 ;;
		0)
			return 0 ;;
		*)
			red "无效输入,请重试"
			logs ;;
	esac
}

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
	echo -e "\t\t\tBy Qingxu (QingxuMo)"
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
	    	    source $ToolPATH/main/script/mirror.sh ;;
	    2)
	    	    source $ToolPATH/main/script/board.sh ;;
	    3)
	    	    storage ;;
	    4)
	    	    source $ToolPATH/main/script/zsh_install.sh ;;
	    5)
	    	    source $ToolPATH/main/termuxplugin/menu.sh ;;
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

