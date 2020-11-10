#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tiviw
# Copyright (c) 2020 Qingxu
#-----------------------------------

source $PREFIX/etc/tiviw/main/script/function.sh

function Linux(){
    installlinux=null
    red "目前作者无自制作的 Linux 发行版安装脚本，因此目前采用第三方 Linux 发行版安装脚本。"
    red "第三方脚本无任何可用性保障！作者不保证其可以正常工作！"
    red "第三方安装脚本需要能正常连接 GitHub 才可以使用"
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
		    installlinux=null
			red "无效输入,请重试"
	esac
	return 0
}

function ubuntu(){
    ubuntude=null
	echo -e "\n\n 安装脚本来自于 Andronix"
	green "是否安装桌面环境?[y/n]"
	echo -en "\t\tEnter an option: "
	read ubuntude
	case $ubuntude in
		y)
			ubuntudechoose ;;
		n)
			pkg update -y && pkg install wget curl proot tar -y && wget https://raw.githubusercontent.com/AndronixApp/AndronixOrigin/master/Installer/Ubuntu/ubuntu.sh && chmod +x ubuntu.sh && bash ubuntu.sh ;;
		*)
			ubuntude=null && echo "无效输入，请重试" ;;
	esac
	return 0
}

function ubuntudechoose(){
    udechoose=null
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
			ubuntudechoose=null && red "无效输入，请重试" 
			ubuntudechoose;;
	esac
	return 0
}

function debian(){
    debiande=null
	echo -e "\n\n安装脚本来自于 Andronix"
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
			debiande=null && echo "无效输入，请重试" ;;
	esac
	return 0
}

function debiandechoose(){
    ddechoose=null
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
			debiandechoose=null && debiandechoose;;
	esac
	return 0
}

function centos(){
    centosde=null
	echo -e "\n\n安装脚本来自于 Andronix"
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
			centosde=null && centos ;;
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
    archlinuxinstall=null
	echo -e "\n\n"
	echo -e "1 安装 Arch Linux\n"
	sleep 0.016
	echo -e "0 退出"
	sleep 0.016
	echo -en "\t\tEnter an option: "
	read archlinuxinstall
	case $archlinuxinstall in
		1)
			termuxarch ;;
		0)
			return 0 ;;
		*)
			red "无效输入，请重试"
			archlinuxinstall=null
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

function termuxapi(){
    termuxapichoose=null
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
		*)
		    red "无效输入，请重试！"
		    termuxapichoose=null
		    termuxapi ;;
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
    option=null
	printf "$BLUE"
	cat <<-'EOF'
                                                    
_/_/_/_/_/  _/              _/                      
   _/          _/      _/      _/      _/      _/   
  _/      _/  _/      _/  _/  _/      _/      _/    
 _/      _/    _/  _/    _/    _/  _/  _/  _/       
_/      _/      _/      _/      _/      _/          
                                                    
	EOF
	printf "$RESET"
        echo -en "\t\t\t\t$VERSION"
        [[ $branch = dev ]] && red " dev"
        [[ $branch = master ]] && green " master"
	echo -e "\t\t\t\tBy Qingxu (QingxuMo)"
#if  [ $(which fortune) = /data/data/com.termux/files/usr/bin/fortune ]; then
#    fortune
#else
#    pkg in fortune -y
#    fortune
#fi
    echo -e "\n\n"
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
	    	    source $ToolPATH/main/script/storage.sh ;;
	    4)
	    	    source $ToolPATH/main/script/zsh_install.sh ;;
	    5)
	    	    source $ToolPATH/main/termuxplugin/menu.sh ;;
	    6)
	    	    source $ToolPATH/main/tools/menu.sh ;;
	    7)
	    	    termuxapi ;;
	    8)
	    	    Linux ;;
	    9)
	            green "功能还未上线，敬请期待…"
	            echo "作者：一想到我是一个鸽子，许多版本就烟消云散了" ;;
	    99)
	    	    source $ToolPATH/main/script/about.sh ;;
	    *)
		    red "无效输入，请重试"
		    option=null  ;;
    esac
done

