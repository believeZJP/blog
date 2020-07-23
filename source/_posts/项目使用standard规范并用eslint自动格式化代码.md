---
title: 项目使用standard规范并用eslint自动格式化代码
date: 2020-07-24 00:06:49
updated: 2020-07-24 00:06:49
tags:
---

在vscode插件中安装`standard`插件

先禁用，再在工作区启用，即可只在当前工作区生效

在项目中安装`standard`和`eslint`
`npm i eslint standard -D`

在命令行执行`eslint --init`初始化生成`.eslintrc.js`文件

生成过程中根据自己需求选择即可

在vsCode配置中(setting.json)增加如下配置, 即可自动格式化

```json
"standard.run": "onSave",
"standard.autoFixOnSave": true,
"javascript.validate.enable": false
```
