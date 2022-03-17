---
title: 反编译APP
date: 2021-01-07 14:42:28
updated: 2021-01-07 14:42:28
tags:
---


## Apktool

官网简介

使用apktool解压apk文件, 前置条件是, 电脑上要有安装有jdk jdk1.8 下载地址

下载apktool [官网下载地址](https://ibotpeaches.github.io/Apktool/install/)

将脚本保存到本地, 文件命名为 apktool.sh
下载jar文件, 修改文件名为 apktool.jar
将两个文件报错到同一文件夹下, 如我的是在document下新建apktool文件夹

给两个文件权限, 在命令行中输入

```bash
cd /user/mymac/document/apktool
chmod +x apktool.jar
chmod +x apktool.sh
```

开始解压

## 先cd到apktool文件夹下

```bash
sh apktool.sh apktool d xx.apk   # 把xx.apk换成你的apk名称, 回车即可
```

## SVGA格式支持

[体验预览SVGA](https://www.nangonghan.com/svga/)

[播放器](https://github.com/svga/SVGAPlayer-Web)
