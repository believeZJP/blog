---
title: Node-常用工具
date: 2019-01-22 14:42:21
updated: 2019-01-22 14:42:21
tags:
- node
- 进程管理
---

## supervisor 监听Node改动

[supervisor 官网](http://supervisord.org/)
是一个进程控制系统：

平时，我们 node app.js 后，当我们修改了 app.js 的内容，就需要关闭 node 命令行再执行 node app.js。
而我们使用 supervisor 后，我们修改了 app.js 中的内容，只要点击保存，即可生效保存后的代码，实现实时监听 node 代码的变动。

<!-- more -->

## 基本用法

1. 安装插件：`npm i supervisor -g`
2. 运行命令：`supervisor app.js`
3. 查看运行：`localhost:3000`

**执行命令必须在项目的根目录启动。不管服务启动文件在什么位置。**

例如：Express4.0中，启动文件位于`./bin/www`，启动时，必须在`./`下执行`supervisor bin/www`

没有任何参数启动服务，默认监控所有文件, 文件夹的变化，一旦有变化，服务就会重启。
这样会出现很多问题：将日志存入某些文件夹，或上传附件等，都会导致服务器文件的变化，必然引起node服务器的重启。

不想监控某些文件夹，可以使用-i参数。如：忽略根目录下的private, 可以这样启动：
`supervisor -i ./private myapp`
忽略多个文件夹，则用`,`隔开
`supervisor -i ./private,./otherdir myapp`

## 详细介绍

运行：`supervisor`

## PM2 - Node进程管理

[PM2- NPM](https://www.npmjs.com/package/pm2)
[官网](https://pm2.io/doc/en/runtime/quick-start/)
PM2 是 Node 进程管理工具，可以利用它来简化很多 Node 应用管理的繁琐任务，如性能监控、自动重启、负载均衡等，而且使用非常简单。
下面就对 PM2 进行入门性的介绍，基本涵盖了 PM2 的常用的功能和配置：

## 用法

1. 全局安装 `PM2：npm i pm2 -g`
2. 监听应用：`pm2 start index.js`
3. 查看所有进程：`pm2 list`
4. 查看某个进程：`pm2 describe App name/id`
5. 停止某个进程：`pm2 stop App name/id`
6. 停止所有进程：`pm2 stop all`
7. 重启某个进程：`pm2 restart App name/id`
8. 删除某个进程：`pm2 delete App name/id`
9. 查看所有的进程状态：pm2 status

supervisor 是监听单个进程的话，那么 PM2 就是监听多个进程。

## 参数说明

- `--watch`：监听应用目录源码的变化，一旦发生变化，自动重启。如果要精确监听、不见听的目录，最好通过配置文件
- `-i --instances`：启用多少个实例，可用于负载均衡。如果-i 0或者-i max，则根据当前机器核数确定实例数目，可以弥补node.js缺陷
- `--ignore-watch`：排除监听的目录/文件，可以是特定的文件名，也可以是正则。比如--ignore-watch="test node_modules "some scripts"
- -n --name：应用的名称。查看应用信息的时候可以用到
- `-o --output <path>`：标准输出日志文件的路径，有默认路径
- `-e --error <path>`：错误输出日志文件的路径，有默认路径
- `--interpreter <interpreter>`：the interpreter pm2 should use for executing app (bash, python...)。比如你用的coffee script来编写应用

## 通过yaml管理多个应用

process.yml

```yml
apps:
  - script   : app.js
    instances: 4
    exec_mode: cluster
  - script : worker.js
    watch  : true
    env    :
      NODE_ENV: development
    env_production:
      NODE_ENV: production
```

启动: `pm2 start process.yml`

## 环境切换

开发中会有多个环境(开发，测试，生产等), 根据不同环境切换各种情景

pm2通过在配置文件中的`env_xx`来声明不同环境的配置，然后在启动时通过`--env`参数指定运行环境

环境变量如下定义

```json
"env": {
    "NODE_ENV": "production",
    "REMOTE_ADDR": "http://www.example.com/"
},
"env_dev": {
    "NODE_ENV": "development",
    "REMOTE_ADDR": "http://wdev.example.com/"
},
"env_test": {
    "NODE_ENV": "test",
    "REMOTE_ADDR": "http://wtest.example.com/"
}
```

在应用中通过process.env.REMOTE_ADDR等来读取配置中声明的变量

启动指定的环境：`pm2 start app.js --env development`

## 负载均衡

```bash
pm2 start app.js -i 3 # 开启三个进程
pm2 start app.js -i max # 根据机器CPU核数，开启对应数目的进程
```

## 开机自动启动

1. 通过pm2 save保存当前进程状态。
2. 通过pm2 startup [platform]生成开机自启动的命令。例如：pm2 startup centeros
3. 将步骤2生成的命令，粘贴到控制台进行，搞定。

## 详细介绍pm2

```bash
pm2 -h # help
pm2 # 语法介绍
```
