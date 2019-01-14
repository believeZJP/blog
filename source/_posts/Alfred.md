---
title: Alfred
tags:
- Alfred
- 效率
---

[TOC]
# Alfred是什么
1. 可以当做app快速启动(关闭)工具来使用
2. 自定义搜索
3. workflow

# 安装

[下载](https://www.jianshu.com/p/72fe06566fce)

# 快捷键

唤起  `option+空格`
设置  `command+,`

<!-- more -->

# 配置百度搜索

在配置页找到`Web Search` 点击右下角`Edit custom Search`. 在弹出框里配置

```
Search URL: https://www.baidu.com/s?wd={query}
Title: 百度(随便写)
keyWord: b
```
点save

唤醒后再输入框输入`b (任意字符)` 会自动打开百度搜索

完成上述步骤后， 再点击"Features"->Default Results->"Setup fallback results"->点击弹出的窗口右下角"+"号->选择Custom Rearch 下的百度(上一步设置的Title)，操作步骤如下图。


![添加自定义search](/posts/Alfred/addbaidu.png)
![设置百度内容](/posts/Alfred/addbaidu-input.png)
![修改默认搜索](/posts/Alfred/setdefault.png)
![修改默认搜索](/posts/Alfred/first-baidu.png)

# 配置自定义终端
终端使用iTerm2, 可以如下设置
在设置页面，左下角`Terminal/Shell`, 选择Custom

根据iTerm2的版本, [打开自定义脚本配置](https://github.com/stuartcryan/custom-iterm-applescripts-for-alfred)
复制到输入框,即可。

唤醒后， 输入`> [shell命令]`即可自动打开iTerm2，执行[shell命令]

eg: `> cd /`

# 使用示例

## 百度搜索
`option+空格` 唤醒, 随便输入内容，下拉列表显示百度搜索，直接回车。

## 打开指定应用
`option+空格` 唤醒, 输入`设置`, `chrome`等应用名字，会直接显示app，回车打开。

- `w` 可显示网易云音乐
- iterm 打开终端

## 计算器
唤醒直接在输入框输入算式，即可显示结果

## 翻译
在Web Search中添加`https://translate.google.cn/?text={query}`，设置快捷键`tr`

唤醒后输入`tr 翻译内容` 回车，可自动打开谷歌翻译

### 默认字典翻译
`define 翻译内容`
只能翻译词, 没有谷歌智能,可以及时显示翻译内容，不用打开网页

可以在`features->Dictionary->Defined a word`修改`denife`为`de`

## 退出某个应用

`quit` 加空格

## 常用

open用来打开文件，find用来显示文件所在位置

screensaver显示屏保

lock锁屏---(不生效)

sleep睡眠

trash废纸篓，emptytrash清空废纸篓

shutdown关机，restart重启，logout注销

# 好的链接推荐
[5分钟上手Mac效率神器Alfred以及Alfred常用操作](https://www.jianshu.com/p/e9f3352c785f)
[Alfred Workflow教程与实例](https://blog.csdn.net/sinat_32023305/article/details/78739118)