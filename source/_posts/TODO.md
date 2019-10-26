---
title: TODO.md
date: 2019-01-11 20:22:57
updated: 2019-01-11 20:22:57
tags:
---

# TODO 

JS 精度问题

```js
2599.7 * 100

1.1 * 100

0.1 + 0.2 = 0.3？
[从标准原理出发理解 JavaScript 数值精度](https://juejin.im/post/5c3db8b7e51d45515817bdeb)


```

[1](https://www.cnblogs.com/xinggood/p/6639022.html)
[math.js]

[解决办法](https://blog.csdn.net/qq_39712029/article/details/81031458)

## 无法实现的需求

## 1. 数字输入框只唤起数字键盘，不能输入汉字
`<input type='number'>`

在有的手机装了搜狗输入法或其他输入法后，唤起键盘输入法可以切换成其他输入法

有的机型没有装其他输入法，唤醒的不是数字键盘

## 2. 数字输入框获取不是数字的值

需求:
- 输入`.`时, 在`.`前加0, 显示`0.`

- 输入两个`..`时，去掉后一个

在input为number类型时，输入 . ，但onchange 取不到 . ，取到的是空字符串

- 相关知识点
`input ime-mode: disabled`
[[CSS]浏览器IME输入法控制禁止输入中文](https://blog.csdn.net/yctccg/article/details/52217988)
[关于表单input type="number"非法值时的一些探究及拓展](https://www.qcyoung.com/2015/09/01/type-number%E9%9D%9E%E6%B3%95%E5%80%BC%E7%9A%84%E4%B8%80%E4%BA%9B%E6%8E%A2%E7%A9%B6%E5%8F%8A%E6%8B%93%E5%B1%95/)
[input type=number驗證問題Script](https://www.itread01.com/p/1000919.html)

## [从 for of 聊到 Generator](https://juejin.im/post/5c40484bf265da61171cfb4d)

## [深入理解 TypeScript](https://jkchao.github.io/typescript-book-chinese/project/modules.html)

## [MDN javascript中高级教程](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript)

## 「中高级前端」高性能渲染十万条数据

[「中高级前端」高性能渲染十万条数据](https://juejin.im/post/5d76f469f265da039a28aff7)


## 读代码大全2笔记

软件开发的隐喻，到底什么词合适

先想到的是庖丁解牛，不过是相反的过程，缺少任何一个骨头肌肉都不能完整拼成。

但播种耕种更形象，播种直到丰收，每个细节都不能马虎，最终才能有秋后的果实。

大型的房屋建筑需要超出常规的规划和建设

组合各种隐喻


### 软件开发金字塔

1. 问题定义
   只定义问题是什么，不涉及任何可能的解决方案。
2. 需求
   需求像水，冻结了才能在上面开展建设。
3. 