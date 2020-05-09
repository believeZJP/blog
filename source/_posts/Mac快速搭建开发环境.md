---
title: Mac快速搭建开发环境
date: 2020-05-09 00:19:11
updated: 2020-05-09 00:19:11
tags:
---
因为笔记本电池坏了，要送机维修，用了半天时间快速换电脑从0搭建得心应手的开发环境。特记录留念。

## Mac键盘设置

系统设置-> 键盘-> 调到最快

## Git 初始化

先创建目录

mkdir /Users/zjp(此处为电脑用户名)/.ssh

将原来电脑里的 known_hosts，id_rsa.pub， id_rsa放到这个目录下即可 用git命令

## Git 命令快捷方式

bdgp

在 ~/.oh-my-zsh/plugins/git的 git.plugin.zsh文件末尾添加

```
bdgp() {
 if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
 git push origin head:refs/for/"${*}"
 else
 [[ "$#" == 0 ]] && local b="$(git_current_branch)"
 git push origin head:refs/for/"${b:=$1}"
 fi
}
```

## homebrew 安装地址

因为HomeBrew官网提供的安装办法会报错，所以改用以下方法，简介好用，强烈推荐！！！
[知乎链接](https://zhuanlan.zhihu.com/p/111014448)
然后就可以正常安装插件

各个插件的安装要根据每个插件的安装指南对应安装

## iTerm2下载

因为网速原因下载最新版会特别慢
[低版本下载链接](https://www.zhinin.com/wp-content/themes/2019_v0.1/down.php?id=25574)

**经验**不用从官网下载，直接将原电脑应用程序里的文件压缩通过隔空传送发送到新电脑即可。

### 插件安装

详见[我的博客believezjp.oriht.com链接](http://believezjp.oriht.com/posts/iTerm2%E5%AE%8C%E7%BE%8E%E7%9A%84%E7%BB%88%E7%AB%AF%E4%BD%93%E9%AA%8C/)
**Oh-my-zsh的安装都要用库对应的方法安装**

## 安装常用软件

搜狗输入法（外观-简约黑2，候选9个字）

Vscode

微信开发者工具

百度开发者工具

GitKraken(只能安装6.5.1版本以下的)

PdfGuru

### vscode插件安装

直接安装Settings Sync同步即可

## Node环境安装

直接官网下安装包

## 文件备份

打开Finder里的各个目录查看文件，压缩传送新电脑即可

然后就可以下代码开始搬砖了~~
