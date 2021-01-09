if [ -f "/data/data/com.termux/files/usr/bin/startvnc" ];then
	termuxguistatus=`green "true"`
else
	termuxguistatus=`red "false"`
fi
termuxguiinstall=null
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
			red "您已安装图形化界面,不必重复进行安装"
			Step
			source $ToolPATH/core/termuxplugin/termuxgui.sh
			return 1
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
			red "Termux GUI 安装失败"
			Step
		fi
		source $ToolPATH/core/termuxplugin/termuxgui.sh
		return 0
		;;
	2)
		green "输入 startvnc 即可启动 VNC 服务"
		green "输入 Ctrl+C 即可终止 VNC 服务"
		green "在启动 VNC 服务前，请安装 VNC Viewer"
		green "下载链接: https://play.google.com/store/apps/details?id=com.realvnc.viewer.android"
		Step
		source $ToolPATH/core/termuxplugin/termuxgui.sh
		return 0
		;;
	0)
		source $ToolPATH/core/termuxplugin/index.sh && return 0 ;;
	*)
		red "无效输入,请重试" 
		termuxguiinstall=null
	    source $ToolPATH/core/termuxplugin/termuxgui.sh && return 0 ;;
esac
