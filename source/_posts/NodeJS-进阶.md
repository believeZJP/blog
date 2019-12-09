---
title: NodeJS 进阶
date: 2019-12-05 16:56:29
updated: 2019-12-05 16:56:29
tags:
---
[参考资料](https://github.com/nswbmw/N-blog)

## 1. 安装Node.js

官网下载直接安装

安装成功后，输入npm -v 和node -v 测试。

Linux安装

```bash
curl -O https://nodejs.org/dist/v6.9.1/node-v6.9.1.tar.gz
tar -xzvf node-v6.9.1.tar.gz
cd node-v6.9.1
./configure
make
make install
```

<!-- more -->

### 版本管理

使用[nvm](https://github.com/creationix/nvm) 或 [n](https://github.com/tj/n)

### npm 源管理工具

nrm 用来切换官方npm源和国内npm源，也可以用来切换官方npm源和公司私有npm源

全局安装 nrm :

```bash
npm i nrm -g
```

查看nrm内置的npm源地址

```bash
nrm ls
```

切换源

```bash
npm use cnpm
```

非常棒的博客：<http://blog.fens.me>
 <http://blog.fens.me/series-nodejs/>

Node  教程
<https://github.com/nswbmw/N-blog/>

Node文档地址：
<https://nodejs.org/api/fs.html#fs_event_open>
中文文档
<http://nodejs.cn/api/fs.html>
关于文件读取，写入 File System
  读取文件

<https://segmentfault.com/a/1190000004957223>

express
<http://www.expressjs.com.cn/starter/generator.html>
node+mongodb搭建博客
<https://segmentfault.com/a/1190000011794598>

Node 自学完全总结
<http://www.jianshu.com/p/22f62a08559f>

Node.js教程
七天学会NodeJS
<http://nqdeng.github.io/7-days-nodejs/#1.1>

<http://www.open-open.com/lib/view/1392611872538#_label2>

<https://github.com/alsotang/node-lessons>

> 我来对创业公司中使用 Nodejs，做一个小总结，我们在妥善处理了 运维、集群管理、性能调优等等这些传统语言已经做的非常棒非常成熟的领域，在大部分的创业公司，都可以由前端团队推动，来使用 Nodejs 去接管数据访问层与渲染层的事情，等到公司规模上来以后，就可以依靠更资深的工程师以及原来团队的沉淀，来做 比如日志、监控系统、分布式服务接入这些事情，Nodejs 的落地需要前端工程师，需要 Nodejs 工程师，更需要强大的运维之锤，了解除了 JS 以外的更多技能，比如数据库，比如系统的设计，比如接口服务，比如团队规范协作流程等等等等，在大公司可以扎根一个方向挖下去，在小公司则需要放眼天下，筹备未来。
