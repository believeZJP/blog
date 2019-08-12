---
title: 'js-组合函数 '
date: 2019-08-12 23:49:11
updated: 2019-08-12 23:49:11
tags:
- JavaScript
- 组合函数
- compose
---

## 概念

compose函数，会接收若干个函数作为参数，每个函数执行后的输出作为下一个函数的输出，直至最后一个函数的输出作为最终的结果。

show code~~~

```js
let n = '3.56';
let data = parseFloat(n);
let result = Math.round(data); // => 最终结果 4

// 用 组合函数
let n = '3.56';
let number = compose(Math.round,parseFloat);
let result = number(n); // =>4 最终结果

```

以上代码的核心是通过`compose`将`parseFloat`和`Math.round`组合到一个返回一个新函数 `number`

这就是函数式组合，将两个函数组合在一起以便能及时的构造出一个新函数。

## 应用

需求: 一个字符串，将字符串转化为大写，然后逆序。

常规思路：

```js
let str = 'jspool';

// 先转成大写，再逆序
function fn(str) {
    let upperStr = str.toUpperCase();
    return upperStr.split('').reverse().join();
}

fn(str);
```

代码没问题，现在改需求。将字符串大写之后，每个字符拆开并封装成一个数组。`"jspool" => ["J","S","P","O","O","L"]`

为了修改这个目标，需要修改之前封装的函数，这就破坏了设计模式的开闭原则。

> 开闭原则：软件中的对象（类，模块，函数等等）应该对于扩展是开放的，但是对于修改是封闭的。

用组合思想怎么写呢?

原需求实现：

```js
let str = 'jspool'

function stringToUpper(str) {
    return str.toUpperCase()
}

function stringReverse(str) {
    return str.split('').reverse().join('')
}

let toUpperAndReverse = compose(stringReverse, stringToUpper)
let result = toUpperAndReverse(str) // "LOOPSJ"

```

现在实现新需求

```js
let str = 'jspool'

function stringToUpper(str) {
    return str.toUpperCase()
}

function stringReverse(str) {
    return str.split('').reverse().join('')
}

function stringToArray(str) {
    return str.split('')
}

let toUpperAndArray = compose(stringToArray, stringToUpper)
let result = toUpperAndArray(str) // => ["J","S","P","O","O","L"]
```

可以看到，需求变更时，没有打破封装以前的代码，只是新增了函数功能，把函数进行重新组合。

> 可能有人会有疑问，应用组合的方式书写代码，当需求变更时，依然也修改了代码，不是也算破坏了开闭原则么？其实我们修改的是调用的逻辑代码，并没有修改封装、抽象出来的代码，而这种书写方式也正是开闭原则所提倡的。

现在又改需求: 字符串转大写后，截取前3个字符，然后转为数组。

```js
let str = 'jspool'

function stringToUpper(str) {
    return str.toUpperCase()
}

function stringReverse(str) {
    return str.split('').reverse().join('')
}

function getThreeCharacters(str){
    return str.substring(0,3)
}

function stringToArray(str) {
    return str.split('')
}

let toUpperAndGetThreeAndArray = compose(stringToArray, getThreeCharacters,stringToUpper)
let result = toUpperAndGetThreeAndArray(str) // => ["J","S","P"]

```

以上，组合的方式是抽象单一功能的函数，再组成复杂功能，代码逻辑更清晰，也给维护带来巨大方便。

## 实现组合

新函数执行时，按照**由右向左**的顺序依次执行传入`compose`中的函数，每个函数的执行结果作为下一个函数的入参，直到最后一个函数的输出作为最终的输出结果。

如果compose函数接收的函数数量是固定的。

```js
function compose(f,g){
    return function(x){
        return f(g(x));
    }
}

function compose(f,g){
    return function(x){
        return f(g(x));
    }
}
```

但实际compose接收的参数个数是不确定的，我们考虑用rest参数来接收：

```js
function compose(...fns) {
    return function(x) {
        // ...
    }
}
```

现在compose接收的参数fns是一个数组，如何将数组中的函数`从右向左`依次执行.

用数组的reduceRight来实现

```js
function compose(...fns) {
    return function(x) {
        return fns.reduceRight(function(arg, fn) {
            return fn(arg);
        }, x)
    }
}
```

这样就实现了compose函数~~

## 实现管道

compose的数据流是`从右到左`, 因为右侧函数首先执行，左侧最后执行。
但有人喜欢从左至右的执行方式。

> 从左至右处理数据流的过程称之为管道(pipeline)

只需将`reduceRight`替换为`reduce`

```js
function pipe(...fns) {
    return function(x) {
        return fns.reduce(function(arg, fn) {
            return fn(arg);
        }, x);
    }
}
```
