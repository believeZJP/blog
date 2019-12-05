---
title: VSCode
date: 2019-12-03 15:57:18
updated: 2019-12-03 15:57:18
tags:
---

[插件列表](https://github.com/varHarrie/Dawn-Blossoms/issues/10)

## 主命令框

`Command+Shift+P`: 打开命令面板。在打开的输入框内，可以输入任何命令，例如：

按一下`Backspace`会进入到`Command+P`模式

在`Command+P`下输入>可以进入`Command+Shift+P`模式

在`Command+P`窗口下还可以:

  ○ 文件名 跳转到对应文件
  ○ `?` 列出当前可执行的动作
  ○ `!` 显示 Errors或 Warnings，也可以`Command+Shift+M`
  ○ `:` 跳转到行数，也可以`Command+G`直接进入
  ○ `@` 跳转到 symbol（搜索变量或者函数），也可以`Command+Shift+O`直接进入
  ○ `@` 根据分类跳转 symbol，查找属性或函数，也可以`Command+Shift+O`后输入:进入
  ○ `#` 根据名字查找 symbol，也可以 Command+T

## 2.2、常用快捷键

### 2.2.1、编辑器与终端窗口管理

同时打开多个Vscode（查看多个项目）

`Command+Shift+N` 打开一个新窗口
`Command+Shift+W` 关闭窗口 同时打开多个编辑器（查看多个文件）
`Command+N` 新建文件
`Ctrl+Tab` 文件之间切换
`Command+\` 分割出一个新的编辑器
`Command+1`、`Command+2`、`Command+3`左中右 3 个编辑器的快捷键
Editor之间的互相切换： `Shift + Command + [(])`

### 2.2.2、工作区的快捷键

工作区的显示和隐藏： `Command + B`
工作区和编辑区的切换： `Command + shift + E`
工作区文件资源管理器的文件选择：H/J/K/L代表文件夹折叠(如果不是一个文件夹，将会跳到这个文件所属的文件夹上，以便可以后面折叠整个文件夹)、聚焦下一个文件、聚焦上一个文件、文件夹展开(如果不是一个文件夹，将会在编辑区打开这个文件)
打开文件之后需要固定在开启状态下：`Command + K + Enter`
打开调试面板：`Command + Shift + D`

### 2.2.3、终端区的快捷键

`Ctrl + ``打开终端

主题：
winter is coming
Dracula 主题
espresso 主题    这个是左侧黑色，编辑区白色的~~
monokai light
sunrise
woolen
theme-bluloco-dark
theme-bluloco-light
github   非常给力

快捷键：

ctrl + p 快速打开一个文件
ctrl + G 跳转到指定行
ctrl + F 在当前文件中搜索
ctrl + shift + k 删除当前行

home 跳转到行的开始
end 跳转到行的结尾

ctrl + home 跳转到文件的开始
ctrl + end 跳转到文件的结尾

ctrl + shift + [  折叠一个代码块
ctrl + shift + ]  展开一个代码块

f3/shift + f3  发现下一处/发现上一处
ctrl + D 可以批量选中同一个元素，然后进行变量或方法名的重命名
ctrl + shift + o 在当前文件查找一个方法
 alt + shift + f 格式化代码
 F12 跳转到定义处
 ctrl + i  选中当前行

另外，通过路径
        File -> Preferences -> Keyboard Shortcuts中的链接，可以打开keybindings.json文件，定义自己的快捷键
     例如：定义把所有字符转化为大写/小写，修改文件keybindings.json文件。然后，通过 ctrl+shift+u 快捷键就可以把一个变量修改为大写。通过ctrl+shift+l把大写的变量变成小写。
8405da39ed76ac45f91c7ac4261fa687eb7566a2

Settings Sync   同步插件
插件：
ESLint   //js文件规范化
HTML CSS Support   //html,css
html css snippets  html,css 提示，自动补全

Vetur  //vue文件支持
vscode-icons 文件前显示图标
mithril emmet  // zen coding
Path Autocomplete
PHP IntelliSense

waka Time //统计写代码时间
 自动闭合标签
Auto Close Tag
颜色变值的实际颜色
Color Highlight
括号高亮
Bracket Pair Colorizer，，

markdown preview enhanced 预览markdown非常好
Prettier - Code formatter 自动格式化代码 ，可以自动格式化
"editor.formatOnSave": true

VS Code 终端字体间距过宽
解决办法：
终端用VSCode的默认字体，编辑器可以用自定义的字体
终端使用的字体不能是等宽字体，否则会出现这样的问题

vscode自动给所有的import改为实际路径而不是相对路径，解决办法
自动更新 import 语句的路径

默认用户设置
// 启用或禁用在 VS Code 中重命名或移动文件时自动更新 import 语句的路径。可选值有: "prompt" (在每次重命名时提示)、"always" (始终自动更新路径) 和 "never" (从不重命名路径且不要提示)。要求工作区使用高于 2.9 版本的 TypeScript。
"typescript.updateImportsOnFileMove.enabled": "prompt"

如果把这个值改成always
，就会自动修改所有的import

- VS Code setting Sync插件配置经验：
 按照教程提示按shift+alt+u 会弹出输入框要求输入github中的token，第一次可以输入
 如果输入错误，再次按快捷键会不断提示token过期或错误。
 
 解决办法: 找到settings.json文件同目录下的syncLocalSettings.json
 查找办法，鼠标放到setting.json的打开标签上会显示文件目录，右键可打开所在目录。
 C:\Users\zhaojianpeng3\AppData\Roaming\Code\User
 
 修改文件中的token为github中对应的token，保存文件。重新按快捷键即可启用。
