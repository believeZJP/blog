---
title: 精读你不知道的JavaScript上卷
date: 2019-05-17 17:03:35
updated: 2019-05-17 17:03:35
tags:
- 读书笔记
- 精读
---
[TOC]

## I-第1章作用域是什么

### 编译原理

JavaScript是一门编译语言

传统的编译语言在代码执行前会经历三个步骤(编译)

* 分词/词法分析(Tokenizing/Lexing)

    将由字符组成的字符串分解成(对编程语言来说)有意义的代码块(词法单元token)
* 解析/语法分析(Parsing)

    将词法单元流(数组)转换成一个由元素逐级嵌套所组成的代表了程序语法结构的树(抽象语法树Abstract Syntax Tree，AST)。
* 代码生成

    将 AST 转换为可执行代码

JavaScript引擎编译过程比普通编译语言更复杂
在语法分析和代码生成阶段有特定的步骤来对运行性能进行优化，包括对冗余元素进行优化等。
用尽了各种办法(比如 JIT，可以延迟编译甚至实施重编译)来保证性能最佳。

### 理解作用域(建议多读几遍)

当变量出现在赋值操作的左侧时进行 LHS 查询，出现在右侧时进行 RHS 查询。

可以将 RHS 理解成 retrieve his source value(取到它的源值)，这意味着“得到某某的值”。
在概念上最好将其理解为“赋值操作的目标是谁(LHS)”以及“谁是赋值操作的源头(RHS)”。

如果查找的目的是对变量进行赋值，那么就会使用 LHS 查询;如果目的是获取变量的值，就会使用 RHS 查询。

赋值操作符会导致 LHS 查询。=操作符或调用函数时传入参数的操作都会导致关联作用域的赋值操作。

### 作用域

作用域是一套规则，用于确定在何处以及如何查找变量(标识符)。

遍历嵌套作用域链的规则: 从当前的执行作用域开始查找变量，如果找不到，就向上一级继续查找。当抵达最外层的全局作用域时，无论找到还是没找到，查找过程都会停止。

---

编码经验：减少无意义的变量查找次数和未定义变量的查找，可以提升效率

---

### 异常

RHS 查询遍寻不到所需的变量，引擎就会抛出 ReferenceError 异常。

非严格模式：引擎执行 LHS 查询时，如果在顶层(全局作用域)中也无法找到目标变量，
全局作用域中就会创建一个具有该名称的变量，并将其返还给引擎。

严格模式中 LHS 查询失败时，并不会创建并返回一个全局变量，引擎会抛出同 RHS 查询 失败时类似的 ReferenceError 异常。

如果 RHS 查询找到了一个变量，但是你尝试对这个变量的值进行不合理的操作， 比如试图对一个非函数类型的值进行函数调用，或者引用 null 或 undefined 类型的值中的属性，那么引擎会抛出另外一种类型的异常，叫作 TypeError。

ReferenceError 同作用域判别失败相关，而 TypeError 则代表作用域判别成功了，但是对结果的操作是非法或不合理的。

### 案例

```js
function foo(a) {
    var b = a;
    return a + b;
}
var c = foo( 2 );
```

1. 找出所有的LHS查询(这里有3处!)

    c = ..;、a = 2(隐式变量分配)、b = ..
2. 找出所有的RHS查询(这里有4处!)

    foo(2..、= a;、a ..、.. b

## I-第2章 词法作用域

词法作用域就是定义在词法阶段的作用域。

词法作用域意味着作用域是由书写代码时函数声明的位置来决定的。编译的词法分析阶段基本能够知道全部标识符在哪里以及是如何声明的，从而能够预测在执行过程中如何对它们进行查找。

无论函数在哪里被调用，也无论它如何被调用，它的词法作用域都只由函数被声明时所处的位置决定。

---

在多层的嵌套作用域中可以定义同名的标识符，这叫作“遮蔽效应”(内部的标识符“遮蔽”了外部的标识符)。

全局变量会自动成为全局对象(比如浏览器中的 window 对象)的属性，因此可以不直接通过全局对象的词法名称，而是间接地通过对全局对象属性的引用来对其进行访问`window.a`，通过这种方式可以访问那些被同名变量所遮蔽的全局变量。

但非全局的变量如果被遮蔽了，无论如何都无法被访问到。

---

### 欺骗语法

JavaScript 中有两个机制可以“欺骗”词法作用域:eval(..) 和 with。

前者可以对一段包含一个或多个声明的“代码”字符串进行演算，并借此来修改已经存在的词法作用域(在运行时)。

后者本质上是通过将一个对象的引用当作作用域来处理，将对象的属性当作作用域中的标识符来处理，从而创建了一个新的词法作用域(同样是在运行时)。

这两个机制的副作用是引擎无法在编译时对作用域查找进行优化，因为引擎只能谨慎地认为这样的优化是无效的。会导致性能下降。**不要使用它们。**

## I-第3章 函数作用域和块作用域

> 开发中，函数写的太多了。怎样才是个好的函数？我们常讲封装。封装函数，封装常用的方法，通过这章内容可以学习到为什么要封装，封装的好处和一些封装的方法。

函数作用域是指，属于这个函数的全部变量都可以在整个函数的范围内使用及复用(在嵌套的作用域中也可以使用)。
这种设计方案能充分利用 JavaScript 变量可以根据需要改变值类型的“动态”特性。

### 利用函数作用域隐藏内部实现

正确的代码应该考虑到如何选择作用域来包含变量和函数。遵循最小授权原则。

---

最小授权或最小暴露原则：在软件设计中，应该最小限度地暴露必要内容，而将其他内容都“隐藏”起来，比如某个模块或对象的 API 设计。

---

示例：

```js
function doSomething(a) {
    b = a + doSomethingElse( a * 2 );
    console.log( b * 3 );
}
function doSomethingElse(a) {
    return a - 1;
}
var b;
doSomething( 2 ); // 15
```

变量 `b` 和函数 `doSomethingElse(..)` 是 `doSomething(..)` 内部具体实现的“私有”内容。
给予外部作用域对 `b` 和 `doSomethingElse(..)` 的“访问权限”不仅没有必要，而且可能是“危险”的，
因为它们可能被有意或无意地以非预期的方式使用，从而导致超出了doSomething(..) 的适用条件。
更“合理”的设计会将这些私有的具体内容隐藏在 `doSomething(..)` 内部。

```js
function doSomething(a) {
    function doSomethingElse(a) {
        return a - 1;
    }
    var b;
    b = a + doSomethingElse( a * 2 );
    console.log( b * 3 );
}
doSomething( 2 ); // 15
```

**功能和效果都没受影响，设计上将具体内容私有化，设计良好的软件都会依此进行实现。**

#### 规避冲突

隐藏作用域中的变量和函数所带来的另一个好处，是可以避免同名标识符之间的冲突，

```js

function foo() {
    function bar(a) {
        i = 3; // 修改for循环所属作用域中的i
        console.log( a + i );
    }
    for (var i=0; i<10; i++) {
        bar( i * 2 ); // 糟糕，无限循环了!
    }
}
foo();
```

这里用`var i = 3;`和 `j = 3;`都可以解决这个问题，但使用作用域来“隐藏”内部声明是唯一的最佳选择。

##### 解决方案

1. 全局命名空间

    在jQuery时代，引用各种第三方库尤为明显。如果组件没有很好的将内部私有函数和变量隐藏起来会引起很多问题。

    最佳实践：声明一个名字足够独特的变量，通常是一个对象。所有需要暴露给外界的功能都会成为这个对象(命名空间)的属性，而不是将自己的标识符暴漏在顶级的词法作用域中。

    示例

    ```js
    var MyReallyCoolLibrary = {
        awesome: "stuff",
        doSomething: function() {
            // ...
        },
        doAnotherThing: function() {
            // ...
        }
    };
    ```

2. 模块管理

    从众多模块管理器中挑选一个来使用。使用这些工具，任何库都无需将标识符加入到全局作用域中，而是通过依赖管理器的机制将库的标识符显式地导入到另外一个特定的作用域中。

### 函数作用域优化

函数作用域需要显示声明函数名和调用该函数

采用包装函数来解决，将函数声明转成表达式

```js
var a = 2;
(function foo(){ // <-- 添加这一行
    var a = 3;
    console.log( a ); // 3
    })(); // <-- 以及这一行
console.log( a ); // 2
```

```!
如果 function 是声明中的第一个词，那么就是一个函数声明，否则就是一个函数表达式。
```

#### 匿名和具名函数

##### 匿名函数表达式

```js
setTimeout( function() {
    console.log("I waited 1 second!");
}, 1000 );
```

这叫作匿名函数表达式，因为 `function()..` 没有名称标识符。函数表达式可以是匿名的，
而函数声明则不可以省略函数名——在 JavaScript 的语法中这是非法的。

匿名函数缺点：

1. 匿名函数在栈追踪中不会显示函数名，调试很困难。
2. 如果没有函数名，当函数需要引用自身时只能使用已经过期的arguments.callee引用，比如在递归中。
   另一个函数需要引用自身的例子，是在事件触发后事件监听器需要解绑自身。
3. 匿名函数省略了对于代码可读性/可理解性很重要的函数名。一个描述性的名称可以让代码不言自明。

行内函数表达式非常强大且有用——匿名和具名之间的区别并不会对这点有任何影响。
给函数表达式指定一个函数名可以有效解决以上问题。
**始终给函数表达式命名是一个最佳实践**

```js
setTimeout( function timeoutHandler() { // <-- 快看，我有名字了!
    console.log( "I waited 1 second!" );
}, 1000 );
```

##### 立即执行函数表达式(IIFE Immediately Invoked Function Expression)

将函数包含在一对 ( ) 括号内部，因此成为了一个表达式，通过在末尾加上另外一个 ( ) 可以立即执行这个函数。
比如 `(function foo(){ .. })()`, 另一种形式`(function(){ .. }())`。两种形式在功能上是一致的。

IIFE进阶用法，把它们当作函数调用并传递参数进去。

```js
var a = 2;
(function IIFE( global ) {
    var a = 3;
    console.log( a ); // 3
    console.log( global.a ); // 2
})( window );
console.log( a ); // 2
```

将 window 对象的引用传递进去，但将参数命名为 global，因此在代码风格上对全局对象的引用变得比引用一个没有“全局”字样的变量更加清晰。
这对于改进代码风格是非常有帮助的。

IIFE 还有一种变化的用途是倒置代码的运行顺序，将需要运行的函数放在第二位，在 IIFE 执行之后当作参数传递进去。
这种模式在 UMD(Universal Module Definition)项目中被广泛使用。

```js

var a = 2;
(function IIFE( def ) {
    def( window );
})(function def( global ) {
    var a = 3;
    console.log( a ); // 3
    console.log( global.a ); // 2
});
```

### 块作用域

`{}`, `for`, `if`, `with`, `try/catch`, `let`, `const`都是声明块级作用域。

```js
if (foo) {
    { // <-- 显式的块
        let bar = foo * 2;
        bar = something( bar ); console.log( bar );
    }
}
console.log( bar ); // ReferenceError

```

**本质上，声明在一个函数内部的变量或函数会在所处的作用域中“隐藏”起来，这是有意为之的良好软件的设计原则。**

## I-第4章 提升

> 编译器在编译代码时是从上到下一行行编译的吗？

引擎会在执行 JavaScript 代码之前先对其进行编译。编译阶段中的一部分工作就是找到所有的声明，并用合适的作用域将它们关联起来。

变量和函数声明从它们在代码中出现的位置被“移动”到了最上面。这个过程就叫作提升。

注意：函数声明会被提升，**包括函数表达式的赋值在内的赋值操作**并不会提升。

**函数会首先被提升，然后才是变量。**

后面的函数声明可以覆盖前面的，如下输出3

```js
foo(); // 1
var foo;
function foo() {
    console.log( 1 );
}
// 函数表达式不会提升
foo = function() {
    console.log( 2 );
};
function foo() {
    console.log( 3 );
}

```

这个代码被引擎解析如下:

```js

function foo() {
    console.log( 1 );
}
function foo() {
    console.log( 3 );
}
foo(); // 3
foo = function() {
    console.log( 2 );
};
```

要注意避免重复声明，特别是当普通的 var 声明和函数声明混合在一起的时候，否则会引起很多危险的问题!

用`let`和`const`可以解决重复声明的问题。

## I-第5章 作用域闭包

### 闭包

当函数可以记住并访问所在的词法作用域时，就产生了闭包，即使函数是在当前词法作用域之外执行。

经典示例：

```js
function foo() {
    var a = 2;
    function bar() {
        console.log( a );
    }
    return bar;
}
var baz = foo();
baz(); // 2 —— 这就是闭包的效果。
```

bar() 在自己定义的词法作用域以外的地方执行。

在 foo() 执行后，通常会期待 foo() 的整个内部作用域都被销毁，因为引擎有垃圾回收器用来释放不再使用的内存空间。
由于看上去 foo() 的内容不会再被使用，所以很自然地会考虑对其进行回收。

而闭包的“神奇”之处正是可以阻止这件事情的发生。
由于 bar() 所声明的位置在foo内部，它拥有涵盖 foo() 内部作用域的闭包，使得该作用域能够一直存活，以供 bar() 在之后任何时间进行引用。

bar() 依然持有对该作用域的引用，而这个引用就叫作闭包。

循环经典案例：

```js
for (var i=1; i<=5; i++) {
    setTimeout( function timer() {
        console.log( i ); // 以每秒一次的频率输出五次 6
    }, i*1000 );
}

```

根据作用域的工作原理，实际情况是尽管循环中的五个函数是在各个迭代中分别定义的，但是它们都被封闭在一个共享的全局作用域中，因此实际上只有一个 i。

改进，为每次迭代生成新的作用域

```js
for (var i=1; i<=5; i++) {
    (function(j) {
        setTimeout( function timer() {
            console.log( j );
        }, j*1000 );
    })( i );
}
```

用`let`解决。let变量在循环过程中不止被声明一次，每次迭代都会声明。

```js
for (let i=1; i<=5; i++) {
    setTimeout( function timer() {
        console.log( i );
    }, i*1000 );
}

```

### 模块

模块模式需要具备两个必要条件。

1. 必须有外部的封闭函数，该函数必须至少被调用一次(每次调用都会创建一个新的模块实例)。
2. 封闭函数必须返回至少一个内部函数，这样内部函数才能在私有作用域中形成闭包，并且可以访问或者修改私有的状态。

示例：

```js
var foo = (function CoolModule() {
    var something = "cool";
    var another = [1, 2, 3];

    function doSomething() {
        console.log( something );
    }

    function doAnother() {
        console.log( another.join( " ! " ) );
    }

    return {
        doSomething: doSomething,
        doAnother: doAnother
    };
})();

foo.doSomething(); // cool
foo.doAnother(); // 1 ! 2 ! 3
```

```js
var foo = (function CoolModule(id) {
    function change() {
        // modifying the public API
        publicAPI.identify = identify2;
    }

    function identify1() {
        console.log( id );
    }

    function identify2() {
        console.log( id.toUpperCase() );
    }

    var publicAPI = {
        change: change,
        identify: identify1
    };

    return publicAPI;
})( "foo module" );

foo.identify(); // foo module
foo.change();
foo.identify(); // FOO MODULE
```

通过在模块实例的内部保留对公共 API 对象的内部引用，可以从内部对模块实例进行修改，包括添加或删除方法和属性，以及修改它们的值。

#### 现代的模块机制

```js
var MyModules = (function Manager() {
    var modules = {};

    function define(name, deps, impl) {
        for (var i=0; i<deps.length; i++) {
            deps[i] = modules[deps[i]];
        }
        modules[name] = impl.apply( impl, deps );
    }

    function get(name) {
        return modules[name];
    }

    return {
        define: define,
        get: get
    };
})();
```

**核心代码是这行`modules[name] = impl.apply( impl, deps );`**
为了模块的定义引入了包装函数(可以传入任何依赖)，并且将返回值，也就是模块的 API，储存在一个根据名字来管理的模块列表中。

看看怎么使用

```js
MyModules.define( "bar", [], function(){
    function hello(who) {
        return "Let me introduce: " + who;
    }

    return {
        hello: hello
    };
} );

MyModules.define( "foo", ["bar"], function(bar){
    var hungry = "hippo";

    function awesome() {
        console.log( bar.hello( hungry ).toUpperCase() );
    }

    return {
        awesome: awesome
    };
} );

var bar = MyModules.get( "bar" );
var foo = MyModules.get( "foo" );

console.log(
    bar.hello( "hippo" )
); // Let me introduce: hippo

foo.awesome(); // LET ME INTRODUCE: HIPPO

```

多花一点时间来研究这些示例代码并完全理解闭包的作用吧。最重要的是要理解模块管理器没有任何特殊的“魔力”。
它们符合前面列出的模块模式的两个特点:为函数定义引入包装函数，并保证它的返回值和模块的 API 保持一致。
换句话说，模块就是模块，即使在它们外层加上一个友好的包装工具也不会发生任何变化。

#### 未来的模块机制

ES6 中为模块增加了一级语法支持。但通过模块系统进行加载时，ES6 会将文件当作独立的模块来处理。
每个模块都可以导入其他模块或特定的 API 成员，同样也可以导出自己的 API 成员。

ES6 的模块没有“行内”格式，必须被定义在独立的文件中(一个文件一个模块)。

import 可以将一个模块中的一个或多个 API 导入到当前作用域中，并分别绑定在一个变量上(在我们的例子里是 hello)。
module 会将整个模块的 API 导入并绑定到一个变量上(在我们的例子里是 bar)。export 会将当前模块的一个标识符(变量、函数)导出为公共 API。
这些操作可以在模块定义中根据需要使用任意多次。

bar.js

```js
function hello(who) {
    return "Let me introduce: " + who;
}
export hello;

```

baz.js

```js
import bar from "bar";
console.log(bar.hello( "rhino" )); // Let
```

## II-第1章 关于this

this 提供了一种更优雅的方式来隐式“传递”一个对象引用，因此可以将 API 设计得更加简洁并且易于复用。

this 是在运行时进行绑定的，并不是在编写时绑定，它的上下文取决于函数调用时的各种条件。this 的绑定和函数声明的位置没有任何关系，只取决于函数的调用方式。
当一个函数被调用时，会创建一个活动记录(有时候也称为执行上下文)。这个记录会包含函数在哪里被调用(调用栈)、函数的调用方法、传入的参数等信息。this 就是记录的其中一个属性，会在函数执行的过程中用到。

this**既不指向函数自身也不指向函数的词法作用域**

**this实际上是在函数被调用时发生的绑定，它指向什么完全取决于函数在哪里被调用。**

## II-第2章 this全面解析

从[上一章](https://juejin.im/post/5efe67276fb9a07e5d76be30)知道理解this，就是要理解`函数被调用的位置`。但实践起来有点复杂。

```!
重要的是分析调用栈，在当前正在执行函数前一个调用中。在函数第一行设置`debugger`,开发者工具调用栈的第二个元素就是真正的调用位置。
```

### 四条绑定规则

#### 1. 独立调用

独立函数调用，即使用不带任何修饰的函数引用进行调用的，因此只能使用默认绑定，无法应用其他规则。

this 的绑定规则完全取决于调用位置，但是只有 foo() 运行在非 `strict mode` 下时，默认绑定才能绑定到全局对象;严格模式下与 foo() 的调用位置无关:

```js
function foo() {
    "use strict";
    console.log( this.a );
}
var a = 2;
foo(); // TypeError: this is undefined
```

```js
function foo() {
    console.log( this.a );
}
var a = 2;
foo(); // 2
```

#### 2. 隐式绑定

当函数引用有上下文对象时，隐式绑定规则会把函数调用中的 this 绑定到这个上下文对象。

如下：

```js
function foo() {
    console.log( this.a );
}
var obj2 = {
    a: 42,
    foo: foo
};
var obj1 = {
    a: 2,
    obj2: obj2
};
obj1.obj2.foo(); // 42
```

##### 隐式丢失

一个最常见的 this 绑定问题是被隐式绑定的函数会丢失绑定对象，它会应用默认绑定，从而把 this 绑定到全局对象或者 undefined 上，取决于是否是严格模式。

```js
function foo() {
    console.log( this.a );
}
var obj = {
    a: 2,
    foo: foo
};
var bar = obj.foo; // 函数别名!
var a = "oops, global"; // a 是全局对象的属性 bar(); // "oops, global"
```

回调函数里也会有this丢失现象

### 3. 显式绑定

`call`和`apply`可以直接指定 this 的绑定对象，称之为显式绑定。

```js
function foo() {
    console.log(this.a);
}
var obj = {
    a:2
};
foo.call(obj); // 2
```

#### 硬绑定

```js
function foo() {
    console.log( this.a );
}
var obj = {
    a:2
};
var bar = function() {
    foo.call( obj );
};
bar(); // 2
setTimeout( bar, 10 ); // 2
// 硬绑定的 bar 不可能再修改它的 this
bar.call( window ); // 2
```

在`bar`中强制把foo的this绑定到obj上，无论之后怎么调用bar，都不会修改this。这种显示强绑定，称为硬绑定。

ES5 中提供了内置的方法`Function.prototype.bind`也是强绑定。

#### API调用的“上下文”(context)

```js
[1, 2, 3].forEach( foo, obj );
// 1 awesome 2 awesome 3 awesome
```

这种也是通过call和apply实现的显示绑定。

### 4. new绑定

js通过new来调用函数，或者说发生构造函数调用时，会自动执行下面的操作。

1. 创建(构造)一个全新的对象。
2. 这个新对象会被执行原型连接。
3. 这个新对象会绑定到函数调用的this。
4. 如果函数没有返回其他对象，那么new表达式中的函数调用会自动返回这个新对象。

### 优先级

四条绑定原则的优先级

1. 由new调用? 绑定到新创建的对象。
2. 由call或者apply(或者bind)调用? 绑定到指定的对象。
3. 由上下文对象调用? 绑定到那个上下文对象。
4. 默认:在严格模式下绑定到undefined，否则绑定到全局对象。

### 绑定例外

把 null 或者 undefined 作为 this 的绑定对象传入 call、apply 或者 bind，这些值
在调用时会被忽略，实际应用的是默认绑定规则。

函数的间接引用，会导致应用默认绑定。

#### 软绑定

硬绑定可以强制绑定到指定对象(除new时)，降低了函数的灵活性。采用软绑定方式可以实现和硬绑定相同的效果，同时保留隐式绑定修改this的能力。

```js
if (!Function.prototype.softBind) {
    Function.prototype.softBind = function(obj) {
        var fn = this;
        // 捕获所有 curried 参数
        var curried = [].slice.call( arguments, 1 );
        var bound = function() {
            return fn.apply(
            (!this || this === (window || global)) ?
            obj : this
            curried.concat.apply( curried, arguments )
            );
        };
        bound.prototype = Object.create( fn.prototype );
        return bound;
    };
}
```

### this语法

箭头函数`() => {}`无法使用上述四种规则。而是**根据外层（函数或者全局）作用域来决定this**。
箭头函数可以像 `bind(..)` 一样确保函数的 this 被绑定到指定对象，它用更常见的词法作用域取代了传统的 this 机制。

没有箭头函数之前我们习惯采用的方式

```js
function foo() {
    var self = this; // lexical capture of this
    setTimeout( function(){
        console.log( self.a );
    }, 100 );
}
var obj = {
    a: 2
};
foo.call( obj ); // 2
```

`self = this` 和箭头函数看起来都可以取代`bind(..)`，但是从本质上来说，它们想替代的是 this 机制。

### 小结this全面解析

学习本章了解this绑定的方式，通过4条准则定位函数运行时this到底指向什么。

在箭头函数出来之后，用`() => {}`和`bind`可以解决大多数问题了。

ES5出来之后，很多js的问题被新语法取代了，但我们可以抽时间多了解新语法背后的历史，能更深入的了解js本身的魅力。

## II-第3章 对象

对象是JavaScript的基础。

ECMAScript 标准定义了 8 种数据类型:

7 种原始类型:
Undefined
Null
Number
Boolean
BigInt
String
Symbol
和 Object

记忆口诀：欧呦(O)你(U)俩(2个)牛(N)逼(B)啥(S)

定义对象两种形式：声明形式和构造形式。

```js
// 声明
var myObj = {
    key: value
    // ...
};

// 构造
var myObj = new Object();
myObj.key = value;
```

### 可计算属性

ES6 增加了可计算属性名，可以在文字形式中使用 [] 包裹一个表达式来当作属性名:

```js
var prefix = "foo";
var myObject = {
    [prefix + "bar"]:"hello",
    [prefix + "baz"]: "world"
};
myObject["foobar"]; // hello
```

### 属性与方法

js中函数不会属于一个对象，因为this是在运行时根据调用位置动态绑定的。 所以方法这个称呼不太成立。但这只是个称呼，不必太纠结。

### 复制对象

浅复制

对于JSON安全(可以被序列化为一个 JSON 字符串并且可以根据这个字符串解析出一个结构和值完全一样的对象)的对象可以用`JSON.parse`复制

`var newObj = JSON.parse(JSON.stringify(someObj));`

ES6中可以用`Object.assign({}, obj)`复制

### 属性描述符

属性描述符`writable(可写), configurable(可配置), enumerable(可枚举)`

可以使用`Object.defineProperty`定义属性

```js

Object.defineProperty(obj, 'KEY', {
    value: 12,
    writable: false,
    configurable: false
});

```

如果把 enumerable 设置成 false，这个属性不会出现在枚举中（比如for..in）。但可以正常访问这个属性。

结合`writable: false`和`configurable: false`可以创建一个真正的常量属性(不可修改、重定义或删除)

禁止一个对象添加新属性并且保留已有属性，可以使用`Object.preventExtensions(obj)`

密封：`Object.seal(..)`调用`Object.preventExtensions(obj)`把所有现有属性标记为`configurable: false`。密封后不能添加，重新配置和删除现有属性。可以修改属性的值。

冻结：`Object.freeze(..)`调用`Object.seal(..)`把所有数据访问属性标记为`writable: false`。这样就无法修改属性值。

### get, set

get: 属性访问先在对象中查找是否有名称相同的属性，没找到就遍历可能存在的原型链，找不到的话返回undefined。

set:

1. 先判断属性是否是访问描述符，存在setter就调用setter。
2. writable是否为false。是，非严格模式下静默失败，严格模式抛出TypeError异常。
3. 都不是，设置属性值。

```js
var myObject = {
// 给 a 定义一个 getter
    get a() {
        return this._a_;
    },
// 给 a 定义一个 setter
    set a(val) {
        this._a_ = val * 2;
    }
};
myObject.a = 2; myObject.a; // 4
```

### 存在性

判断对象是否有某个属性

```js
var myObject = {
    a:2
};
("a" in myObject); // true
("b" in myObject); // false
myObject.hasOwnProperty( "a" ); // true
myObject.hasOwnProperty( "b" ); // false
```

`in`操作符会检查属性是否在对象及其原型链中

`hasOwnProperty(..)` 只会检查属性是否在 myObject 对象中，不会检查链。

所有的普通对象都可以通过对于 Object.prototype 的委托来访问 hasOwnProperty(..)，
但是有的对象可能没有连接到 Object.prototype(通过 Object. create(null) 来创建)。
在这种情况下，形如`myObejct.hasOwnProperty(..)`就会失败。

可以采用`Object.prototype.hasOwnProperty. call(myObject,"a")`判断

在数组上应用 for..in 循环有时会产生出人意料的结果，因为这种枚举不仅会包含所有数值索引，还会包含所有可枚举属性。最好只在对象上应用 for..in 循环，如果要遍历数组就使用传统的 for 循环来遍历数值索引。

```js
// 判断是否可枚举
myObject.propertyIsEnumerable( "a" ); // true
myObject.propertyIsEnumerable( "b" ); // false
// 所有可枚举属性的数组
Object.keys( myObject ); // ["a"]
// 所有属性，无论它们是否可枚举
Object.getOwnPropertyNames( myObject ); // ["a", "b"]
```

### 遍历

`for..in`无法直接获取属性值，因为它遍历的是对象中的所有可枚举属性，需要手动获取属性值。
`for..of`循环每次调用 myObject 迭代器对象的 next() 方法时，内部的指针都会向前移动并返回对象属性列表的下一个值。

### 小结 第3章对象

了解对象是什么，怎么定义，一些常用方法和特性，遍历对象。

工作中对象的使用是非常频繁的，熟练掌握各种API是提升技术的必备条件。

### 最佳实践

```js
// good
const newObj = {
    a: 12,
    b: 23
};
// bad
const newObj = {};
newObj.a = 12;
newObj.b = 23;
newObj['a'] = 12;

// good
this.setState({
    ...newObj
});

// bad
this.setState({
    a: newObj.a,
    b: newObj.b
});

```

## II-第4章 混合对象”类“

> 我的理解类也是一种对象而已，没那么复杂。

类是一种设计模式。许多语言提供了对于面向类软件设计的原生语法。

类意味着复制。
传统的类被实例化时，它的行为会被复制到实例中。类被继承时，行为也会被复制到子类中。
多态(在继承链的不同层次名称相同但是功能不同的函数)看起来似乎是从子类引用父类，但是本质上引用的是复制的结果。

JavaScript 并不会(像类那样)自动创建对象的副本。

混入模式用来模拟类的复制行为。Vue中也提供了类似的API,[mixin](<https://cn.vuejs.org/v2/guide/mixins.html>)

## II-第5章 原型（还需多读几遍）

```!
这篇文章是JS的重中之重，要用心研读~~
```

能学到的知识：

1. 对象查找和设置属性背后发生了什么

2. 原型链形成的机制和特点

前面说到在对象里查找属性时，如果在对象本身找不到，会继续访问对象的prototype链。如果都没有的话返回`undefined`

```js
var anotherObject = {
    a:2
};
// 创建一个关联到 anotherObject 的对象
var myObject = Object.create( anotherObject );
console.log(myObject); // {}
myObject.a; // 2
```

现在`myObject`的`prototype`关联到`anotherObject`，`myObject.a`并不存在，但`myObject.a`结果为2

`for..in`遍历对象时原理和查找原型链类似。任何可通过原型链访问到(并且是enumerable)的属性都会被枚举

当你通过各种语法进行属性查找时都会查找原型链，直到找到属性或者查找完整条原型链。

**原型链的尽头是`Object.prototype`**
`toString()`、`valueOf()`和其他一些通用的功能 都存在于`Object.prototype`对象上，因此语言中所有的对象都可以使用它们。

### 属性设置和屏蔽

给一个对象设置属性的过程并不简单。通过例子来看`myObject.foo = "bar";`

一、 如果 myObject 对象中包含名为 foo 的普通数据访问属性，这条赋值语句只会修改已有的属性值。

二、 如果 foo 不是直接存在于 myObject 中，原型链就会被遍历。如果原型链上找不到 foo，foo 就会被直接添加到 myObject 上。

三、 如果 foo 存在于原型链上层，赋值语句 `myObject.foo = "bar"` 的行为就会有些不同。

如果属性名 foo 既出现在 myObject 中也出现在 myObject 的原型链上层，那么就会发生屏蔽。myObject 中包含的 foo 属性会屏蔽原型链上层的所有 foo 属性，因为 myObject.foo 总是会选择原型链中最底层的 foo 属性。

> 屏蔽：在当前作用域添加属性，以隔绝访问原型链上层的同样属性

发生屏蔽的三种情况：

1. 如果在原型链上层存在名为foo的普通数据访问属性并且没有被标记为只读，那就会直接在 myObject 中添加一个名为 foo 的新属性，它是屏蔽属性。
2. 如果在原型链上层存在foo，但是它被标记为只读，那么无法修改已有属性或者在 myObject 上创建屏蔽属性。如果运行在严格模式下，代码会抛出一个错误。否则，这条赋值语句会被忽略。总之，不会发生屏蔽。
3. 如果在原型链上层存在foo并且它是一个setter，那就一定会调用这个 setter。foo 不会被添加到(或者说屏蔽于)myObject，也不会重新定义 foo 这个 setter。

向原型链上层已经存在的属性赋值，不一定会触发屏蔽(第二三种)。
如果希望在第二种和第三种情况下也屏蔽 foo，那就不能使用 = 操作符来赋值，而是使用 Object.defineProperty(..)来向 myObject 添加 foo。

> 只读属性会阻止原型链下层屏蔽同名属性。这样做主要是为了模拟类属性的继承。你可以把原型链上层的 foo 看作是父类中的属性，它会被 myObject 继承(复制)，这样一来 myObject 中的 foo 属性也是只读，所以无法创建。但是一定要注意，实际上并不会发生类似的继承复制。这看起来有点奇怪，myObject 对象竟然会因为其他对象中有一个只读 foo 就不能包含 foo 属性。更奇怪的是，这个限制只存在于 = 赋值中，使用 Object. defineProperty(..) 并不会受到影响。

有些情况下会隐式产生屏蔽，如下：

```js
var anotherObject = {
    a:2
};
var myObject = Object.create( anotherObject );
anotherObject.a; // 2
myObject.a; // 2
myObject.a++; // 隐式屏蔽!
anotherObject.a; // 2
myObject.a; // 3
myObject.hasOwnProperty( "a" ); // true

```

`++` 操作相当于 `myObject.a = myObject.a + 1`。因此 ++ 操作首先会通过原型链查找属性 a 并从 anotherObject.a 获取当前属性值 2，然后给这个值加 1，接着将值 3 赋给 myObject 中新建的屏蔽属性 a。

修改委托属性时一定要小心。如果想让 anotherObject.a 的值增加，唯一的办法是 anotherObject.a++。

### 类函数

函数的一种特殊特性:所有的函数默认都会拥有一个名为 prototype 的公有并且不可枚举的属性，它会指向另一个对象: Foo的原型。我们通过名为 Foo.prototype 的属性引用来访问它。

```js
function Foo() {
    // ...
}
Foo.prototype; // { }
var a = new Foo();
Object.getPrototypeOf( a ) === Foo.prototype; // true

```

调用 new Foo() 时会创建 a，其中的一步就是给 a 一个内部的原型链，关联到 Foo.prototype 指向的那个对象。

在 JavaScript 中，不能创建一个类的多个实例，只能创建多个对象，它们的原型链关联的是同一个对象。在默认情况下多次实例化一个类不会进行复制， 因此这些对象之间并不会完全失去联系，它们是互相关联的。

通过`new Foo()`得到了两个对象，它们之间互相关联，就是这样。我们并没有初始化一个类，实际上我们并没有从“类”中复制任何行为到一个对象中，只是让两个对象互相关联。

实际上，绝大多数 JavaScript 开发者不知道的秘密是，new Foo() 这个函数调用实际上并没有直接创建关联，这个关联只是一个意外的副作用。new Foo() 只是间接完成了我们的目标:一个关联到其他对象的新对象。

通过`Object.create(..)`可以直接做到这一点。

通常我们讲原型继承。继承意味着复制操作。JS默认不会复制对象属性。会在两个对象之间创建关联，这样一个对象可以通过委托访问另一个对象的属性和函数。

差异继承？

### 构造函数

在 JavaScript 中对于“构造函数”最准确的解释是，所有带 new 的函数调用。

函数不是构造函数，但是当且仅当使用 new 时，函数调用会变成“构造函数调用”。

```js
function Foo() {
    // ...
}
Foo.prototype.constructor === Foo; // true
var a = new Foo();
a.constructor === Foo; // true
```

Foo.prototype 默认(在代码中第一行声明时)有一个公有并且不可枚举的属性`.constructor`，这个属性引用的是对象关联的函数(本例中是 Foo)。
此外，我们可以看到通过“构造函数”调用 new Foo() 创建的对象也有一个 `.constructor` 属性，指向 “创建这个对象的函数”。

`a.constructor` 只是通过默认的原型委托指向 Foo，这和构造毫无关系。

```js
function Foo() { /* .. */ }
Foo.prototype = { /* .. */ }; // 创建一个新原型对象
var a1 = new Foo();
a1.constructor === Foo; // false!
a1.constructor === Object; // true!
```

Object(..) 并没有“构造”a1，看起来应该是 Foo()“构造”了它。
大部分开发者 都认为是 Foo() 执行了构造工作，但是问题在于，如果你认为`constructor`表示“由...... 构造”的话，a1.constructor 应该是 Foo，但是它并不是 Foo !

a1 并没有 .constructor 属性，所以它会委托原型链上的 Foo. prototype。但是这个对象也没有 .constructor 属性(不过默认的 Foo.prototype 对象有这 个属性!)，
所以它会继续委托，这次会委托给委托链顶端的 Object.prototype。这个对象 有 .constructor 属性，指向内置的 Object(..) 函数。

对象的 .constructor 会默认指向一个函数，这个函数可以通过对象的 .prototype 引用。

**constructor 并不表示被构造**
.constructor 并不是一个不可变属性。它是不可枚举的，但是它的值是可写的。此外，你可以给任意原型链中的任意对象添加一个名为 constructor 的属性或者对其进行修改，你可以任意对其赋值。

### 原型继承

`Bar.prototype = Object.create()`
Object.create(..) 会凭空创建一个“新”对象并把新对象内部的原型链关联到指定的对象(本例中是 Foo.prototype)。
换句话说，这条语句的意思是:“创建一个新的 Bar.prototype 对象并把它关联到 Foo. prototype”。

```js
// 和你想要的机制不一样!
Bar.prototype = Foo.prototype;
// 基本上满足你的需求，但是可能会产生一些副作用 :(
Bar.prototype = new Foo();
```

Bar.prototype = Foo.prototype 并不会创建一个关联到 Bar.prototype 的新对象，它只是让 Bar.prototype 直接引用 Foo.prototype 对象。
因此当你执行类似`Bar.prototype. myLabel = ...`的赋值语句时会直接修改 Foo.prototype 对象本身。
显然这不是你想要的结果，否则你根本不需要 Bar 对象，直接使用 Foo 就可以了，这样代码也会更简单一些。

Bar.prototype = new Foo() 的确会创建一个关联到 Bar.prototype 的新对象。
但是它使用了 Foo(..) 的“构造函数调用”，如果函数 Foo 有一些副作用(比如写日志、修改状态、注册到其他对象、给 this 添加数据属性，等等)的话，
就会影响到 Bar() 的“后代”，后果 不堪设想。

对比一下两种把 Bar.prototype 关联到 Foo.prototype 的方法:

```js
// ES6 之前需要抛弃默认的 Bar.prototype
Bar.ptototype = Object.create( Foo.prototype );
// ES6 开始可以直接修改现有的
Bar.prototype Object.setPrototypeOf( Bar.prototype, Foo.prototype );
```

如果忽略掉 Object.create(..) 方法带来的轻微性能损失(抛弃的对象需要进行垃圾回收)，它实际上比 ES6 及其之后的方法更短而且可读性更高。不过无论如何，这是两种完全不同的语法。

### 检查类关系

`instanceof` 操作符的左操作数是一个普通的对象，右操作数是一个函数。

在 a 的整条原型链中是否有指向 Foo.prototype 的对象?

这个方法只能处理对象(a)和函数(带 .prototype 引用的 Foo)之间的关系。如果你想判断两个对象(比如 a 和 b)之间是否通过原型链关联，只用 instanceof 无法实现。

第二种判断反射的方法：

`Foo.prototype.isPrototypeOf( a ); // true`

b 是否出现在 c 的原型链中?
`b.isPrototypeOf( c );`

直接获取一个对象原型链的方法`Object.getPrototypeOf(a)`

`Object.getPrototypeOf( a ) === Foo.prototype; // true`

非标准的方法`a.__proto__ === Foo.prototype; // true`

`.constructor`和`.__proto__`一样，并不存在于你正在使用的对象中 (本例中是 a)。
它和其他的常用函数(.toString()、.isPrototypeOf(..)，等等)
一样，存在于内置的 Object.prototype 中。是不可枚举的。

.__proto__ 的实现大致上是这样的

```js
Object.defineProperty( Object.prototype, "__proto__", {
    get: function() {
        return Object.getPrototypeOf( this ); },
    set: function(o) {
        // ES6 中的 setPrototypeOf(..)
        Object.setPrototypeOf( this, o );
        return o;
    }
});
```

### 对象关联

`Object.create(..)` 会创建一个新对象(bar)并把它关联到我们指定的对象(foo)，
这样我们就可以充分发挥原型链机制的威力(委托)并且避免不必要的麻烦(比如使用 new 的构造函数调用会生成 `.prototype` 和 `.constructor` 引用)。

`Object.create()`的polyfill代码

```js
if (!Object.create) {
    Object.create = function(o) {
        function F(){}
        F.prototype = o;
        return new F();
    };
}

```

## II-第6章 行为委托

委托行为意味着某些对象(XYZ)在找不到属性或者方法引用时会把这个请求委托给另一个对象(Task)。

```js
Task = {
    setID: function(ID) { this.id = ID; },
    outputID: function() { console.log( this.id ); }
};
// 让XYZ委托Task
XYZ = Object.create( Task );
XYZ.prepareTask = function(ID,Label) {
    this.setID(ID);
    this.label = Label;
};
XYZ.outputTaskDetails = function() {
    this.outputID();
    console.log(this.label);
};
```

这是一种极其强大的设计模式，和父类、子类、继承、多态等概念完全不同。在你的脑海中对象并不是按照父类到子类的关系垂直组织的，而是通过任意方向的委托关联并排组织的。

写不下去了~~

学不精，所以讲不通

待我理解透彻再来更新吧
