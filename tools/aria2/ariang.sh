#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (QingxuMo)
# Description: Termux Tools
# Repository Address: https://github.com/QingxuMo/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------
ariangconfig=null
[[ ! -f "$PREFIX/bin/aria2c" ]] && red "请先安装 Aria2" && Step && source $PREFIX/etc/tiviw/main/tools/aria2/aria2config.sh
blue "AriaNG 只是一个静态网页,直接打开在线网页和使用本地客户端在功能上并没有什么不同."
blue "但是对于 Android 用户，我推荐安装 AriaNG GUI 客户端以便于连接和管理 Aria2"
blue "故此，该界面给出了两个选择，您可以根据您的需求和使用偏好选择对于您来说的最佳选项."
echo "1 安装 AriaNG 客户端［该选项会自动跳转客户端下载网页]"
echo "2 直接打开在线网页(仍需要手动填写配置信息)"
echo "0 退出"
echo -en "您的选择是："
read ariangconfig
case $ariangconfig in
	1)
		termux-open-url https://github.com/Xmader/aria-ng-gui-android/releases ;;
	2)
		termux-open-url http://mirror-aria2.qingxu.live/ ;;
	0)
		source $PREFIX/etc/tiviw/main/tools/aria2/aria2config.sh ;;
	*)
		red "无效输入，请重试" 
		source $PREFIX/etc/tiviw/main/tools/aria2/ariang.sh
		;;
esac
