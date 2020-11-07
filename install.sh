#!/data/data/com.termux/files/usr/bin/sh
function blue(){
	echo -e "\033[34m\033[01m$1\033[0m"
}
function green(){
	echo -e "\033[32m\033[01m$1\033[0m"
}
function red(){
	echo -e "\033[31m\033[01m$1\033[0m"
}

check_mirrors() {
	mirrors_status=$(cat $PREFIX/etc/apt/sources.list | grep "mirror" | grep -v '#')
	if [ -z "$mirrors_status" ]; then
		red "Termux 镜像源未配置！"
		echo -e "对于国内用户，添加清华源作为镜像源可以有效增强 Termux 软件包下载速度"
		echo -en "是否添加清华源？[y/n]"
		read mirror_choose
		case $mirror_choose in
			y)
				sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
				sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
				sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
				apt update && apt upgrade -y
				;;
			n)
				blue "使用默认源进行安装"
				;;
			*)
				blue "使用默认源进行安装"
				;;
		esac
	fi

}

# Check
if [[ $EUID -eq 0 ]]; then
	red "检测到您正在尝试使用 ROOT 权限运行安装脚本"
	red "这是不建议且不被允许的"
	red "安装全过程不需要 ROOT 权限,且以 ROOT 权限运行可能会带来一些无法预料的问题"
	red "为了您的设备安全，请避免在任何情况下以 ROOT 用户运行安装脚本"
	exit 1
fi
if [[ -d /system/app && -d /system/priv-app ]]; then
	systeminfo="Android $(getprop ro.build.version.release)"
else
	red "This operating system is not supported."
	exit 1
fi

if [ -d $PREFIX/etc/tiviw ]; then
	red "您已安装 Tiviw ，无需重复安装"
	red "如果您需要移除 Tiviw，请输入 rm -rf $PREFIX/etc/tiviw"
	exit 1
fi

check_mirrors


if [ ! -f $PREFIX/bin/wget ]; then
	red "警告，您并未安装 wget！"
	blue "将自动安装 wget..."
	blue "对于国内用户，未配置镜像源会导致安装时间极长"
	apt-get update && apt-get install wget -y
	[[ ! -f $PREFIX/bin/wget ]] && red "wget 安装失败" && exit 1
fi

if [ ! -f $PREFIX/bin/git ]; then
	red "警告，您并未安装 git！"
	blue "将自动安装 git..."
	blue "对于国内用户，未配置镜像源会导致安装时间极长"
	apt-get update && apt-get install git -y
	[[ ! -f $PREFIX/bin/git ]] && red "git 安装失败" && exit 1
fi

green "正在创建工作目录…"
mkdir -p $PREFIX/etc/tiviw
mkdir -p $PREFIX/etc/tiviw/logs $PREFIX/etc/tiviw/linux $PREFIX/etc/tiviw/etc

green "正在拉取远程仓库…"
git clone https://github.com.cnpmjs.org/QingxuMo/Tiviw $PREFIX/etc/tiviw/main

green "正在修改远程仓库地址…"
cd $PREFIX/etc/tiviw/main
git remote set-url origin https://github.com/QingxuMo/Tiviw

green "正在检查远程仓库地址…"
remote_status="$(git remote -v | grep "https://github.com/QingxuMo/Tiviw")"
[[ -z "$remote_status" ]] && red "远程仓库地址修改失败!\n请提交错误内容至开发者！"

green "正在校验其他选项…"

cd $HOME

green "正在修改文件权限…"
bash $PREFIX/etc/tiviw/main/permission.sh

green "正在创建启动器…"
rm -f $PREFIX/bin/tiviw
cp $PREFIX/etc/tiviw/main/tiviw $PREFIX/bin/tiviw
chmod +x $PREFIX/bin/tiviw

if [ -f $PREFIX/bin/tiviw ]; then
	green "安装成功！请输入 tiviw 启动脚本！"
	exit 0
else
	red "安装失败！请提交错误内容至开发者！"
	red "错误：启动器安装失败"
	exit 1
fi
