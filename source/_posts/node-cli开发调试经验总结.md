---
title: node cli开发调试经验总结
date: 2020-07-07 09:02:45
updated: 2020-07-07 09:02:45
tags:
---

## node命令行工具开发调试

npm link命令通过链接目录和可执行文件，实现npm包命令的全局可执行。

简要地讲，这个命令主要做了两件事：

1. 为npm包目录创建软链接，将其链到{prefix}/lib/node_modules/package(包名)
2. 为可执行文件(bin)创建软链接，将其链到{prefix}/bin/{name}

<!-- more -->

在`package.json`中配置

```json
"bin": {
    "ltsnode": "bin/ltsnode.js"
}
```

在ltsnode.js中

```js
#!/usr/bin/env node

// 指定运行环境为node

console.log('运行ltsnode命令')
```

## 在VsCode里debug模式里调试

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "node",
            "request": "launch",
            "name": "启动程序",
            "skipFiles": [
                "<node_internals>/**"
            ],
            // 这里是命令行需要传入的参数
            "args": [
                "10"
            ],
            // 这里是命令行入口文件的位置，一般放在bin文件夹下
            "program": "${workspaceFolder}/bin/ltsnode.js"
        }
    ]
}
```

配置完成后，点击启动程序，即可开始调试。上一步下一步在VsCode正中间顶部。
可以使用`console.log`输出结果到调试控制台

## 在命令行里里调试

`npm link`

再运行`npm link`即可

然后再命令行里执行命令`ltsnode`看效果

进入`/usr/local/lib/node_modules`会发现一个软链，指向自己项目目录
`ltsnode -> /Users/zhaojianpeng/Desktop/workspaces/ltsnode`

## 开发中遇到的问题

1. 执行`npm link`报错

开发过程遇到的报错

- `ENOENT: no such file or directory, chmod '/usr/local/lib/node_modules/videocount/bin/videocount'`
    解决办法：在`package.json`中

    ```json
    "bin": {
        "videocount": "bin/videocount.js"
    },
    ```

    这里一定要加后缀名js
- `npm ERR! Refusing to delete /usr/local/bin/ltsnode: ../../../Users/zhaojianpeng/.config/yarn/link/ltsnode/bin/ltsnode symlink target is not controlled by npm /usr/local/bin`
- `npm ERR! EEXIST: file already exists, symlink '../lib/node_modules/ltsnode/bin/ltsnode.js' -> '/usr/local/bin/ltsnode'`

解决办法：
尝试了各种办法，删缓存，升级npm版本。执行`npm link`总是报错。
**执行`rm /usr/local/bin/ltsnode`删除软链**搞定~~~

在`/usr/local/bin/node_modules`里删除软链不好使

期间用到知识

一、使用淘宝镜像
1.临时使用
npm --registry <https://registry.npm.taobao.org> install express

2.持久使用
npm config set registry <https://registry.npm.taobao.org>

3.通过cnpm
npm install -g cnpm --registry=<https://registry.npm.taobao.org>

二、使用官方镜像
npm config set registry <https://registry.npmjs.org/>

三、查看npm源地址
npm config get registry

删除软链
`rm -rf ltsnode`
