#!/data/data/com.termux/files/usr/bin/bash
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
light_cyan='\033[1;96m'
reset='\033[0m'

function ask() {
    # http://djm.me/ask
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question
        printf '%s' "${light_cyan}" "[?]"
        read -r -p "$1 [$prompt] " REPLY

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        printf '%s\n' "${reset}"

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}


check_mirrors() {
	mirrors_status=$(grep "mirror" "$PREFIX/etc/apt/sources.list" | grep -v '#')
	if [ -z "$mirrors_status" ]; then
		printf  '%s\n' "${red}[!] Termux 镜像源未配置！"
		printf '%s\n' "${blue}对于国内用户，添加清华源作为镜像源可以有效增强 Termux 软件包下载速度"
		if ask "是否添加清华源？[y/n]" "N"; then
				sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' "$PREFIX/etc/apt/sources.list"
				sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@'"$PREFIX/etc/apt/sources.list.d/game.list"
				sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' "$PREFIX/etc/apt/sources.list.d/science.list"
				apt update && apt upgrade -y
			else
				blue "使用默认源进行安装"
		fi
	fi
}

# Check
if [[ $EUID -eq 0 ]]; then
		printf '%s\n' "$red"
	cat <<-'EOF'
检测到您正在尝试使用 ROOT 权限运行安装脚本
这是不建议且不被允许的
安装全过程不需要 ROOT 权限,且以 ROOT 权限运行可能会带来一些无法预料的问题
为了您的设备安全，请避免在任何情况下以 ROOT 用户运行安装脚本
	EOF
	printf '%s\n' "$reset"
	exit 1
fi
if [[ -d /system/app && -d /system/priv-app ]]; then
	systeminfo="Android $(getprop ro.build.version.release)"
	export systeminfo
else
	printf '%s\n' "$(red)[!] This operating system is not supported."
	exit 1
fi

if [ -d "$PREFIX/etc/tiviw" ]; then
	printf '%s\n' "${yellow}您已安装 Tiviw ，无需重复安装" "如果您需要移除 Tiviw，请输入 rm -rf $PREFIX/etc/tiviw"
	exit 1
fi

check_mirrors

printf '%s\n' "${blue}[*] 检查依赖中…"
apt-get update -y &> /dev/null
for i in git wget; do
if [ -e "$PREFIX/bin/$i" ]; then
	echo "  $i 已安装！"
else
	printf '%s\n'  "Installing $i..." '%s\n'
	apt-get install -y $i || {
		printf '%s' "$(red)[!] 依赖安装失败! " "退出中……"
			exit
		}
fi
done
apt-get upgrade -y

printf '%s\n' "$(blue)[*] 正在创建工作目录…"
mkdir -p "$PREFIX/etc/tiviw"
mkdir -p "$PREFIX/etc/tiviw/logs" "$PREFIX/etc/tiviw/linux" "$PREFIX/etc/tiviw/etc"

printf '%s\n' "$(blue)[*] 正在拉取远程仓库…"
git clone https://github.com.cnpmjs.org/QingxuMo/Tiviw "$PREFIX/etc/tiviw/main"

printf '%s\n' "$(blue)[*] 正在修改远程仓库地址…"
cd "$PREFIX/etc/tiviw/main" || { printf "目录跳转失败！" >&2;  exit 1; }
git remote set-url origin https://github.com/QingxuMo/Tiviw

printf '%s\n' "$(blue)[*] 正在检查远程仓库地址…"
remote_status="$(git remote -v | grep "https://github.com/QingxuMo/Tiviw")"
[[ -z "$remote_status" ]] && printf '%s\n' "$(red)[!] 远程仓库地址修改失败!" "请提交错误内容至开发者！"

printf '%s\n' "$(blue)[*] 正在校验其他选项…"

cd "$HOME" || { printf '%s\n' "$(red)[!] 目录跳转失败！" >&2;  exit 1; }

printf '%s\n' "$(blue)[*] 正在修改文件权限…"
bash "$PREFIX/etc/tiviw/main/permission.sh"

printf '%s\n' "$(blue)[*] 正在创建启动器…"
rm -f "$PREFIX/bin/tiviw"
cp "$PREFIX/etc/tiviw/main/tiviw" "$PREFIX/bin/tiviw"
chmod +x "$PREFIX/bin/tiviw"

if [ -f "$PREFIX/bin/tiviw" ]; then
	printf '%s\n' "$(green)[√]  安装成功！请输入 tiviw 启动脚本！"
	exit 0
else
	printf '%s\n' "$(red)[x] 安装失败！请提交错误内容至开发者！"
	printf '%s\n' "$(red)[*] 错误：启动器安装失败"
	exit 1
fi
