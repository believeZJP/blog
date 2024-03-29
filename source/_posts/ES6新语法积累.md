---
title: ES6新语法积累
date: 2018-11-05 19:48:55
updated: 2018-11-05 19:48:55
tags: [[es6]]
categories: es6
---
[TOC]

## es6强制让一个函数有一个参数

```js
if (!a) {
    throw Error('cuowu')
}
```

## 装饰器

## Promise

[Promise迷你书](http://liubin.org/promises-book/)

<!-- more -->

## js中Map和Set区别

Set 对象类似于数组，且成员的值都是唯一的

Map 对象是键值对集合，和 JSON 对象类似，但是 key 不仅可以是字符串还可以是对象

set中存储无序并且不可重复的元素。
map存储的是键值对。key=>VALUE

由于一个key只能对应一个value，所以，多次对一个key放入value，后面的值会把前面的值冲掉：

Map：键值对集合，对应于 Object，ES6 中map的key 可以是对象
List：有序可重复的列表，对应于 Array
Set：无序且不可重复的列表

```javascript
const arr = [1, 2, 3, 4, 5, 5, 4, 3, 2, 1]
const set = new Set()
arr.forEach(item => set.add(item))
console.log(set) // 1, 2, 3, 4, 5


var s1 = new Set(); // 空Set
var s2 = new Set([1, 2, 3]); // 含1, 2, 3

重复元素在Set中自动被过滤：

var s = new Set([1, 2, 3, 3, '3']);
s; // Set {1, 2, 3, "3"}
注意数字3和字符串'3'是不同的元素。

通过add(key)方法可以添加元素到Set中，可以重复添加，但不会有效果：

s.add(4);
s; // Set {1, 2, 3, 4}
s.add(4);
s; // 仍然是 Set {1, 2, 3, 4}

// 数组快速去重
console.log([...new Set(arr)])


var map = new Map()
var obj = { name: '小缘', age: 14 }

map.set(obj, '小缘喵')
map.get(obj) // 小缘喵

map.has(obj) // true
map.delete(obj) // true
map.has(obj) // false

```

## 模版字符串

使用${variable}插入变量

```js
var fName = 'Peter', sName = 'Smith', age = 43, job = 'photographer';
var a = 'Hi, I\'m ' + fName + ' ' + sName + ', I\'m ' + age + ' and work as a ' + job + '.';
var b = `Hi, I'm ${ fName } ${ sName }, I'm ${ age } and work as a ${ job }.`;
```

## 块级作用域 let const

JavaScript 本身一直是函数式作用域，这就是我们经常将整个 JavaScript 文件封装在一个空的立即调用函数表达式（IIFE）中的原因。这样做是为了隔离文件中的所有变量，因此全局中就不会存在变量名冲突。

ES5 中如果你想限制变量 tmp 的作用范围仅在某一块代码中有效，你不得不使用一个叫 IIFE(Immediately-Invoked Function Expression，立即执行函数表达式) 的模式：

```js
(function () {  // IIFE 开始
    var tmp = ···;
    ···
}());  // IIFE 结束
console.log(tmp); // ReferenceError
// ECMAScript 6 中可以简单地使用块和 let 申明(或 const 申明)：
{
    // 块起始
    let tmp = ···;
    ···
}  // 块结束
console.log(tmp); // ReferenceError

```

## var
1. 声明提升=> 先上车后买票
2. 变量覆盖 =>套牌车
3. 没有块级作用域 => 红杏出墙

## let

let 声明的变量具有块级作用域，所以可以在不影响外部变量的情况下声明具有相同名称的新局部（内部）变量。
==同一个块级作用域不能申明同一个变量==

```js
var a = 'car' ;
{
    let a = 5;
    console.log(a) // 5
    let a = 6 // Identifier 'a' has already been declared
}
console.log(a) // car
```

var和let之间的另一个区别是let不会像var一样被提升。

```js
{
    console.log(a); // undefined
    console.log(b); // ReferenceError
    var a = 'car';
    let b = 5;
}
```

经典面试题  

```js
for (var i = 1; i < 5; i++) {
    setTimeout(() => { console.log(i); }, 1000);
}
```

## Const

JavaScript 中声明一个常量变量，那么惯例是将变量命名大写。然而，这并不能保证它是一个常量 - 它只是让其他开发人员知道这是一个常量，不应该改变。

1. const声明之后必须赋值，否则报错
2. 定义的值不能修改，否则报错
3. 支持let的其他属性

==**const 不会使变量不可变，只是锁定它的赋值。 如果你有一个复杂的赋值（对象或数组），那么该值仍然可以修改。**==

```js
{
    const c = "tree";
    console.log(c);  // tree
    c = 46;  // TypeError!
}


{
    const d = [1, 2, 3, 4];
    const dave = { name: 'David Jones', age: 32};
    d.push(5);
    dave.job = "salesman";
    console.log(d);  // [1, 2, 3, 4, 5]
    console.log(dave);  // { age: 32, job: "salesman", name: 'David Jones'}

    // 上面的方式给const赋值不报错，

    直接给const赋值，报错。
    dave = {name: 'salesman'}   //  Assignment to constant variable.

}
```

### 块级作用域函数问题

```js
函数声明现在被指定为必须绑定到块级作用域。

{
    bar(); // works
    function bar() { /* do something */ }
}
bar();  // doesn't work


if ( something) {
    function baz() { console.log('I passed') }
} else {
    function baz() { console.log('I didn\'t pass') }
}
baz();
在 ES6 之前，这两个函数声明都会被提升，\
结果就是 ‘I didn\’t pass’，不管something 是什么东西。

现在我们会得到 ‘ReferenceError’，因为baz()总是受到块范围的约束。
```

建议：

- 首选 const。所有不会改变值的变量都可以使用它。
- 其它的使用 let，用于值会被改变的变量。
- 避免使用 var。

## 扩展运算符

...运算符，它被称为“扩展运算符”。

它有两个主要用途：将数组或对象分散到新的数组或对象中，并将多个参数合并到一个数组中。

... 运算符的另一个特点是它创建一个新的数组或对象。

将变量一起收集到一个数组中。 当你不知道有多少变量传递给函数时，这非常有用。

```javascript
let a = [3, 4, 5];
let b = [1, 2, ...a, 6];
console.log(b);  // [1, 2, 3, 4, 5, 6]

let car = { type: 'vehicle ', wheels: 4};
let fordGt = { make: 'Ford', ...car, model: 'GT'};
console.log(fordGt); // {make: 'Ford', model: 'GT', type: 'vehicle', wheels: 4}

let a = [1, 2, 3];
let b = [ ...a ];
let c = a;
b.push(4);
console.log(a);  // [1, 2, 3]
console.log(b);  // [1, 2, 3, 4] referencing different arrays
c.push(5);
console.log(a);  // [1, 2, 3, 5]
console.log(c);  // [1, 2, 3, 5] referencing the same array

function foo(...args) {
    console.log(args);
}
foo( 'car', 54, 'tree');  //  [ 'car', 54, 'tree' ]

```

## 函数默认参数

以使用默认参数定义函数。缺少或未定义的值将使用默认值进行初始化。只要小心 - 因为空值和假值会被强制为0。

默认值可以不仅仅是值 - 它们也可以是表达式或函数。

```javascript
function foo( a = 5, b = 10) {
    console.log( a + b);
}
foo();  // 15
foo( 7, 12 );  // 19
foo( undefined, 8 ); // 13
foo( 8 ); // 18
foo( null ); // 10 as null is coerced to 0

// 默认值为函数
function foo( a ) { return a * 4; }
function bar( x = 2, y = x + 4, z = foo(x)) {
    console.log([ x, y, z ]);
}
bar();  // [ 2, 6, 8 ]
bar( 1, 2, 3 ); //[ 1, 2, 3 ]
bar( 10, undefined, 3 );  // [ 10, 14, 3 ]

```

## 解构

解构是拆分等号左侧的数组或对象的过程。数组或对象可以来自变量，函数或等式。

有时，你想取值，将它们分配给一个新的变量。 这是通过在等号左边的 key: variable 配对完成的。

对象解构允许的另一件事是为多个变量赋值。

```javascript
let [ a, b, c ] = [ 6, 2, 9];
console.log(`a=${a}, b=${b}, c=${c}`); //a=6, b=2, c=9
function foo() { return ['car', 'dog', 6 ]; }
let [ x, y, z ] = foo();
console.log(`x=${x}, y=${y}, z=${z}`);  // x=car, y=dog, z=6


function baz() {
    return {
        x: 'car',
        y: 'London',
        z: { name: 'John', age: 21}
    };
}
let { x: vehicle, y: city, z: { name: driver } } = baz();
console.log(
    `I'm going to ${city} with ${driver} in their ${vehicle}.`
); // I'm going to London with John in their car.

let { x: first, x: second } = { x: 4 };
console.log( first, second ); // 4, 4
```

## 对象字面量和简明参数

当您从变量创建对象字面量时，ES6 允许您在与 key 与变量名称相同的情况下省略 key 名。

```js
let a = 4, b = 7;
let c = { a: a, b: b };
let concise = { a, b };
console.log(c, concise) // {a: 4, b: 7}, {a: 4, b: 7}
```

## 动态属性名称

使用动态分配的 key 创建或添加属性的功能。

```js
let  city= 'sheffield_';
let a = {
    [ city + 'population' ]: 350000
};
a[ city + 'county' ] = 'South Yorkshire';
console.log(a); // {sheffield_population: 350000, sheffield_county: 'South Yorkshire' }
```

## 箭头函数

箭头函数有两个主要方面：结构和this绑定。

不需要功能关键字，并且它们自动返回箭头之后的任何内容。

如果函数需要的不仅仅是一个简单的计算，可以使用大括号，并且该函数会返回花括号块范围返回的任何内容。

对于箭头函数最有用的地方之一是在map()，forEach()或sort()之类的数组函数中。

```js
var foo = function( a, b ) {
    return a * b;
}
let bar = ( a, b ) => a * b;
```

## 数字字面量

ES5 代码很好地处理了十进制和十六进制数字格式，但未指定八进制格式。事实上，它在严格的模式下被禁止。

ES6添加了一种新格式，在最初的 0 之后添加一个 o （注意是字母）以将该数字声明为八进制数。ES6 还添加了二进制格式。

```js
Number( 29 )  // 29
Number( 035 ) // 35 in old octal form.
Number( 0o35 ) // 29 in new octal form
Number( 0x1d ) // 29 in hexadecimal
Number( 0b11101 ) // 29 in binary form
```

## class继承和function继承的区别

```js
class Super {}
class Sub extends Super {}

const sub = new Sub();

Sub.__proto__ === Super;
```

子类可以直接通过 __proto__ 寻址到父类。

```js
function Super() {}
function Sub() {}

Sub.prototype = new Super();
Sub.prototype.constructor = Sub;

var sub = new Sub();

Sub.__proto__ === Function.prototype;
```

而通过 ES5 的方式，`Sub.__proto__ === Function.prototype`

## 静态方法（Static Methods）

在类中，我们可以使用static关键字来声明静态方法。类的实例无法访问静态方法，因为声明静态方法的类属于类对象（class object）。

```js
class Repo{
  static getName() {
    return "Repo name is modern-js-cheatsheet"
  }
}

// Note that we did not have to create an instance of the Repo class
console.log(Repo.getName()) // Repo name is modern-js-cheatsheet

let r = new Repo();
console.log(r.getName()) // Uncaught TypeError: repo.getName is not a function
```

通过使用this关键字，静态方法可以调用另一个静态方法，但这不适用于非静态方法（non-static methods）。非静态方法不能直接使用this关键词访问静态方法。

### 静态方法调用另一个静态方法

要想静态方法调用另一个静态方法，可以这样使用this关键字;

```js
class Repo{
  static getName() {
    return "Repo name is modern-js-cheatsheet"
  }

  static modifyName(){
    return this.getName() + '-added-this'
  }
}

console.log(Repo.modifyName()) // Repo name is modern-js-cheatsheet-added-this
```

#### 非静态方法调用静态方法

非静态方法可以通过这两种方式调用静态方法;

1. 使用类名称。

为了在非静态方法里访问静态方法，我们使用类名称（class name）并像属性一样调用静态方法。例如ClassName.StaticMethodName

```javascript
class Repo{
  static getName() {
    return "Repo name is modern-js-cheatsheet"
  }

  useName(){
    return Repo.getName() + ' and it contains some really important stuff'
  }
}

// we need to instantiate the class to use non-static methods
let r = new Repo()
console.log(r.useName()) // Repo name is modern-js-cheatsheet and it contains some really important stuff

```

2. 使用构造函数

静态方法可以作为构造函数对象（constructor object）的属性来调用。

```javascript
class Repo{
  static getName() {
    return "Repo name is modern-js-cheatsheet"
  }

  useName(){
    // Calls the static method as a property of the constructor
    return this.constructor.getName() + ' and it contains some really important stuff'
  }
}

// we need to instantiate the class to use non-static methods
let r = new Repo()
console.log(r.useName()) // Repo name is modern-js-cheatsheet and it contains some really important stuff
```

## 新对象替换老对象

```js
state.obj = {...state.obj, newProp: 123}

oldObj = Object.assign({}, newObj)

oldObj = JSON.parse(JSON.stringify(newObj))
```

## 在对象上添加新属性

```js
Vue.set(obj, 'newProp', 123)
```

## let

```js
var a = [];
for(let i=0;i<10;i++){
    a[i] = function(){
        console.log(i);
    }
}
a[6]();
```

 不存在变量提升

```js
// var 的情况
console.log(foo); // 输出undefined
var foo = 2;

// let 的情况
console.log(bar); // 报错ReferenceError
let bar = 2;
```

不允许重复声明
不能在函数内部重新声明参数

```js
    function func(arg) {
        let arg; // 报错
    }

    function func(arg) {
      {
        let arg; // 不报错
      }
    }
```  

块级作用域的不合理场景

1. 内层变量可能会覆盖外层变量。

```js
    var tmp = new Date();
    function f() {
      console.log(tmp);
      if (false) {
        var tmp = 'hello world';
      }
    }

    f(); // undefined
```

2. 用来计数的循环变量泄露为全局变量
    循环结束后，i并没有消失，泄露成了全局变量。

块级作用域：
    可以任意嵌套
    块级作用域的出现，实际上使得获得广泛应用的立即执行函数表达式（IIFE）不再必要了。

```js
    // IIFE 写法
    (function () {
      var tmp = ...;
      ...
    }());

    // 块级作用域写法
    {
      let tmp = ...;
      ...
    }
```

避免在块级作用域内声明函数。如果确实需要，也应该写成函数表达式，而不是函数声明语句。

```js
    // 函数声明语句
    {
      let a = 'secret';
      function f() {
        return a;
      }
    }

    // 函数表达式
    {
      let a = 'secret';
      let f = function () {
        return a;
      };
    }
```

ES6 的块级作用域允许声明函数的规则，只在使用大括号的情况下成立，如果没有使用大括号，就会报错。

```js
    // 不报错
    'use strict';
    if (true) {
      function f() {}
    }

    // 报错
    'use strict';
    if (true)
      function f() {}
```

## const

声明一个只读的常量。一旦声明，常量的值就不能改变。

1. 改变常量的值会报错。

    const PI = 3.1415;
    PI // 3.1415

    PI = 3;
    // TypeError: Assignment to constant variable.
2. 只声明不赋值，报错

    const foo;
    // SyntaxError: Missing initializer in const declaration

3. 作用域与let命令相同：只在声明所在的块级作用域内有效。

    if (true) {
      const MAX = 5;
    }

    MAX // Uncaught ReferenceError: MAX is not defined
4. 声明的常量也是不提升，同样存在暂时性死区，只能在声明的位置后面使用。

    if (true) {
      console.log(MAX); // ReferenceError
      const MAX = 5;
    }
5. 声明的常量，也与let一样不可重复声明。

    let age = 25;
    var message = "Hello!";

    // 以下两行都会报错
    const message = "Goodbye!";
    const age = 30;

## 本质

const实际上保证的，并不是变量的值不得改动，而是变量指向的那个内存地址不得改动。对于简单类型的数据（数值、字符串、布尔值），值就保存在变量指向的那个内存地址，因此等同于常量。但对于复合类型的数据（主要是对象和数组），变量指向的内存地址，保存的只是一个指针，const只能保证这个指针是固定的，至于它指向的数据结构是不是可变的，就完全不能控制了。因此，将一个对象声明为常量必须非常小心。

```js
    const foo = {};

    // 为 foo 添加一个属性，可以成功
    foo.prop = 123;
    foo.prop // 123

    // 将 foo 指向另一个对象，就会报错
    foo = {}; // TypeError: "foo" is read-only

    const a = [];
    a.push('Hello'); // 可执行
    a.length = 0;    // 可执行
    a = ['Dave'];    // 报错
```

ES6 声明变量的六种方法
var命令和function命令，let和const命令，import命令和class命令。

***
顶层对象的属性与全局变量挂钩，被认为是JavaScript语言最大的设计败笔之一。这样的设计带来了几个很大的问题，首先是没法在编译时就报出变量未声明的错误，只有运行时才能知道（因为全局变量可能是顶层对象的属性创造的，而属性的创造是动态的）；其次，程序员很容易不知不觉地就创建了全局变量（比如打字出错）；最后，顶层对象的属性是到处可以读写的，这非常不利于模块化编程。另一方面，window对象有实体含义，指的是浏览器的窗口对象，顶层对象是一个有实体含义的对象，也是不合适的。

ES6为了改变这一点，一方面规定，为了保持兼容性，var命令和function命令声明的全局变量，依旧是顶层对象的属性；另一方面规定，let命令、const命令、class命令声明的全局变量，不属于顶层对象的属性。也就是说，从ES6开始，全局变量将逐步与顶层对象的属性脱钩。
***
