---
title: Git 经验积累
date: 2018-12-03 14:58:57
updated: 2018-12-03 14:58:57
tags:
- Git
- SmartGit
- GitKraken
---

## 客户端推荐

- [SmartGit](https://www.syntevo.com/smartgit/)✨✨✨(开始用的，后来放弃)
- [Sourcetree](https://www.sourcetreeapp.com/)✨✨✨✨✨(现在用的这个，需要翻墙注册)
- [GitKraken](https://www.gitkraken.com/) 没用过，全平台免费

## github contributions 展示问题

正常情况下会将每天的提交记录展示到图表中。
有天突然发现之前好多提交记录没展示，查看原因发现是提交账号和github的账号不一致的原因导致的。

GitHub默认只有账号绑定的邮箱提交的commits才会展示.

解决办法:

- 将公司邮箱加到GitHub账户下--[链接](https://github.com/settings/emails)

- 将当前项目的提交设置为个人邮箱

    ```bash
    git config user.email "email@example.com"
    ```

    用smartGit客户端，选择目录-->右键-->setting-->修改用户名，邮箱

## centos安装git

## 安装

yum install -y git

## 检查版本

git --version

## 生成公钥并复制到服务器上

### 生成公钥

ssh-keygen -t rsa

### 查看公钥

cat ~/.ssh/id_rsa.pub

mac中直接复制到剪贴板

pbcopy < ~/.ssh/id_rsa.pub

### 复制id_rsa.pub里的公钥到服务器上的authorized_keys文件

拷贝，复制到github.com的settings的SSH and GPG keys中

## 安装nodejs

yum install -y nodejs //行不通，版本太旧了

参考：<http://wiki.jikexueyuan.com/project/nodejs-guide/install.html>

## 卸载

yum remove nodejs -y

## 正确方法

1.确保系统下 g++ 版本在 4.6 以上，python 版本在 2.6 以上。

2.从 nodejs.org 下载 tar.gz 后缀的 NodeJS 最新版源代码包并解压到某个位置。

`wget https://nodejs.org/dist/v4.5.0/node-v4.5.0.tar.gz`

3.进入解压到的目录，使用以下命令编译和安装。

```bash
tar -zvxf node-v4.5.0.tar.gz
./configure
make
sudo make install
```

## git提交commit后，想撤回重新commit

`git reset --soft HEAD^`

这样就成功的撤销了你的commit
注意，仅仅是撤回commit操作，您写的代码仍然保留。

`--hard`
会删除本地修改代码，回到上次commit状态
