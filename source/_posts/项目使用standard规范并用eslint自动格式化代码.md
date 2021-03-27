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

vscode中配置ESLint

```json
    "editor.codeActionsOnSave": {
        "source.fixAll": true,
    },
    "eslint.format.enable": true,
    // 两者会在格式化js时冲突，所以需要关闭默认js格式化程序 
    "javascript.format.enable": false
```

在`.eslint.js`中配置规则

```js
module.exports = {
  'rules': {
    // 4个空格缩进, switch需要单独配置, 否则会不生效
    'indent': ['error', 4, { 'SwitchCase': 1 }],
    'semi': ['error', 'always'],
    // 操作符在行首
    'operator-linebreak': ['error', 'before'],
    // 强制在逗号周围使用空格
    'comma-spacing': ['error', { 'before': false, 'after': true }],
    // 删除最后一个逗号
    'comma-dangle': ['error', 'never'],
    // 逗号前后的空格
    'comma-spacing': ['error', { 'before': false, 'after': true }],
    // 对象两边加空格
    'object-curly-spacing': ['error', 'always'],
    // 数组类型左右不加空格
    'array-bracket-spacing': ['error', 'never'],
    // 计算属性类型加空格，同上
    'computed-property-spacing': ['error', 'never'],
    // 操作符加空格
    'space-infix-ops': ['error', { 'int32Hint': true }],
    // 删除多余空格和空行
    'no-multi-spaces': 'error',
    // 禁止行尾空格
    'no-trailing-spaces': 'error',
    // 方法参数是单个是不加括号
    'arrow-parens': ['error', 'as-needed'],
    // console警告
    'no-console': ['error', { allow: ['warn'] }],
    // 要求使用 === 和 !== (eqeqeq)
    'eqeqeq': ['error', 'always'],
    // 函数圆括号之前有一个空格
    'space-before-function-paren': ['error', 'never'],
    // 箭头函数=>左右留空格
    'arrow-spacing': "error",
    // 大括号之前有空格
    'block-spacing': ['error', 'always'],
    // 语句块之前的空格
    'space-before-blocks': ['error', 'always'],
    // 对象字面量的键和值之间使用一致的空格
    'key-spacing': ['error', { 'afterColon': true, 'beforeColon': false }],
    // if等关键字后加空格
    'keyword-spacing': ['error', { 'after': true, 'before': true }],
    // ; 前不加空格
    'semi-spacing': ['error', {'before': false}],
    // 使用骆驼拼写法
    'camelcase': ['error', { allow: ['Component'] }],
    // 文件末尾保留一行空行
    'eol-last': ['error', 'always'],
    'no-multiple-empty-lines': ['error', { 'max': 2, 'maxEOF': 1 }],
    // 单引号
    'quotes': ['error', 'single']
}
}

```

即可自动格式化代码
