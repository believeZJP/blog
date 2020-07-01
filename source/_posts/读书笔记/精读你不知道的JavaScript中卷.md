---
title: 精读你不知道的JavaScript中卷
date: 2019-05-17 17:03:35
updated: 2019-05-17 17:03:35
tags:
- 读书笔记
- 精读
---
[TOC]

## I-第1章 类型

### 内置类型

ECMAScript 标准定义了 8 种数据类型:

7 种原始类型:
Undefined
Null
Number
Boolean
BigInt
String
Symbol
和 Object(基本类型)

记忆口诀：欧呦(O)你(U)俩(2个)牛(N)逼(B)啥(S)

用typeof来查看值的类型，返回的是字符串。但类型和它们的字符串值不一一对应

```js
typeof undefined === 'undefined'  // true
typeof true === 'boolean' // true
typeof 12 === 'number' // true
typeof '12' === 'string' // true
typeof { life: 12 } === 'object' // true
typeof Symbol() === 'symbol' // true
typeof BigInt('1') === 'bigint' // true
typeof Object(BigInt('2')) === 'object' // true

// 不一样的
typeof null === 'object' // true

// 检测null值的类型需要复合条件

const a = null;
(!a && typeof a === 'object'); // true

// function也是JS的内置类型，实际是object的子类型
typeof function a() {/**/} === 'function'; // true
// 数组也是object的子类型
typeof [1,2,3] === 'object' // true
```

### 值和类型

JS中变量没有类型，值才有。变量可以随时持有任何类型的值。

typeof得到的结果不是该变量的类型，而是该变量持有值的类型。返回的总是字符串。

```js
let a = 12;
typeof a; // 'number'

a = true;
typeof a; // 'boolean'

typeof typeof 12; // 'string'
```

### typeof Undeclared

```js
let a;
a; // undefined
b; // ReferenceError: b is not defined

typeof a; // "undefined"
typeof b; // "undefined"
```

typeof对未定义的变量也返回`undefined`。且没有报错。

这是因为typeof有一个特殊的安全防范机制。

多个脚本会在共享的全局命名空间中加载变量。

```js
// 这样会抛出错误
if (DEBUG) {
    console.log( "Debugging is starting" );
}
// 这样是安全的
if (typeof DEBUG !== "undefined") {
    console.log( "Debugging is starting" );
}

// 对内建API也有帮助
if (typeof atob === "undefined") {
    atob = function() { /*..*/ };
}
```

typeof安全机制也可以用来判断非全局变量

```js
(function(){
    function FeatureXYZ() { /*.. my XYZ feature ..*/ }
    // 包含doSomethingCool(..)
    function doSomethingCool() {
        var helper =
            (typeof FeatureXYZ !== "undefined") ? FeatureXYZ :
            function() { /*.. default feature ..*/ };
        var val = helper();
        // ..
    }
    doSomethingCool();
})();
```

这里FeatureXYZ不是全局变量，也可以用typeof安全防范机制来做检查

也可以用依赖注入方式

```js
function doSomethingCool(FeatureXYZ) {
    var helper = FeatureXYZ ||
    function() { /*.. default feature ..*/ };
    var val = helper();
    // ..
}
```

### 类型小结

1. 了解JS内置类型
2. 根据typeof判断类型
3. typeof的安全机制应用场景
