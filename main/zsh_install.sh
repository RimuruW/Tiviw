#!/data/data/com.termux/files/usr/bin/bash
#-----------------------------------
# Author: Qingxu (RimuruW)
# Description: Termux Tools
# Repository Address: https://github.com/RimuruW/Tovow
# Copyright (c) 2020 Qingxu
#-----------------------------------

[[ -d "$HOME/.oh-my-zsh" ]] && red "检测到您已安装 Oh My ZSH，安装终止" && return 0
echo "安装所需依赖中……"
pkg in zsh git curl -y >/dev/null
green "如果下面需要您进行确认，请输入 y 确认"
chsh -s zsh
sh -c "$(sed -e "/exec zsh -l/d" <<< $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
sed -i "s/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g" ~/.zshrc
sed -i "s/plugins=(git)/plugins=(git extract web-search zsh-autosuggestions zsh-completions zsh-syntax-highlighting)/g" ~/.zshrc
green "ZSH 配置完成，你可在 ~/.zshrc 中修改主题"
