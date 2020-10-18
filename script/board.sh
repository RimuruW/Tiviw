#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

if [ -f "$HOME/.termux/termux.properties" ]; then
	red "检测到您已经修改了小键盘，继续操作将会覆盖您的自定义设置，是否继续？[y/n]"
	echo -en "\t\tEnter an option: "
	read boardresetchoose
	case $boardresetchoose in
		y)
			rm -f $HOME/.termux/termux.properties
			;;
		*)
			echo "操作终止"
			return 0
			;;
	esac
fi
mkdir -p ~/.termux
echo -e "extra-keys = [['TAB','>','-','~','/','*','$'],['ESC','(','HOME','UP','END',')','PGUP'],['CTRL','[','LEFT','DOWN','RIGHT',']','PGDN']]" > ~/.termux/termux.properties
termux-reload-settings
green  "请重启终端使小键盘显示正常"
exit 0
