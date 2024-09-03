---
title: iTerm2完美的终端体验
date: 2018-11-26 18:31:37
updated: 2018-11-26 18:31:37
tags:
  - 终端
  - iTerm2
---

[TOC]

mac 自带的终端实在是差劲，改用 iTerm2 可以 6 到飞起~~~

## 安装

[直接下载](https://www.iterm2.com/)安装即可。

## 安装[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

安装方法由于会经常更新，请点击链接跳转查看安装办法

<!--- more --->

## 配置主题

修改 ZSH_THEME="主题名"

打开配置文件

```bash
vi ~/.zshrc
```

找到如下配置
ZSH_THEME="robbyrussell"
修改为
ZSH_THEME="ys"

可以根据自己喜好选择不同的主题

[主题配置库](https://github.com/robbyrussell/oh-my-zsh/wiki/External-themes)

## 代码高亮([zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md))

安装方法详见链接

## 自动提示命令([zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions))

安装方法详见链接

## 自动切换目录([autojump](https://github.com/wting/autojump))

```bash
brew install autojump
```

根据提示将以下内容添加到~/.zshrc

```bash
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
```

刚开始装了不会有效果，需多进几个目录，就可以看到效果

### 快捷键 j

按 tab 可以选择下拉里提示的内容

权重值越高，优先级越高
要调整某个目录的优先级，需要先进入到文件目录下，进行调整

### 常用命令

```bash
# 显示数据库中的统计数据, (前面的数字是权重值)
j -s

# 增加某个目录的权重
j -i 10

# 降低某个目录权重
j -d 10

# 清除无用数据
j --purge
```

### 使用中发现的问题

如果两个目录后面的文件夹名相同，例如`/home/abc/de`和`/home/de`，权重级别不一样，
直接用`j de`不会每次都跳转到权重高的目录，如果不是想要的可以再次执行`j de`即可

## homebrew 更新

```bash
brew update
```

在安装一些软件时，会遇到 updating homebrew 卡住的问题，这时 control+c 断开，执行 brew update.

会成功更新。

网上还有说法是更换 brew 镜像源---没试过。

## 启动问候语设置

```bash
cd /etc
sudo pico motd
输入密码后输入问候语

按control+x退出，按y确认， 按回车确认，
用 y保存退出，再 y一次确认文件名motd
```

打开新标签页，即可看到提示语

## 安装 iTerm2 后替换为系统自带的 bash

打开 iTerm2->prefrences->profiles-command
选择 command 输入`/bin/bash`即可

```bash
# 修改iterm 默认程序
chsh -s /bin/zsh

# 恢复原来的bash
chsh -s /bin/bash
```

## 常用快捷键

```bash
# 打开新标签
command+t

# 关闭标签
command+w

# 同一个Tab内的分屏切换
Command + [

# Tab之间的切换
Command + 数字


# 垂直切分窗口
command+d

# 水平切分窗口
command+shift+d

# 复制窗口
左上角shell->duplicate Tab 以当前路径下打开新的窗口

# 进入与返回全屏模式
command+enter

# 保存当前快照
Window > Save Window Arrangement.

# 恢复快照：
Window > Restore Window Arrangement

可以在Preferences > General > Open saved window arrangement.设置自动恢复快照

# 从终端进入Finder

进入某个目录
open .

# Finder 进终端
直接拖拽

# 查看历史命令
command + ;

# 查看剪贴板历史
command + shift + h

# 命令搜索
Ctrl + r

# 清除当前行命令
Ctrl + u

# 跳转到行首
Ctrl + a

# 跳转到行尾
Ctrl + e
```

## 自动补全插件 incr ---如果提示多了会卡的很严重，曾经用过，后来替换成 zsh-autosuggestions

下载此插件：

```bash
wget http://mimosa-pudica.net/src/incr-0.2.zsh

# 将此插件放到oh-my-zsh目录的插件库下：

# 在~/.zshrc文件末尾加上
source ~/.oh-my-zsh/plugins/incr/incr*.zsh
# 更新配置
source ~/.zshrc
```

## 命令参数提示

举个栗子，之前偶尔需要用到删除文件夹的操作，rm -r [path]，但是常常会忘记中间的参数是什么，现在我只需要这么做：

```bash
# 输入 rm - ， 然后按tab
rm -
-R  -r  -- remove directories and their contents recursively
-f      -- ignore nonexistent files, never prompt
-i      -- prompt before every removal
```

## git 快捷键

[插件git.plugin.zsh地址](https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh)

```bash
cd ~/.oh-my-zsh/plugins/git
less git.plugin.zsh
```

在这里可以看到常用的git命令别名

## [官方插件列表](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview)

看别人在用的插件

- fasd
- history

## 常用命令

```bash
#  查看当前所用的 Shell
echo $SHELL

# 查看系统内已安装的 Shell
cat /etc/shells
```

## iterm中git status 显示字符，不显示中文

  解决方法：在命令行执行命令

```bash
git config --global core.quotepath false
```

## rz/sz上传下载文件

1. 安装lrzsz `brew install lrzsz`

2. 下载配置iTerm2的相关脚本

    [脚本地址](https://github.com/luxihk/iterm2-zmodem)

    在/usr/local/bin目录下直接执行：

    `wget https://raw.githubusercontent.com/mmastrac/iterm2-zmodem/master/iterm2-send-zmodem.sh https://raw.githubusercontent.com/mmastrac/iterm2-zmodem/master/iterm2-recv-zmodem.sh`
    赋予可执行权限
    `chmod +x /usr/local/bin/iterm2-send-zmodem.sh /usr/local/bin/iterm2-recv-zmodem.sh`

3. 配置ITerm2

    Term2的配置项：iTerm2的Preferences-> Profiles -> Default -> Advanced -> Triggers的Edit按钮。

    然后配置项如下：

    |Regular Expression|Action|Parameters|Instant|
    |--|--|--|--|
    |rz waiting to receive.\\*\\*B0100|Run Silent Coprocess|/usr/local/bin/iterm2-send-zmodem.sh|checked|
    |\\*\\*B00000000000000|Run Silent Coprocess|/usr/local/bin/iterm2-recv-zmodem.sh|checked|

    注意最后一项需要你将Instant选项勾上，否则将不生效

4. 设置滚动屏幕阅读文件
在item2的“Preferences”->“advance”菜单中找到“Scroll wheel sends arrow keys when in alternate screen mode.”，并将该选项的“Yes”修改为“No”即可。由下图可看到，此版本，改完立即生效了，再次双指滑动触摸屏，可看到屏幕开始滚动：

## powerlevel10k 安装

Powerlevel10k 是一个功能强大且高度可定制的 Zsh 主题框架。它是 Oh My Zsh 和 Prezto 等 Zsh 配置框架的主题选择之一。Powerlevel10k 以其快速、高效和丰富的功能而闻名，适用于那些希望在命令行界面中获得最佳体验的用户。

以下是 Powerlevel10k 的一些主要特点：

性能优越: Powerlevel10k 是 Powerlevel9k 的优化版本，速度更快，性能更高。它在设计时考虑了性能问题，能够在不影响速度的情况下提供丰富的功能和信息。

高度可定制: 通过配置文件，用户可以根据个人偏好自定义主题的各个方面，包括提示符的样式、颜色、图标和信息展示的内容。

丰富的信息展示: Powerlevel10k 可以在终端提示符中显示各种有用的信息，例如 Git 状态、命令执行时间、电池状态、网络信息等，帮助用户更高效地工作。

易于安装和配置: Powerlevel10k 提供了简单的安装步骤和配置向导，使新用户能够快速上手。通过交互式向导，用户可以轻松选择和调整主题设置。

兼容性好: Powerlevel10k 与许多流行的 Zsh 插件和工具兼容，确保用户在自定义终端环境时不会遇到障碍。

安装步骤
以下是安装 Powerlevel10k 的基本步骤：

安装 Zsh:
如果你还没有安装 Zsh，可以通过包管理器进行安装。例如，在 Debian/Ubuntu 系统上，可以使用以下命令：

sudo apt install zsh
安装 Oh My Zsh:
你可以通过以下命令安装 Oh My Zsh：

`sh -c "$(curl -fsSL <https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh>)"`
安装 Powerlevel10k:
使用以下命令来安装 Powerlevel10k：

`git clone --depth=1 <https://github.com/romkatv/powerlevel10k.git> ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k`
配置 Zsh 使用 Powerlevel10k:
编辑你的 .zshrc 文件，将主题设置为 Powerlevel10k：

`ZSH_THEME="powerlevel10k/powerlevel10k"`
保存并关闭文件，然后重新加载 Zsh 配置：

`source ~/.zshrc`
启动配置向导:
在终端中输入以下命令启动 Powerlevel10k 配置向导：

`p10k configure`
按照向导提示进行设置，选择你喜欢的样式和配置。

总结
Powerlevel10k 是一个强大且灵活的 Zsh 主题，它能够显著提升终端的用户体验。如果你经常使用命令行工具，Powerlevel10k 绝对是一个值得尝试的主题。通过其性能优化和高度可定制的特性，你可以打造一个专属于你的高效工作环境。
