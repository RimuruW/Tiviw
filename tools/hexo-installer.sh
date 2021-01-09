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
	check_dependency "nodejs-lts git vim openssh unzip"
else
	echo "${RED}[!]${RESET} 脚本认定你当前环境无法完成安装！"
	echo "${RED}[!]${RESET} 安装中止！"
	exit 1
fi
if check_npm_mirror; then
	echo "${GREEN}[√]${RESET} NPM 镜像源已配置"
else
	if network_check_sea; then
		echo "${GREEN}[√]${RESET} 网络连接正常，无需镜像源"
	else
		if ask "是否更换 NPM 源为淘宝源?" "Y"; then
			npm config set registry https://registry.npm.taobao.org
		else
			echo "${RED}[!]${RESET} Use default"
		fi
	fi
fi
npm install -g npm
npm install -g hexo-cli
if ask "是否立即创建一个文件夹并初始化？" "N"; then
	green "请输入您想创建的 Hexo 博客文件夹名称 [必填]"
	echo -en "\tEnter the name: "
	read -r blogname
	[[ -z "$blogname" ]] && red "未获取到博客文件夹名称，初始化失败！" && exit 1
	mkdir -p "$HOME/$blogname"
	blog="$HOME/$blogname"
	hexo init "$blog"
	npm install --prefix "$blog" hexo-deployer-git hexo-generator-feed hexo-generator-sitemap --save
	echo "Hexo 已初始化并已安装基础模块，请勿重复进行 hexo init"
	echo "博客目录默认为 $blog"
else
	echo "跳过初始化…"
fi
echo "Hexo 版本信息如下"
hexo version
