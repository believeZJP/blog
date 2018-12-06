---
title: Redis实战读书笔记
date: 2018-12-06 11:32:08
updated: 2018-12-06 11:32:08
tags:
- redis
- 数据库
- 读书笔记
---

# 相关文档
- [redis官网](https://redis.io/)
- [redis中文下载安装](http://www.redis.cn/download.html)
- [redis中文文档](http://www.redis.cn/documentation.html)


当你需要以接近实时的速度访问快速变动的数据流时，Redis这样的键值数据库就是你的最佳选择。


# 安装

下载、解压、编译Redis
```bash
wget http://download.redis.io/releases/redis-5.0.2.tar.gz
tar xzf redis-5.0.2.tar.gz
cd redis-5.0.2
make
```

提示错误

```bash
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
```

解决, 输入以下命令:

```bash
xcode-select --install
```

回车后，系统弹出下载xcode，点击确认，下载完成后即可。（实际上不是下载xcode，可能下载xcode有关插件，下载时长约1分钟）

> 在这里发生个有趣的现象，直接拷贝到终端里执行会报错无法识别参数，手动敲了一遍可以执行😶😳😳


# 启动

在redis安装目录下，进入src，执行`./redis-server`可以看到启动画面

另开一个终端，在同样目录下，执行`./redis-cli`, 连接成功。



# 客户端常用命令
| 命令           | 版本             | 
|---------------|------------------| 
|set key value  |设置 key 的值      |
|get key	    |获取 key 的值      |
|exists key	    |查看此 key 是否存在 |
|keys *	        |查看所有的 key     |
|flushall       |消除所有的 key     |

Redis与其他软件的相同与不同

Redis是一个远程内存数据库，具有复制特性及未解决问题而升高的独一无二的数据模型。

Redis提供了5种不同类型的数据结构，各种问题都可映射到这些数据结构。

# redis简介
Redis 是一个速度非常快的非关系数据库(non-relational database), 可以存储键(key)与5种不同类型的值之间的映射(mapping), 可以将存储在内存的键值对数据持久化到硬盘，还可以通过复制，持久化和客户端分片等特性，可以将redis扩展成一个能够包含数百GB数据、每秒处理上百万请求的系统。
