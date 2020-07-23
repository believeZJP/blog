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

一个人身上的特异性和一个人身上的特异性与惊奇性并不会对另一人产生压制。你身上的天才，会激发我身上的天才。

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

typeof a; // 'undefined'
typeof b; // 'undefined'
```

typeof对未定义的变量也返回`undefined`。且没有报错。

这是因为typeof有一个特殊的安全防范机制。

多个脚本会在共享的全局命名空间中加载变量。

```js
// 这样会抛出错误
if (DEBUG) {
    console.log( 'Debugging is starting' );
}
// 这样是安全的
if (typeof DEBUG !== 'undefined') {
    console.log( 'Debugging is starting' );
}

// 对内建API也有帮助
if (typeof atob === 'undefined') {
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
            (typeof FeatureXYZ !== 'undefined') ? FeatureXYZ :
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

## I-第2章 值

```!
通过这章的学习，可以了解，数组，字符串，特殊数值，值传递和值引用的区别
```

### 数组

JS的数组可容纳任何类型的值，数组声明后即可添加值，不用预设大小。

```js
let a = [1, '2', [3]];
a.length; // 3
a[2][0] === 3; // true

a[4] =  5;
a[3]; // undefined
```

a[3]为undefined，称作"稀疏数组"（sparse array）。这里的undefined与显示赋值为undefined不同。

数组也是对象。可以自定义属性(不计算在数组长度内)。

```js
let a = [1];
a['foo'] = 2;
a.length; // 1
a['foo']; // 2
```

### 类数组

类数组转数组常用方法

```js
// slice() 返回参数列表的一个数组复本。
var arr = Array.prototype.slice.call( arguments );

var arr = Array.from( arguments );
```

### 字符串

字符串和数组相似，都有length属性，indexOf, concat方法

```js
let a = 'foo';
let b = ['f', 'o', 'o'];

a.length; // 3
b.length; // 3
a.indexOf('o'); // 1
b.indexOf('o'); // 1

var c = a.concat( 'bar' );// 'foobar'
var d = b.concat( ['b','a','r'] );// ['f','o','o','b','a','r']
a === c;// false

b === d;// false

a; // 'foo'

b; // ['f','o','o']

```

字符串不可变是指字符串的成员函数不会改变其原始值，而是创建并返回一个新的字符串。而数组的成员函数都是在其原始值上进行操作。

借助数组方法来处理字符串

```js
a.join;   // undefined
a.map;   // undefined

var c = Array.prototype.join.call( a, '-' );
var d = Array.prototype.map.call( a, function(v){
    return v.toUpperCase() + '.';
} ).join( '' );

c;    // 'f-o-o'
d;    // 'F.O.O.'
```

字符串反转

字符串没有`reverse`方法

```js
var c = a
// 将a的值转换为字符数组
.split( "" )
// 将数组中的字符进行倒转
.reverse()
// 将数组中的字符拼接回字符串
.join( "" );
c; // "oof"
```

如果经常以字符数组方式处理字符串的话，倒不如直接用数组。在需要时使用`join()`将数组转成字符串。

### 数字

toFixed()返回的是字符串
toPrecision(..) 方法用来指定有效数位的显示位数

```js
var a = 42.59;
a.toFixed( 0 ); // "43"
a.toFixed( 1 ); // "42.6"
a.toFixed( 2 ); // "42.59"
a.toFixed( 3 ); // "42.590"

var a = 42.59;

a.toPrecision( 1 ); // "4e+1"
a.toPrecision( 2 ); // "43"
a.toPrecision( 3 ); // "42.6"
a.toPrecision( 4 ); // "42.59"
a.toPrecision( 5 ); // "42.590"
```

不过对于 `.` 运算符需要给予特别注意，因为它是一个有效的数字字符，会被优先识别为数字常量的一部分，然后才是对象属性访问运算符。

`42.tofixed(3)` 是无效语法，因为 `.` 被视为常量 `42.` 的一部分(如前所述)，所以没有 `.` 属 性访问运算符来调用 tofixed 方法。
`42..tofixed(3)` 则没有问题，因为第一个 `.` 被视为 number 的一部分，第二个 `.` 是属性访问运算符。

```js
// invalid syntax:
42.toFixed( 3 ); // SyntaxError

// these are all valid:
(42).toFixed( 3 ); // "42.000"
0.42.toFixed( 3 ); // "0.420"
42..toFixed( 3 ); // "42.000"
42 .toFixed(3); // "42.000"

```

怎样判断`0.1+0.2 === 0.3`

最常见的方法是设置一个误差范围值，通常称为“机器精度”(machine epsilon)，对JavaScript的数字来说，这个值通常是 2^-52 (2.220446049250313e-16)。
从 ES6 开始，该值定义在 Number.EPSILON 中，我们可以直接拿来用，也可以为 ES6 之前
的版本写 polyfill:

```js
if (!Number.EPSILON) {
    Number.EPSILON = Math.pow(2,-52);
}
```

可以使用 Number.EPSILON 来比较两个数字是否相等(在指定的误差范围内):

```js
function numbersCloseEnoughToEqual(n1,n2) {
    return Math.abs( n1 - n2 ) < Number.EPSILON;
}
var a = 0.1 + 0.2;
var b = 0.3;
numbersCloseEnoughToEqual( a, b );  // true
numbersCloseEnoughToEqual( 0.0000001, 0.0000002 ); // false
```

数字“安全”呈现的最大整数是2^53 - 1，即9007199254740991，在ES6中被定义为 Number.MAX_SAFE_INTEGER。
最小整数是 -9007199254740991， 在 ES6 中 被 定 义 为 Number. MIN_SAFE_INTEGER。

整数检测`Number.isInteger(..)`

```js
Number.isInteger( 42 ); // true
Number.isInteger( 42.000 ); // true
Number.isInteger( 42.3 ); // false

// polyfill
if (!Number.isInteger) {
    Number.isInteger = function(num) {
        return typeof num == "number" && num % 1 == 0;
    };
}
```

检测安全的整数`Number.isSafeInteger(..)`

```js
Number.isSafeInteger( Number.MAX_SAFE_INTEGER );// true
Number.isSafeInteger( Math.pow( 2, 53 ) );// true
Number.isSafeInteger( Math.pow( 2, 53 ) - 1 );// false

// polyfill
if (!Number.isSafeInteger) { Number.isSafeInteger = function(num) {
    return Number.isInteger( num ) &&
        Math.abs( num ) <= Number.MAX_SAFE_INTEGER;
    };
}

```

### 特殊数值

#### undefined和null

undefined 类型只有一个值，即 undefined。null 类型也只有一个值，即 null。它们的名
称既是类型也是值。

- null 指空值(empty value)，曾赋过值，但是目前没有值
- undefined 指没有值(missing value)，从未赋值

null 是一个特殊关键字，不是标识符，我们不能将其当作变量来使用和赋值。然而
undefined 却是一个标识符，可以被当作变量来使用和赋值。（不要给undefined赋值！）

#### void运算符

表达式void ___没有返回值，因此返回结果是undefined。void并不改变表达式的结果， 只是让表达式不返回值:

```js
var a = 42;
console.log( void a, a ); // undefined 42

```

如果要将代码中的值(如表达式的返回值)设为 undefined，就可以使用 void。

#### 特殊的数字

NaN 意指“不是一个数字”(not a number)，不是数字的数字，但仍然是数字类型

NaN是一个特殊值，它和自身不相等，是唯一一个非自反(自反，reflexive，即x === x不成立)的值。而 NaN != NaN 为 true，

```js
var a = 2 / "foo"; // NaN
typeof a === "number"; // true

var a = 2 / "foo";
a == NaN;   // false
a === NaN;  // false
```

ES6以后，可以用Number.isNaN()判断

```js
if (!Number.isNaN) {
    Number.isNaN = function(n) {
        return (typeof n === "number" && window.isNaN( n ));
    }
};
var a = 2 / "foo";
var b = "foo";
Number.isNaN( a ); // true
Number.isNaN( b );// false——好!

// 另一种更简单的方法
if (!Number.isNaN) {
    Number.isNaN = function(n) {
        return n !== n;
    };
}
```

 JavaScript 中Infinity(即 Number.POSITIVE_INfiNITY)表示无穷数

```js
var a = 1 / 0; // Infinity
var b = -1 / 0; // -Infinity
```

负零（-0）

加法和减法运算不会得到负零(negative zero)。

判断是否是负零

```js
function isNegZero(n) {
    n = Number( n );
    return (n === 0) && (1 / n === -Infinity);
}
isNegZero( -0 );// true
isNegZero( 0 / -3 );// true
isNegZero( 0 );// false
```

有些应用程序中的数据需要以级数形式来表示(比如动画帧的移动速度)，数字的符号位 (sign)用来代表其他信息(比如移动的方向)。
此时如果一个值为 0 的变量失去了它的符号位，它的方向信息就会丢失。所以保留 0 值的符号位可以防止这类情况发生。

#### 特殊等式

ES6 中新加入了一个工具方法 Object.is(..) 来判断两个值是否绝对相等。
仅用来判断NaN和-0等情况，能用===就不用这个

```js
var a = 2 / "foo";
var b = -3 * 0;

Object.is( a, NaN ); // true
Object.is( b, -0 );  // true

Object.is( b, 0 );  // false
```

polyfill

```js
if (!Object.is) {
    Object.is = function(v1, v2) {
        // test for `-0`
        if (v1 === 0 && v2 === 0) {
            return 1 / v1 === 1 / v2;
        }
        // test for `NaN`
        if (v1 !== v1) {
        return v2 !== v2;
        }
        // everything else
        return v1 === v2;
    };
}
```

### 值和引用

JS中，值复制还是引用复制，一切由值的类型来决定。

简单类型（null、undefined、字符串、数字、布尔和 ES6 中的 symbol）总是通过值复制方式来赋值/传递。

复合值(compound value)——对象(包括数组和封装对象)和函数，则总是通过引用复制的方式来赋值/传递。

```js
var a = 2;
var b = a; // `b` is always a copy of the value in `a`
b++;
a; // 2
b; // 3

var c = [1,2,3];
var d = c; // `d` is a reference to the shared `[1,2,3]` value
d.push( 4 );
c; // [1,2,3,4]
d; // [1,2,3,4]
```

函数传参的问题

```js
function foo(x) {
    x.push( 4 );
    x; // [1,2,3,4]
    // 这里x变成了一个新数组，a还是原来的
    x = [4,5,6];
    x.push( 7 );
    x; // [4,5,6,7]
}
var a = [1,2,3];
foo( a );
a; // [1,2,3,4]  not  [4,5,6,7]
```

将 a 的值变为 [4,5,6,7]，必须更改 x 指向的数组，而不是为 x 赋值一个新的数组。

```js
function foo(x) {
    x.push( 4 );
    x; // [1,2,3,4]

    // 这样做不会创建新数组
    x.length = 0; // empty existing array in-place
    x.push( 4, 5, 6, 7 );
    x; // [4,5,6,7]
}

var a = [1,2,3];

foo( a );

a; // [4,5,6,7]  not  [1,2,3,4]
```

如果通过值复制的方式来传递复合值(如数组)，就需要为其创建一个复本，这样传递的就不再是原始值。
`foo( a.slice() );` a.slice()返回的是数组的浅复本，foo的操作不会影响a指向的数组。
相反，如果要将标量基本类型值传递到函数内并进行更改，就需要将该值封装到一个复合值(对象、数组等)中，然后通过引用复制的方式传递。

```js
function foo(wrapper) {
    wrapper.a = 42;
}

var obj = {
    a: 2
};

foo( obj );

obj.a; // 42
```

## I-第3章 原生函数

```!
学习原生函数，封装对象包装，拆分。
```

常用的原生函数
• String()
• Number()
• Boolean()
• Array()
• Object()
• Function()
• RegExp()
• Date()
• Error()
• Symbol()

原生函数可以被当作构造函数来使用。通过构造函数(如new String("abc"))创建出来的是封装了基本类型值(如"abc")的封装对象。

```js
var a = new String( "abc" );
typeof a; // 是"object"，不是"String"
a instanceof String; // true
Object.prototype.toString.call( a ); // "[object String]"
```

### 内部属性class

所有 typeof 返回值为 "object" 的对象(如数组)都包含一个内部属性Class。这个属性无法直接访问，通过 `Object.prototype.toString(..)` 来查看。

```js
Object.prototype.toString.call( [1,2,3] ); // "[object Array]"
Object.prototype.toString.call( /regex-literal/i ); // "[object RegExp]"
Object.prototype.toString.call( null ); // "[object Null]"
Object.prototype.toString.call( undefined ); // "[object Undefined]"
Object.prototype.toString.call( "abc" ); // "[object String]"
Object.prototype.toString.call( 42 ); // "[object Number]"
Object.prototype.toString.call( true ); // "[object Boolean]"
```

### 封装对象包装

由于基本类型值没有`.length`和`.toString()`这样的属性和方法，需要通过封装对象才能访问。JS会自动为基本类型包装一个封装对象。

```js
var a = "abc";
a.length; // 3
a.toUpperCase(); // "ABC"
```

一般情况下，不需要直接使用封装对象。最好的办法是让 JavaScript 引擎自己决定什么时候应该使用封装对象。

如果要自行封装基本类型值，可以用Object()函数(不带new关键字)

```js
var a = "abc";
var b = new String( a );
var c = Object( a );

typeof a; // "string"
typeof b; // "object"
typeof c; // "object"

b instanceof String; // true
c instanceof String; // true

Object.prototype.toString.call( b ); // "[object String]"
Object.prototype.toString.call( c ); // "[object String]"
```

### 拆封

要拆封封装对象中的基本类型值，可以用valuesOf()函数。

```js
var a = new String( "abc" );
var b = new Number( 42 );
var c = new Boolean( true );

a.valueOf(); // "abc"
b.valueOf(); // 42
c.valueOf(); // true
```

在需要用到封装对象中的基本类型值的地方会发生隐式拆封。

```js
var a = new String( "abc" );
var b = a + ""; // b拥有了拆封后的值abc

typeof a; // "object"
typeof b; // "string"
```

### 原生函数作为构造函数

1. 数组

    永远不要创建和使用空单元数组。

    ```js
    var a = new Array( 3 );
    var b = [ undefined, undefined, undefined ];
    var c = [];
    c.length = 3;
    ```

2. Object(..)、Function(..) 和 RegExp(..)

    不建议使用Object和Function

    强烈建议使用常量形式(如 /^a*b+/g)来定义正则表达式，这样不仅语法简单，执行效率也更高，因为 JavaScript 引擎在代码执行前会对它们进行预编译和缓存。
    与前面的构造函数不同，RegExp(..) 有时还是很有用的，比如动态定义正则表达式时:

    ```js
    var name = "Kyle";
    var namePattern = new RegExp( "\\b(?:" + name + ")+\\b", "ig" );
    var matches = someText.match( namePattern );
    ```

    上述情况在JavaScript编程中时有发生，这时new RegExp("pattern","flags")就能派上用场。

3. Date(..) 和 Error(..)

    创建日期必须使用 `new Date()`。
    Date(..) 主要用来获得当前的 Unix 时间戳(从 1970 年 1 月 1 日开始计算，以秒为单位)。 该值可以通过日期对象中的 getTime() 来获得。

    用`Date.now()`即可获取

    创建错误对象(error object)主要是为了获得当前运行栈的上下文(大部分 JavaScript 引擎通过只读属性 .stack 来访问)。
    栈上下文信息包括函数调用栈信息和产生错误的代码行号， 以便于调试(debug)。

    ```js
    function foo(x) {
        if (!x) {
            throw new Error( "x wasn’t provided" );
        }
        // ..
    }
    ```

    通常错误对象至少包含一个 message 属性，有时也不乏其他属性(必须作为只读属性访问)，如 type。
    除了访问 stack 属性以外，最好的办法是调用toString() 来获得经过格式化的便于阅读的错误信息。

4. Symbol

    可以使用 Symbol(..) 原生构造函数来自定义符号。但它比较特殊，不能带 new 关键
    字，否则会出错:

    ```js
    var mysym = Symbol( "my own symbol" );
    mysym;    // Symbol(my own symbol)
    mysym.toString(); // "Symbol(my own symbol)"
    typeof mysym;   // "symbol"

    var a = { };
    a[mysym] = "foobar";

    Object.getOwnPropertySymbols( a );
    // [ Symbol(my own symbol) ]
    ```

5. 原生原型

    原生构造函数有自己的 .prototype 对象，如 Array.prototype、String.prototype 等。

    这些对象包含其对应子类型所特有的行为特征。

    Function.prototype 是一个空函数，RegExp.prototype 是一个“空”的正则表达式(无任何匹配)，而 Array.prototype 是一个空数组。对未赋值的变量来说，它们是很好的默认值。

    ```js
    function isThisCool(vals = Array.prototype,fn = Function.prototype,rx = RegExp.prototype) {
        return rx.test(
            vals.map( fn ).join( "" )
        );
    }

    isThisCool();  // true

    isThisCool(
        ["a","b","c"],
        function(v){ return v.toUpperCase(); },
        /D/
    );
    ```

    这种方法的一个好处是 .prototype 已被创建并且仅创建一次。相反，如果将 []、function(){} 和 /(?:)/ 作为默认值，
    则每次调用 isThisCool(..) 时它们都会被创建一次 (具体创建与否取决于 JavaScript 引擎，稍后它们可能会被垃圾回收)，这样无疑会造成内存和 CPU 资源的浪费。

## I-第4章 强制类型转换

值从一个类型转换为另一种类型，称为类型转换(type casting)。这是显示的情况，隐式的情况称为强制类型转换(coercion)。

类型转换发生在静态语言的编译阶段，强制类型转换发生在动态类型语言的运行时

在JS中统称为强制类型转换。可以通过隐式强制类型和强制类型转换来区分。

隐式类型转换不明显，通常是某些操作产生的副作用。

```js
var a = 42;
var b = a + ""; // 隐式强制类型转换
var c = String(a); // 显式强制类型转换
```

### 抽象值操作

#### ToString 非字符串到字符串强制类型转换

基本类型值的字符串化规则为:null 转换为 "null"，undefined 转换为 "undefined"，true 转换为 "true"。数字极大极小值用指数形式。
数组的toString默认将所有单元字符串化后用`,`连接。

```js
var a = [1,2,3]
a.toString(); // '1,2,3,'
```

#### JSON.stringify

(1) 字符串、数字、布尔值和 null 的 JSON.stringify(..) 规则与 ToString 基本相同。
(2) 如果传递给 JSON.stringify(..) 的对象中定义了 toJSON() 方法，那么该方法会在字符串化前调用，以便将对象转换为安全的 JSON 值。

JSON字符串化用`stringify`,遇到 undefined、function 和 symbol 时会自动将其忽略，在数组中则会返回 null。

```js
JSON.stringify( undefined );     // undefined
JSON.stringify( function(){} );     // undefined

JSON.stringify( [1,undefined,function(){},4] ); // "[1,null,null,4]"
JSON.stringify( { a:2, b:function(){} } );  // "{"a":2}"
```

包含循环引用的对象执行 JSON.stringify(..) 会出错。

如果要对含有非法 JSON 值的对象做字符串化，或者对象中的某些值无法被序列化时，需要定义 toJSON() 方法来返回一个能够被字符串化的安全的 JSON 值。

```js
var o = { };

var a = {
    b: 42,
    c: o,
    d: function(){}
};

// a被循环引用
o.e = a;

// 由于循环引用，会抛出异常
// JSON.stringify( a );

// define a custom JSON value serialization
a.toJSON = function() {
    // only include the `b` property for serialization
    return { b: this.b };
};

JSON.stringify( a ); // "{"b":42}"
```

向 `JSON.stringify(..)` 传递一个可选参数 replacer，可以是数组或者函数，用来指定对象序列化过程中哪些属性应该被处理，哪些应该被排除。
如果 replacer 是一个数组，那么它必须是一个字符串数组，其中包含序列化要处理的对象的属性名称，除此之外其他的属性则被忽略。
如果 replacer 是一个函数，它会对对象本身调用一次，然后对对象中的每个属性各调用一次，每次传递两个参数，键和值。如果要忽略某个键就返回 undefined，否则返回指定的值。

```js
var a = {
    b: 42,
    c: "42",
    d: [1,2,3]
};

JSON.stringify( a, ["b","c"] ); // "{"b":42,"c":"42"}"

JSON.stringify( a, function(k,v){
    if (k !== "c") return v;
});
// "{"b":42,"d":[1,2,3]}"
```

#### ToNumber

true 转换为 1，false 转换为 0。undefined 转换为 NaN，null 转换为 0。

对象(包括数组)会首先被转换为相应的基本类型值，如果返回的是非数字的基本类型值，则再遵循以上规则将其强制转换为数字。

#### ToBoolean

1. 假值(false value) 可以被强制类型转换为 false 的值。

   - undefined
   - null
   - false
   - +0, -0, NaN
   - ''

2. 假值对象

    ```js
    var a = new Boolean( false );
    var b = new Number( 0 );
    var c = new String( "" );
    ```

    a, b, c都为true

3. 真值

```js
var a = "false";
var b = "0";
var c = "''";
var d = Boolean( a && b && c );
d; // 字符串不为空所以为true

var a = [];
var b = {};
var c = function(){};
var d = Boolean( a && b && c );
d; // [], {}, function(){} 不为空，为true
```

### 显式强制类型转换

代码转换清晰，可读性高，更容易理解，推荐使用。

1. 字符串数字互转

    ```js
    var a = 42;
    var b = String( a );
    b; // "42"
    var c = "3.14";
    var d = Number( c );
    d; // 3.14

    var c = "3.14";
    var d = +c; // 最常用~~~
    d; // 3.14

    ```

2. 奇特的~运算符

    字位运算符(如 | 和 ~)和某些特殊数字一起使用时会产生类似强制类型转换的效果，返回另外一个数字。

在 -(x+1) 中唯一能够得到 0(或者严格说是 -0)的 x 值是 -1。也就是说如果 x 为 -1 时，~和一些数字值在一起会返回假值 0，其他情况则返回真值。

`indexOf`搜索到指定字符串返回字符串所在位置(从0开始)，否则返回-1。

```js
var a = "Hello World";

if (a.indexOf( "lo" ) >= 0) { // true
 // found it!
}
if (a.indexOf( "lo" ) != -1) { // true
 // found it
}

if (a.indexOf( "ol" ) < 0) { // true
 // not found!
}
if (a.indexOf( "ol" ) == -1) { // true
 // not found!
}

~a.indexOf( "lo" );   // -4   <-- truthy!

if (~a.indexOf( "lo" )) { // true
 // found it!
}

~a.indexOf( "ol" );   // 0    <-- falsy!
!~a.indexOf( "ol" );  // true

if (!~a.indexOf( "ol" )) { // true
 // not found!
}
```

`>= 0`和`== -1`这样的写法不是很好，称为“抽象渗漏”，在代码中暴露了底层的实现细节，这里是指用 -1 作为失败时的返回值，这些细节应该被屏蔽掉。
**`~` 和 `indexOf()` 一起可以将结果强制类型转换(实际上仅仅是转换)为真 / 假值**

这种写法看起来逼格也高，哈哈

`~~`中的第一个 ~ 执行 ToInt32 并反转字位，然后第二个 ~ 再进行一次字位反转，即将所有字位反转回原值，最后得到的仍然是 ToInt32 的结果。

只适用于 32 位数字，更重要的是它对负数的处理与 Math. floor(..) 不同。

```js
Math.floor( -49.6 ); // -50
~~-49.6; // -49
```

### 显式解析数字字符串

解析(parseInt)允许字符串中含有非数字字符，解析按从左到右的顺序，如果遇到非数字字符就停止。字符串转数字(Number)不允许出现非数字字符，否则会失败并返回 NaN。

```js
var a = "42";
var b = "42px";

Number( a ); // 42
parseInt( a ); // 42

Number( b ); // NaN
parseInt( b ); // 42
```

parseInt(..) 针对的是字符串值。向 parseInt(..) 传递其他类型的参数，比如 `true、function(){...}` 和 `[1,2,3]`。
会首先被强制类型转换为字符串，依赖这样的隐式强制类型转换并非上策，应该避免向 parseInt(..) 传递非字符串参数。

parseInt(..) 先将参数强制类型转换为字符串再进行解析。

```js
parseInt( 1/0, 19 ); // 18
```

怎么来处理 Infinity(1/0 的结果)最合理呢?有两个选择:"Infinity" 和 "∞"，JavaScript选择的是 "Infinity"。

parseInt(1/0, 19) 实际上是 parseInt("Infinity", 19)。第一个字符是 "I"，以 19 为基数 时值为 18。第二个字符 "n" 不是一个有效的数字字符，解析到此为止，和 "42px" 中的 "p" 一样。

最后的结果是 18，而非 Infinity 或者报错。所以理解其中的工作原理对于我们学习 JavaScript 是非常重要的。

```js
parseInt( 0.000008 );  // 0   ("0" from "0.000008")
parseInt( 0.0000008 );  // 8   ("8" from "8e-7")
parseInt( false, 16 );  // 250 ("fa" from "false")
parseInt( parseInt, 16 ); // 15  ("f" from "function..")

parseInt( "0x10" );   // 16
parseInt( "103", 2 );  // 2
```

### 显示转换为布尔值

显式强制类型转换为布尔值最常用的方法`!!`，第二个`!`会把结果反转回原值

```js
var a = "0";
var b = [];
var c = {};

var d = "";
var e = 0;
var f = null;
var g;

Boolean( a ); // true
Boolean( b ); // true
Boolean( c ); // true

Boolean( d ); // false
Boolean( e ); // false
Boolean( f ); // false
Boolean( g ); // false

!!a; // true
!!b; // true
!!c; // true

!!d; // false
!!e; // false
!!f; // false
!!g; // false
```

三元运算符 `? :` 判断 a 是否为真，如果是则将变量 b 赋值为 true，否则赋值为 false。 表面上这是一个显式的 ToBoolean 强制类型转换，因为返回结果是 true 或者 false。
然而这里涉及隐式强制类型转换，因为 a 要首先被强制类型转换为布尔值才能进行条件判断。这种情况称为“显式的隐式”，有百害而无一益，我们应彻底杜绝。
建议使用 Boolean(a) 和 !!a 来进行显式强制类型转换。

### 隐式强制类型转换

不够明显的强制类型转换都可以算作隐式强制类型转换。

隐式强制类型转换的作用是减少冗余，让代码更简洁。可能会让代码晦涩难懂。

`+`既能用于字符串也能用于数字。怎么判断要执行哪个操作？

```js
var a = "42";
var b = "0";

var c = 42;
var d = 0;

a + b; // "420"
c + d; // 42

var a = [1,2];
var b = [3,4];
a + b; // "1,23,4"

// 将数字转成字符串
var a = 42;
var b = a + "";
b; // "42"
```

如果其中一个操作数是对象(包括数组)，则首先对其调用 ToPrimitive 抽象操作，该抽象操作再调用DefaultValue，以数字作为上下文。
数组的 valueOf() 操作无法得到简单基本类型值，于是它转而调用 toString()。因此上例中的两个数组变成了 "1,2" 和 "3,4"。+ 将它们拼接后返回 "1,23,4"。

如果 + 的其中一个操作数是字符串(或者通过以上步骤可以得到字符串)， 则执行字符串拼接;否则执行数字加法。

a + ""(隐式)和前面的String(a)(显式)之间有一个细微的差别需要注意。
根据 ToPrimitive抽象操作规则，a + ""会对a调用valueOf()方法，然后通过ToString抽象 操作将返回值转换为字符串。而 String(a) 则是直接调用 ToString()。

如果a是对象，结果会不一样。

```js
var a = {
    valueOf: function() { return 42; },
    toString: function() { return 4; }
};

a + "";   // "42"

String( a ); // "4
```

在定制 valueOf() 和 toString() 方法时需要特别小心，因为这会影响强制类型转换的结果。

`-`减法运算符，会先转换为字符串，再转换为数字

```js
var a = "3.14";
var b = a - 0;

b; // 3.14

var a = [3];
var b = [1];
a - b; // 2
```

### 布尔值到数字的隐式强制类型转换

```js
var sum = 0
arr = [true, false, true]
arr.reduce(item=> {
    sum +=item
}, sum)
```

在控制台显示是NaN？？？和书里不一样

### 隐式强制类型转换为布尔值

(1)if (..)语句中的条件判断表达式。
(2)for ( .. ; .. ; .. )语句中的条件判断表达式(第二个)。
(3) while (..) 和 do..while(..) 循环中的条件判断表达式。
(4)? :中的条件判断表达式。
(5) 逻辑运算符 ||(逻辑或)和 &&(逻辑与)左边的操作数(作为条件判断表达式)。

以上情况中，非布尔值会被隐式强制类型转换为布尔值，遵循前面介绍过的 ToBoolean 抽象操作规则。

```js
var a = 42;
var b = "abc";
var c;
var d = null;

if (a) {
 console.log( "yep" );  // yep
}

while (c) {
 console.log( "nope, never runs" );
}

c = d ? a : b;
c;     // "abc"

if ((a && d) || c) {
 console.log( "yep" );  // yep
}
```

### || 和 &&

JS中返回的不一定布尔值。而是两个操作数中的一个的值。

```js
var a = 42;
var b = "abc";
var c = null;

a || b;  // 42
a && b;  // "abc"

c || b;  // "abc"
c && b;  // null
```

|| 和 && 首先会对第一个操作数(a 和 c)执行条件判断，如果其不是布尔值就先进行 ToBoolean 强制类型转换，然后再执行条件判断。

对于 || 来说，如果条件判断结果为 true 就返回第一个操作数(a 和 c)的值，如果为 false 就返回第二个操作数(b)的值。
&& 则相反，如果条件判断结果为 true 就返回第二个操作数(b)的值，如果为 false 就返回第一个操作数(a 和 c)的值。

换个角度理解

```js
a || b;
// 相当于
a ? a : b;

a && b;
// 相当于
a ? b : a;

// 同三元表达式不同的是, 如果a是表达式，可能会执行两次。
```

#### 常见用法

设置默认值

```js
function foo(a,b) {
 a = a || "hello";
 b = b || "world";

 console.log( a + " " + b );
}

foo();     // "hello world"
foo( "yeah", "yeah!" ); // "yeah yeah!"
```

短路机制

a为false时，foo不会执行。比`if (a) { foo() }`简洁明了

```js
function foo() {
    console.log( a );
}

var a = 42;

a && foo(); // 42
```

### 宽松相等和严格相等

**`==`允许在相等比较中进行强制类型转换，而`===`不允许。**

人觉得 == 会比 === 慢，实际上虽然强制类型转换确实要多花点时间，但仅仅是微秒级 (百万分之一秒)的差别而已。
如果进行比较的两个值类型相同，则 == 和 === 使用相同的算法，所以除了 JavaScript 引擎 实现上的细微差别之外，它们之间并没有什么不同。

#### 抽象相等

规定如果两个值的类型相同，就仅比较它们是否相等。例如，42 等于 42，"abc" 等于 "abc"。

特殊情况 NaN 不等于 NaN，+0 等于 -0。

以 x 和 y 为值进行 x == y 比较会产生的结果可为 true 或 false。比较的执行步骤如下：

1. 若 Type(x) 与 Type(y) 相同， 则
    1. 若 Type(x) 为 Undefined， 返回 true。
    2. 若 Type(x)为 Null， 返回 true。
    3. 若 Type(x)为 Number，则
        1. 若 x 为 NaN，返回 false。
        2. 若 y 为 NaN，返回 false。
        3. 若 x 与 y 为相等数值，返回 true。
        4. 若 x 为 +0 且 y 为 −0，返回 true。
        5. 若 x 为 −0 且 y 为 +0，返回 true。
        6. 返回 false。
    4. 若 Type(x) 为 String，则当 x 和 y 为完全相同的字符序列（长度相等且相同字符在相同位置）时返回 true。否则，返回 false。
    5. 若 Type(x) 为 Boolean，当 x 和 y 为同为 true 或者同为 false 时返回 true。否则，返回 false。
    6. 当 x 和 y 为引用同一对象时返回 true。否则，返回 false。
2. 若 x 为 null 且 y 为 undefined，返回 true。
3. 若 x 为 undefined 且 y 为 null，返回 true。
4. 若 Type(x) 为 Number 且 Type(y) 为 String，返回 x == ToNumber(y) 的结果。
5. 若 Type(x) 为 String 且 Type(y) 为 Number，返回比较 ToNumber(x) == y 的结果。
6. 若 Type(x) 为 Boolean，返回比较 ToNumber(x) == y 的结果。
7. 若 Type(y) 为 Boolean，返回比较 x == ToNumber(y) 的结果。
8. 若 Type(x) 为 String 或 Number，且 Type(y) 为 Object，返回比较 x == ToPrimitive(y) 的结果。
9. 若 Type(x) 为 Object 且 Type(y) 为 String 或 Number，返回比较 ToPrimitive(x) == y 的结果。
10. 返回 false。

```js
var a = 42;
var b = "42";
a === b; // false
a == b;  // true

var a = "42";
var b = true;
a == b; // false 1==42

var x = "42";
var y = false;
x == y; // false 42==0

var a = 42;
var b = [ 42 ];
a == b; // true 42==42

var a = "abc";
var b = Object( a ); // same as `new String( a )`
a === b;    // false
a == b;     // true

var a = null;
var b = Object( a ); // same as `Object()`
a == b;     // false

var c = undefined;
var d = Object( c ); // same as `Object()`
c == d;     // false

var e = NaN;
var f = Object( e ); // same as `new Number( e )`
e == f;     // false
```

无论什么情况下都不要使用 == true 和 == false。

```js
var a = "42";

// 会失败
if (a == true) {
 // ..
}

// 也会失败
if (a === true) {
 // ..
}

// 没问题
if (a) {
 // ..
}

// 更好
if (!!a) {
 // ..
}

// 也很好
if (Boolean( a )) {
 // ..
}
```

#### 其他情况

更改内置原生原型会导致奇怪效果

```js
Number.prototype.valueOf = function() {
 return 3;
};

new Number( 2 ) == 3; // true，因为valueOf返回3

// 这种情况也会发生，如下
if (a == 2 && a == 3) {
 // ..
}

var i = 2;
// 让 a.valueOf() 每次调用都产生副作用，第一次返回 2，第二次返回 3
Number.prototype.valueOf = function() {
 return i++;
};

var a = new Number( 42 );

if (a == 2 && a == 3) {
 console.log( "Yep, this happened." );
}
```

```js
"0" == null;   // false
"0" == undefined;  // false
"0" == false;   // true -- UH OH!
"0" == NaN;    // false
"0" == 0;    // true
"0" == "";    // false

false == null;   // false
false == undefined;  // false
false == NaN;   // false
false == 0;    // true -- UH OH!
false == "";   // true -- UH OH!
false == [];   // true -- UH OH!
false == {};   // false

"" == null;    // false
"" == undefined;  // false
"" == NaN;    // false
"" == 0;    // true -- UH OH!
"" == [];    // true -- UH OH!
"" == {};    // false

0 == null;    // false
0 == undefined;   // false
0 == NaN;    // false
0 == [];    // true -- UH OH!
0 == {};    // false
```

有 7 种注释了“UH OH!”，因为它们属于假阳(false positive)的情况，里面坑很多。 "" 和 0 明显是两个不同的值，它们之间的强制类型转换很容易搞错。

```js

[] == ![] // true,根据toBoolean变成[]==false
2 == [2];  // true
"" == [null]; // true
0 == "\n"; // true
```

，== 右边的值 `[2]` 和 `[null]` 会进行 ToPrimitive 强制类型转换， 以便能够和左边的基本类型值(2 和 "")进行比较。因为数组的 valueOf() 返回数组本身， 所以强制类型转换过程中数组会进行字符串化。
第一行中的 `[2]` 会转换为 `"2"`，然后通过 ToNumber 转换为 2。第二行中的 `[null]` 会直接转 换为 ""。
所以最后的结果就是 `2 == 2` 和 `"" == ""`。

安全运用隐式强制转换，遵循以下两个原则：

- 如果两边的值中有 true 或者 false，千万不要使用 ==。
- 如果两边的值中有 []、"" 或者 0，尽量不要使用 ==。

**最好用 === 来避免不经意的强制类型转换。这两个原则可以让我们避开几乎所有强制类型转换的坑。**

### 抽象关系比较

比较双方首先调用 ToPrimitive，如果结果出现非字符串，就根据 ToNumber 规则将双方强制类型转换为数字来进行比较。

如果比较双方都是字符串，则按字母顺序来进行比较:

```js
var a = [ 42 ];
var b = [ "43" ];

a < b; // true  42<43
b < a; // false

var a = [ "42" ];
var b = [ "043" ];

a < b; // false  字符串，"42" < "043" 4>0

var a = [ 4, 2 ];
var b = [ 0, 4, 3 ];
a < b; // false '4,2' < '0,4,3'

var a = { b: 42 };
var b = { b: 43 };
a < b; // false '[object Object]' < '[object Object]'


// 以下很奇怪
var a = { b: 42 };
var b = { b: 43 };

a < b; // false
a == b; // false
a > b; // false

a <= b; // true
a >= b; // true
```

JS中 `<=` 是“不大于”的意思(即 !(a > b)，处理为 !(b < a))。同理 a >= b 处理为 !(a<b)。

要避免a < b中发生隐式强制类型转换，我们只能确保a和b为相同的类型， 除此之外别无他法。

为了保证安全，应该对关系比较中的值进行显式强制类型转换

```js
var a = [ 42 ];
var b = "043";

a < b;      // false -- string comparison!
Number( a ) < Number( b ); // true -- number comparison!
```

### 小结类型转换

了解显示隐式转换

一般编码规范的项目都会要求强制类型转换

再加上用了TS之后，要求更高了。

不过还是要知其然，更要知其所以然。
