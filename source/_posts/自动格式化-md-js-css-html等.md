---

title: '自动格式化-md,js,css,html等'
date: 2019-11-22 16:15:07
updated: 2019-11-22 16:15:07
tags:
---

## 自动格式化md文档

[文档链接](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

用VSCode编辑器安装`markdownlint`扩展

保存时自动格式化需要在settings.json中配置
> 打开setting.json方法
> 按command+p,输入settings.json

```json
"editor.codeActionsOnSave": {
    "source.fixAll.markdownlint": true
}
```

即可生效

## js文件自动格式化

尝试了用`Prettier`, 发现配置项没有直接用`ESLint`多，改用`ESLint`

### ESLint趟坑

- [官方文档](https://eslint.org/)
- [中文文档](https://cn.eslint.org/)

>习惯用VSCode扩展的用户，默认会先在扩展市场直接搜索插件，然后再settings.json中修改配置项来使插件生效。
这样的思维惯性导致了ESLint插件的初始化工作直接被忽略掉，一直不生效。

1. 首先需要要按照ESLint的文档来初始化

    [对应文档指南](https://cn.eslint.org/docs/user-guide/getting-started)

    先决条件：Node.js (>=6.14), npm version 3+。

    你可以使用 npm 安装 ESLint：

    在项目根目录运行

    `npm install eslint --save-dev`

    紧接着你应该设置一个配置文件：

    `./node_modules/.bin/eslint --init`

    这个命令执行完后会自动生成`eslintrc.js`文件

    之后，你可以在任何文件或目录上运行ESLint如下：

    `./node_modules/.bin/eslint yourfile.js`

    以上初始化工作就完成了。

2. 接下来开始自动格式化的各种配置

    在VSCode中如下配置([配置说明](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint))

    ```json
    "eslint.autoFixOnSave": true,
    "eslint.alwaysShowStatus": true,
    "eslint.run": "onSave",
    ```

3. 设置自己的代码风格

[规则列表](https://cn.eslint.org/docs/rules/)

因为公司有自己的代码格式校验，所以这里的配置是和公司代码风格一致的，不同的配置可以按照规则自己配置

```js
/**
 * @file: file
 * @author: believeZJP
 */
module.exports = {
    'env': {
        'browser': true,
        'commonjs': true,
        'es6': true
    },
    'extends': 'eslint:recommended',
    'globals': {
        'Component': 'readonly',
        'swan': 'readonly',
        'Page': 'readonly',
        'getApp': 'readonly',
        'Atomics': 'readonly',
        'SharedArrayBuffer': 'readonly'
    },
    'parserOptions': {
        'ecmaVersion': 2018,
        'sourceType': 'module'
    },
    'rules': {
        'semi': ['error', 'always'],
        // 操作符在行首
        'operator-linebreak': ['error', 'before'],
        // 删除最后一个逗号
        'comma-dangle': ['error', 'never'],
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
        // 大括号之前有空格
        'block-spacing': ['error', 'always'],
        // 语句块之前的空格
        'space-before-blocks': ['error', 'always'],
        // 对象字面量的键和值之间使用一致的空格
        'key-spacing': ['error', { 'afterColon': true, 'beforeColon': false }],
        // 使用骆驼拼写法
        'camelcase': ['error', { allow: ['Component'] }],
        // 文件末尾保留一行空行
        'eol-last': ['error', 'always'],
        'no-multiple-empty-lines': ['error', { 'max': 2, 'maxEOF': 1 }],
        // 单引号
        'quotes': ['error', 'single']
    }
};

```

说明:
globals: 是为了忽略一些全局变量没有定义的报错
rules: 是对应的详细规则，有些规则查不到的可以先查询报错信息再找对应的配置会容易点，官网的规则解释不是很清楚

如上配置，即可自动格式化大部分代码错误

但语法错误什么的需要手动解决

看到有的人用[husky](https://github.com/typicode/husky#readme)+[lint-staged](https://github.com/okonet/lint-staged#readme)

但这个是在提交代码之前校验，因为这里已经在onSave时格式化了，所以没必要加这步.(当然，加了可以强制校验提交的代码)

新项目可以尝试，旧项目因为历史遗留代码就没必要了。

## 自动加文件头部注释

公司要求js文件必须加文件头，所以这里用插件解决

插件名: [koro1FileHeader](https://github.com/OBKoro1/koro1FileHeader)

在VSCode扩展市场搜索直接安装

配置

```json
"fileheader.customMade": {
        "file": "file",
        "author": "believeZJP",
    },
    "fileheader.configObj": {
        "autoAdd": true, // 默认开启
        "language": {
        "js": {
            "head": "/**",
            "middle": " * @",
            "end": " */"
        },
    }
```

配置自定义时发现对全局修改不生效，必须指定语言进行修改，如上的`js`。

需要注意的是，每次修改settings.json后要重启VSCode
