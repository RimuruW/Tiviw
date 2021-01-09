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

