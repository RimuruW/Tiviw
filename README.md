# Tiviw

> 警告⚠ 
> 
> 本项目仍处于基础功能开发中，功能及界面仍在完善之中。因 bug 过多可能造成脚本无法正常使用，故强烈建议**先不要使用本项目直至本项目结束基础功能开发**！
> 
> 因本项目开发历时过长，可能会出现前后代码风格不一致等问题，目前不接受任何有关此类原因造成的 bug 的 issue 直至结束基础功能开发。

## 简介

Tiviw 是一个致力于最简化 Termux 操作的项目。Tiviw 集成多项 Termux 上可用的实用功能，并提供含 Termux 基础功能在内的最简式交互操作。

注意，Tiviw 始终是一个**测试项目**。所有我认为可行的脚本样式和结构（即新功能）会优先在 Tiviw 完成测试，在 Tiviw 测试稳定后将新功能投放到我的其他项目。也就是说，我的其他项目的代码风格和文件结构以及交互方式最终会和 Tiviw 保持**完全一致**。这也意味着 Tiviw 始终是一个**不稳定**项目。

## Features

- 易于操作的交互界面
- 较完善的自检测功能
- 内置的脚本更新功能
- 较完善的网络检测功能
- 多分支切换

## 使用方法

### 一键自动安装 Tiviw
Tiviw 提供一键安装脚本，支持一键自动安装。**一键安装脚本不需要 root 权限。**

一键自动安装命令
```bash
bash -c "$(curl -sL https://raw.githubusercontent.com/RimuruW/Tiviw/dev/install.sh)"
```

该命令会自动根据设备网络环境选择安装脚本下载渠道，并创建`$PREFIX/etc/tiviw`目录作为工作目录，**请勿手动对该目录进行任何更改**以避免脚本运行异常。

### 手动安装 Tiviw（绝大多数情况下不建议）
Tiviw 同样可以通过手动输入命令完成安装。当 Tiviw 的安装脚本出现问题造成 Tiviw 无法正常安装时，手动安装可以有效避免某些不应该出现的问题。

#### 1. 安装必要的依赖软件包

Tiviw 依赖`git`和`wget`实现最基本的脚本功能，可以通过下面的命令完成该依赖的安装。
```bash
pkg i git wget -y
```
> 对于国内用户，你可能需要先输入以下命令更换 Termux 默认源为清华源后才可以完成依赖安装

> 一键更换清华源命令
> ```bash
> sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' "$PREFIX/etc/apt/sources.list"
> sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' "$PREFIX/etc/apt/sources.list.d/game.list"
> sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' "$PREFIX/etc/apt/sources.list.d/science.list"
> apt update && apt upgrade -y
> ```

#### 2. 创建 Tiviw 工作目录
Tiviw 默认使用`$PREFIX/etc/tiviw`作为 Tiviw 的工作目录，暂不支持更改工作目录。

可输入如下命令创建 Tiviw 工作目录
```bash
mkdir -p "$PREFIX/etc/tiviw"
# 以下为可选目录，用于存放某些配置文件和缓存文件及日志文件。不创建以下文件夹可能造成脚本基础功能运行出错。
mkdir -p "$PREFIX/etc/tiviw/logs" "$PREFIX/etc/tiviw/linux" "$PREFIX/etc/tiviw/etc"
```

#### 3. 拉取仓库源码
Tiviw 项目所有源代码均存放于`$PREFIX/etc/tiviw/core`，可输入如下命令 clone 源代码至`$PREFIX/etc/tiviw/core`目录。
```bash
git clone https://github.com/RimuruW/Tiviw "$PREFIX/etc/tiviw/core"
## 对于国内用户，请输入以下代码
# git clone https://gitee.com/RimuruW/tiviw "$PREFIX/etc/tiviw/core"
```

#### 4. 修改文件权限（可选）
一般情况下，Tiviw 仓库中的脚本文件都是可直接执行的文件，且 Tiviw 中脚本均使用 bash 执行故一般不存在脚本执行权限问题。但为避免某些特殊情况造成的不必要麻烦，建议手动进行脚本文件权限修改。

你可以通过如下命令运行 Tiviw 内置的权限修改脚本一键 chmod 脚本文件
```bash
bash "$PREFIX/etc/tiviw/core/permission.sh"
```

如果你希望手动修改脚本权限，请输入如下命令
```bash
find $PREFIX/etc/tiviw -name "*.sh" -exec chmod +x {} \;
[[ -f $PREFIX/etc/tiviw/core/tiviw ]] && chmod +x $PREFIX/etc/tiviw/core/tiviw
[[ -f $PREFIX/bin/tiviw ]] && chmod +x $PREFIX/bin/tiviw
```

#### 5. 移动启动器至 bin 目录
为简化 Tiviw 启动命令，Tiviw 内置简单启动器以轻松执行存放于多级目录内的脚本文件。

输入如下命令可以移动启动器至 bin 目录并修改权限以全局使用启动器
```bash
cp "$PREFIX/etc/tiviw/core/tiviw" "$PREFIX/bin/tiviw"
chmod +x "$PREFIX/bin/tiviw"
```

**至此，手动安装已全部结束。**

### 启动 Tiviw
Tiviw 支持使用启动器全局启动和直接执行相应脚本文件启动。

使用启动器启动 Tiviw
```
tiviw
```

直接执行相应脚本文件
```bash
bash $PREFIX/etc/tiviw/core/main/logsmanager.sh
bash $PREFIX/etc/tiviw/core/main/index.sh | tee -a $PREFIX/etc/tiviw/logs/1.log
```

> 注意，**请勿以 root 权限执行 Tiviw**！这可能造成某些**未知的 bug** 并造成**无法挽回的损失**！Tiviw 已内置 root 权限检测，在检测到用户使用 root 权限执行脚本时自动中止脚本。

### 删除 Tiviw
目前 Tiviw 仅支持手动删除工作目录完成 Tiviw 的删除。

输入如下命令删除 Tiviw 工作目录
```bash
rm -rf $PREFIX/etc/tiviw
```

注意，该命令仅可以从你的 Termux 中删除 Termux 而不支持回退任何 Tiviw 对 Termux 的修改（例如替换 bash 为 zsh）。

## 多分支说明
Tiviw 采用多分支模式进行项目开发，并向用户提供以下两个分支供用户自由选择。

用户可在「关于脚本」-「切换分支」处切换分支。

### 文字说明

#### dev 分支（面向开发者）

**注意，绝大多数情况下，你都不应该使用此分支！**

**目前仅接受 dev 分支的 pull request。**

dev 分支是我自测试脚本功能所开设的分支，所有代码更新会直接推送到 dev 分支而**不经过任何审查**，故可能存在极多 bug 甚至无法启动。与之相应，因 dev 分支始终保持最新代码，所以 dev 分支的 bug 可以第一时间得到处理。除此之外，dev 分支可以第一时间享受到 Tiviw 的新功能。Tiviw 安装脚本默认使用 dev 分支的安装脚本。

为确保 dev 分支用户 Tiviw 始终保持最新版本以获取最新功能与 bug 修复，用户使用 dev 分支时每次启动 Tiviw 都会强制检查云端版本号并在云端版本号高于本地版本号时强制覆盖更新本地版本。

#### master 分支（推荐绝大多数用户）

当 dev 分支趋于稳定时，dev 分支代码将会合并至 master 分支。这意味着 master 分支最终功能会与 dev 分支一致且较之 dev 分支更为稳定（理论上）。

原则上不会有任何直接推送至 master 分支的代码更新以避免分支合并问题。当 master 分支出现某些影响使用的 bug 时，我不会直接对其进行处理，而是在 dev 分支进行相应 bug 修复，并等待 dev 分支趋于稳定时合并 dev 分支至 master 分支。故 master 分支问题修复速度远慢于 dev 分支，且当 dev 分支出现某些暂时无法解决的冲突时，问题始终不会被处理。

### 图表说明

| 特性\分支 | master | dev |
|:----:|:----:|:----:|
|   面向群体   |   绝大多数用户   |   仅面向开发者   |
|   稳定性   |   理论上较稳定   |   极不稳定   |
|   功能性   |   少于 dev 分支但基本可以稳定使用   |   保持 Tiviw 的最新功能   |
|   问题处理   |   极慢。若 dev 存在无法解决的冲突则问题不会被处理直至解决 dev 分支冲突   |   第一时间处理   |
|   代码更新方式   |   当 dev 分支趋于稳定时直接合并 dev 分支代码   |   代码直接推送更新   |
|   其他   |   暂无   |   仅接受 dev 分支的 pull request   |

## 代码托管平台说明
目前 Tiviw 代码仅存放于 [GitHub](https://github.com/RimuruW/Tiviw) 和 [Gitee](https://gitee.com/RimuruW/tiviw)。

目前对于多平台处理策略为：
- 代码默认推送至 GitHub，然后利用 [GitHub Action](https://raw.githubusercontent.com/RimuruW/Tiviw/dev/.github/workflows/sync.yml) 同步代码至 Gitee。
- 在脚本内置的网络检测中，网络受限的用户将会从 Gitee 拉取代码（脚本更新及其他脚本内置功能），而其他用户默认从 GitHub 拉取代码。本地 Tiviw 仓库地址始终为 [GitHub 仓库地址](https://github.com/RimuruW/Tiviw)。
- 目前同时接受来自 GitHub 和 Gitee 的 issue，但 GitHub 的 issue 享有更快的回复速度。目前只接受 GitHub 的 pull request。


## License
项目使用 [GPL-3.0 License](https://github.com/RimuruW/Tiviw/blob/dev/LICENSE)，用户使用本项目即代表用户已阅读并同意该开源协议。
