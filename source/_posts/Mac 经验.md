---
title: mac 经验
date: 2018-11-08 18:05:59
updated: 2018-11-08 18:05:59
tags: mac
---

[TOC]

# 窗口平铺工具
[Magnet](https://itunes.apple.com/cn/app/magnet/id441258766?mt=12&ign-mpt=uo%3D4)

在xclient.info可以下载到

# mac录屏 
自带软件即可录制
QuickTime Player
# mac 安装 tomcat

1. 按照百度经验，安装Java jdk，配置环境变量
    检查Java版本 java -version
    echo $JAVA_HOME

2. 下载tomcat，官网版
3. 修改授权
    进入tomcat的bin目录,修改授权
    ```
    ➜ bin pwd
    /Users/yp/Documents/workspace/apache-tomcat-7.0.68/bin
    ➜ bin sudo chmod 755 *.sh
    ```
1. sudo为系统超级管理员权限.
2. chmod 改变一个或多个文件的存取模式
3. 755代表用户对该文件拥有读、写、执行的权限，同组的其他人员拥有执行和读的权限，没有写的权限，其它用户的权限和同组人员一样.
4. 777代表，user,group ,others ,都有读写和可执行权限.
5. chmod -R 777 folername,获取文件夹权限.

<!---more--->

## 启动

二、启动
执行启动命令 sudo sh ./startup.sh
访问http://localhost:8080/

关闭

sudo sh ./shutdown.sh

或直接./shutdown.sh

安装 nginx

先安装 homebrew

brew install nginx

mac 下 vim 快捷键

不在编辑状态下按 dd 删除行
[链接](https://www.jianshu.com/p/6f13474d36ac)

# mac 添加任何来源允许权限

在命令行执行

```
  sudo spctl --master-disable
```
输入密码,再回到隐私里，就能看到任何来源.
# 如何卸载 paragon NTFS for mac ?

```
找到 /Library/Application Support/Paragon Software 目录

sudo ./com.paragon-software.ntfs.uninstall
```

# mac本地绑定hosts
```bash
sudo vim /etc/hosts  

添加以下内容
10.180.112.208 www.baidu.com www.jd.com
```
可以添加多个域名, 也可以一个




# mac手势快捷键

    1.三指拖动✨✨✨✨✨
        设置->辅助功能->鼠标与触控板->触控板选项->启动拖移->三指拖移
        可以在触控板在任何软件标题栏拖动该窗口
    2.docker程序坞缩放✨✨✨✨✨
        放大选中, 最大
        鼠标放到docker上可以看到该程序图标放大
    3.点按✨✨✨✨✨
        设置->触控板->轻点来点按
        单机只需轻点触控板, 不用用力按
    4.显示器排列✨✨✨✨✨
        设置->显示器->排列
        mac如果外接显示器,可以拖动显示器位置来排列位置,方便鼠标移动到另一个显示器
    5.全屏下切换窗口✨✨✨
        四指滑动


# mac安装[homebrew](https://brew.sh/index_zh-cn)
Homebrew的安装非常简单，打开终端复制、粘贴以下命令，回车，搞定(请放心使用，原汁原味的官方安装方法搬运）
`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

# 新建管理员用户怎么弄？
点击“系统偏好设置”-“用户与群组”,点解锁，输入密码，然后点击左下角的“+”新建一个管理员用户，然后回到电脑主屏幕，点击右上角菜单的当前用户，然后选择新建的用户切换进入使用。

# 触发角
在「桌面与屏幕保护程序」-「屏幕保护程序」
可以设置鼠标在每个角落的时候相应的操作。
 
可用于锁屏，显示桌面

# MAC 快捷键：
Mac中主要有四个修饰键，分别是Command，Control，Option和Shift。

Command是Mac里最重要的修饰键，在大多数情况下相当于Windows下的Ctrl。所以以下最基本操作很好理解：
Command-Z 撤销　
Command-X 剪切　　
Command-C 拷贝（Copy）　　
Command-V 粘贴　　
Command-A 全选（All）　　
Command-S 保存（Save)　　
Command-F 查找（Find）

截图：
Command-Shift-4 截取所选屏幕区域到一个文件　　
Command-Shift-3 截取全部屏幕到文件　　
Command-Shift-Control-3 截取全部屏幕到剪贴板　　
Command-Shift-4 截取所选屏幕区域到一个文件，或按空格键仅捕捉一个窗口　　
Command-Shift-Control-4 截取所选屏幕区域到剪贴板，或按空格键仅捕捉一个窗
现在直接用微信的快捷键了

在应用程序中：
Command-Option-esc 打开强制退出窗口　　
Command-H 隐藏（Hide）当前正在运行的应用程序窗口　　
Command-Option-H 隐藏（Hide）其他应用程序窗口　　
Command-Q 退出（Quit）最前面的应用程序　　
Command-Shift-Z 重做，也就是撤销的逆向操作　　
Command-Tab 在打开的应用程序列表中转到下一个最近使用的应用程序，相当于Windows中（Alt+Tab）　　
Command-Option-esc 打开“强制退出”窗口，如果有应用程序无响应，可在窗口列表中选择强制退出

文本处理：
Command-右箭头 将光标移至当前行的行尾　　
Command-B 切换所选文字粗体（Bold）显示　　
fn-Delete 相当于PC全尺寸键盘上的Delete，也就是向后删除　　
fn-上箭头 向上滚动一页（Page Up）　　
fn-下箭头 向下滚动一页（Page Down）　　
fn-左箭头 滚动至文稿开头（Home）　　
fn-右箭头 滚动至文稿末尾（End）　　
Command-右箭头 将光标移至当前行的行尾　　
Command-左箭头 将光标移至当前行的行首　　
Command-下箭头 将光标移至文稿末尾　　
Command-上箭头 将光标移至文稿开头　　
Option-右箭头 将光标移至下一个单词的末尾　　
Option-左箭头 将光标移至上一个单词的开头　　
Control-A 移至行或段落的开头

在Finder中：
Command-Option-V 剪切文件　　
Command-Shift-N 新建文件夹（New）　　
Command-Shift-G 调出窗口，可输入绝对路径直达文件夹（Go）　　
return 这个其实不算快捷键，点击文件，按下可重命名文件　　
Command-O 打开所选项。在Mac里打开文件不像Windows里直接按Enter　　
Command-Option-V 作用相当于Windows里的文件剪切。在其它位置上对文件复制（Command-C），在目的位置按下这个快捷键，文件将被剪切到此位置　　
Command-上箭头 打开包含当前文件夹的文件夹，相当于Windows里的“向上”　　
Command-Delete 将文件移至废纸篓　　
Command-Shift-Delete 清倒废纸篓　　
空格键 快速查看选中的文件，也就是预览功能

在浏览器中：
Control-Tab 转向下一个标签页　　
Command-L 光标直接跳至地址栏　　
Control-Tab 转向下一个标签页　　
Control-Shift-Tab 转向上一个标签页　　
Command-加号或等号 放大页面　　
Command-减号 缩小页面

切换同个软件的不同窗口  command+`

# 锁屏
`ctrl+command+q`
# 触摸板
触摸板可以设置成触摸板轻敲替代按下的…

# 如何重置 Mac 上的 NVRAM
https://support.apple.com/zh-cn/HT204063
# 重置 Mac 上的系统管理控制器 (SMC)
https://support.apple.com/zh-cn/HT201295

# UI 切图工具
- [sketch](http://www.sketchcn.com/)
绘图工具
[下载破解版](https://www.zhinin.com/sketch-mac.html)

- [PxCook](http://www.fancynode.com.cn/pxcook)
生成前端代码利器

- [Flavor](http://www.fancynode.com.cn/flavor)
sketch导出为PxCook插件Flavor

# Xmind安装

[下载地址](http://www.carrotchou.blog/6539.html)
下载主程序和破解补丁。 先安装主程序，按照破解补丁里的步骤安装即可。

# mac关闭指定端口
```bash
sudo lsof -i:8090
udo kill -9 [pid]
# eg
udo kill -9 59296
```

# Windows虚拟机
http://soft.macx.cn/6205.htm
# TODO
解锁Alfred, Workflow

# iPhone 8强制重启
先按音量+，再按音量-，再长按电源键10s左右会显示开机画面。

# homebrew 软件下载安装利器
[下载安装]https://brew.sh/index_zh-cn)
[所有软件列表](https://formulae.brew.sh/formula/)
安装
```bash
brew install wget
```
# mac常用软件下载地址
[mac-torrent-download](https://mac-torrent-download.net/)

[xclient.info](https://xclient.info/)👍👍👍👍👍


# 参考链接
- [程序员如何优雅地使用 macOS？](https://www.zhihu.com/question/20873070)