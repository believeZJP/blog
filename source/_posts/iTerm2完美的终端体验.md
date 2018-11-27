---
title: iTerm2完美的终端体验
date: 2018-11-26 18:31:37
updated: 2018-11-26 18:31:37
tags:
- 终端
- iTerm2
---

mac自带的终端实在是差劲，改用iTerm2可以6到飞起

# 安装

[官网下载](https://www.iterm2.com/)
直接下载安装即可。
# 安装oh-my-zsh

[github地址](https://github.com/robbyrussell/oh-my-zsh)
via curl
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

```
via wget
```bash
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

```

# 配置主题
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

# 代码高亮([zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md))
```bash
# 1 安装
brew install zsh-syntax-highlighting
# 2 用 vim 打开 .zshrc 文件，找到插件设置命令(快捷键 /plugins=)，默认是 plugins=(git) 
plugins=(zsh-syntax-highlighting git)
```

# 自动提示命令([zsh-autosuggestions]())
先进到oh-my-zsh的plugins目录

```bash
cd .oh-my-zsh/plugins

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 在配置文件中添加plugins
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# 执行文件
source ~/.zshrc
```

# autojump
```
brew install autojump
```
根据提示将以下内容添加到~/.zshrc
```bash
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
```

刚开始装了不会有效果，需多进几个目录，就可以看到效果

快捷键 j

按tab可以选择下拉里提示的内容

常用命令
```
要跟踪所有这些改变，输入：
autojump -s


显示数据库中的统计数据
autojump --purge
```

# homebrew更新
```
brew update
```
在安装一些软件时，会遇到updating homebrew卡住的问题，这时control+c断开，执行brew update.

会成功更新。

网上还有说法是更换brew镜像源---没试过。

# 启动问候语设置
```bash
cd /etc
sudo pico motd
control+x
设置问候语
按control+x退出，按y确认， 按回车确认，
用 y保存退出，再 y一次确认文件名motd
```
打开新标签页，即可看到提示语


# 安装iTerm2 后替换为系统自带的bash
打开iTerm2->prefrences->profiles-command
选择command输入`/bin/bash`即可

```bash
# 修改iterm 默认程序
chsh -s /bin/zsh

# 恢复原来的bash
chsh -s /bin/bash
```

# 常用快捷键
```bash
# 打开新标签
command+t

# 关闭标签
command+w

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
进入某个目录
open .

# Finder 进终端
直接拖拽

# 查看历史命令
command + ;

# 查看剪贴板历史
command + shift + h
```

# 自动补全插件incr ---如果提示多了会卡的很严重，曾经用过，后来替换成zsh-autosuggestions

下载此插件：
```bash
wget http://mimosa-pudica.net/src/incr-0.2.zsh   

# 将此插件放到oh-my-zsh目录的插件库下：

# 在~/.zshrc文件末尾加上
source ~/.oh-my-zsh/plugins/incr/incr*.zsh
# 更新配置
source ~/.zshrc   
```

# 命令参数提示
举个栗子，之前偶尔需要用到删除文件夹的操作，rm -r [path]，但是常常会忘记中间的参数是什么，现在我只需要这么做：
```bash
# 输入 rm - ， 然后按tab
rm -
-R  -r  -- remove directories and their contents recursively
-f      -- ignore nonexistent files, never prompt
-i      -- prompt before every removal
```

# [官方插件列表](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview)
看别人在用的插件
- fasd
- history

# 常用命令
```bash
#  查看当前所用的 Shell
echo $SHELL

# 查看系统内已安装的 Shell
cat /etc/shells
```

