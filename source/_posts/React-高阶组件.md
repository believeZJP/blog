---
title: React 高阶组件
date: 2018-12-09 19:30:57
updated: 2018-12-09 19:30:57
tags:
    - React
---

# 高阶组件
高阶组件（ higher-order component ，HOC ）是 React 中复用组件逻辑的一种进阶技巧。
它本身并不是 React 的 API，而是一种 React 组件的设计理念，众多的 React 库已经证明了它的价值，例如耳熟能详的 react-redux。

高阶函数是把函数作为参数传入到函数中并返回一个新的函数。
把函数替换成组件，就是高阶组件。

`const EnhancedComponent = higherOrderComponent(WrappedComponent);`

高阶组件就是一个函数，用来封装重复的逻辑。
传进去一个老组件，返回一个新组件

# 内容概要
