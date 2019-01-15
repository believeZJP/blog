---
title: centos安装git
date: 2019-01-15 20:13:56
updated: 2019-01-15 20:13:56
tags:
- centos
- git
---
# centos安装git

## 安装
yum install -y git
## 检查版本
git --version

## 生成公钥并复制到服务器上

### 生成公钥
ssh-keygen -t rsa

### 查看公钥
cat .ssh/id_rsa.pub

### 复制id_rsa.pub里的公钥到服务器上的authorized_keys文件

拷贝出来，复制到github.com的settings的SSH and GPG keys中

# 安装nodejs
yum install -y nodejs//行不通，版本太旧了

参考：http://wiki.jikexueyuan.com/project/nodejs-guide/install.html

## 卸载
yum remove nodejs -y

# 正确方法
1.确保系统下 g++ 版本在 4.6 以上，python 版本在 2.6 以上。

2.从 nodejs.org 下载 tar.gz 后缀的 NodeJS 最新版源代码包并解压到某个位置。

wget https://nodejs.org/dist/v4.5.0/node-v4.5.0.tar.gz

3.进入解压到的目录，使用以下命令编译和安装。
```bash
tar -zvxf node-v4.5.0.tar.gz
./configure
make
sudo make install
```