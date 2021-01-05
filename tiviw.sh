if ping -q -c 1 -W 1 google.com >/dev/null; then
	bash -c "$(curl -L https://raw.githubusercontent.com/RimuruW/Tiviw/dev/install.sh)"
else
	bash -c "$(curl -L https://gitee.com/RimuruW/tiviw/raw/dev/install.sh)"
fi
