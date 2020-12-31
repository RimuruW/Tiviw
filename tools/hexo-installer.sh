#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (RimuruW)
# Description: Hexo one-click installation cript for Termux.
# Repository Address: https://github.com/RimuruW/Termux-Hexo-installer
# Version: 0.2
# Copyright (c) 2020 Qingxu
#-----------------------------------
clear
if check_apt_ability; then
	pkg in nodejs-lts git vim openssh unzip -y
else
	red "脚本认定你当前环境无法完成安装！"
	red "安装中止！"
	exit 1
fi
if npm_mirror_check; then
	green "NPM 镜像源已配置"
else
	if network_check_sea; then
		green "网络连接正常，无需镜像源"
	else
		green "是否更换 NPM 源为淘宝源? [y/n]"
		echo -en "Enter an option: "
		read npmtaobao
		case $npmtaobao in
			y)
				npm config set registry https://registry.npm.taobao.org ;;
			n)
				echo "Use default" ;;
			*)
				echo "输入无效,使用默认源" ;;
		esac
	fi
fi
npm install -g npm
npm install -g hexo-cli
blue "是否立即创建一个文件夹并初始化？"
Enter
read hexoinit
case $hexoinit in
	y*)
		green "请输入您想创建的 Hexo 博客文件夹名称 [必填]"
		echo -en "\t\tEnter the name: "
		read blogname
		[[ -z "$blogname" ]] && red "未获取到博客文件夹名称，初始化失败！" && exit 1
		mkdir -p $HOME/$blogname
		blog=$HOME/$blogname
		hexo init $blog
		npm install --prefix $blog hexo-deployer-git hexo-generator-feed hexo-generator-sitemap --save
		echo "Hexo 已初始化并已安装基础模块，请勿重复进行 hexo init"
		echo "博客目录默认为 $blog"
		;;
	n*)
		echo "跳过初始化…"
		;;
	*)
		red "无效输入，跳过初始化…"
		;; 
echo "Hexo 版本信息如下"
hexo version
