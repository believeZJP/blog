---
title: Express学习积累
date: 2019-12-05 16:54:36
updated: 2019-12-05 16:54:36
tags:
---
## express [官网](http://www.expressjs.com.cn/)

## [pexpress 应用生成器](http://www.expressjs.com.cn/starter/generator.html)

想用node来做一个后台服务时，看到了express，可以直接生成一个简单的应用骨架。在此记录一下学习过程。

## 1. 安装

```bash
npm install express-generator -g
```

express -h 查看可用的命令行选项

```bash
express -h

  Usage: express [options] [dir]

  Options:

    -h, --help          output usage information
    -V, --version       output the version number
    -e, --ejs           add ejs engine support (defaults to jade)
        --hbs           add handlebars engine support
    -H, --hogan         add hogan.js engine support
    -c, --css <engine>  add stylesheet <engine> support (less|stylus|compass|sass) (defaults to plain css)
        --git           add .gitignore
    -f, --force         force on non-empty directory
```

## 2. 创建应用

```bash
express node-server
```

会自动创建好多文件
各文件含义

```bash
├── app.js
├── bin
│   └── www // 启动服务，并监听端口
├── package.json // 包管理文件
├── public //直接访问端口会访问到的文件
│   ├── images
│   ├── javascripts
│   └── stylesheets
│       └── style.css
├── routes // 路由设置，设置不同请求路径不同响应，user.js就是自定义的
│   ├── index.js
│   └── users.js
└── views   //渲染视图
    ├── error.jade
    ├── index.jade
    └── layout.jade
```

## 3. 安装依赖

先进入项目路径

```bash
cd node-server
```

安装所有依赖包

```bash
npm install
```

## 启动应用

```bash
DEBUG=node-server npm start

```

官网提示windows需要用下面的命令，实际测试，用上面的就可以。

```bash
set DEBUG=node-server & npm start
```

## 在浏览器中打开 <http://localhost:3000/> 网址就可以看到这个应用了

### express 热部署，修改不需要重新启动

安装node-dev

```bash
npm install -g node-dev
```

修改package.json的scripts，增加dev命令

```bash
"scripts": {
    "start": "node ./bin/www",
    "dev": "node-dev ./bin/www"
},
```

#### 现在启动服务用 npm run dev 即可

修改代码会发现已经更改。

### express 设置get和post用同一个方法

之前是 router.get('/') 或 router.post('/'), 直接用router.all('/')即可

node读写文件api

```js
readFile()

writeFile()

readFileAsync()

writeFileAsync()

createReadStream()

createWriteStream()

writestream的区别和例子没看到
```

## vscode 调试node搞不定啊，~~~~~~~~~

## 用express生成token 供权限校验
