---
title: 'JavaScript:for-of到generator'
date: 2019-01-21 16:14:43
updated: 2019-01-21 16:14:43
tags:
- JavaScript
- es6
- for of
- generator
- iterator

---

# for of

在`JavaScript`中, 循环数组可以通过`map, filter, for of` 等来遍历一个数组.

为什么for of 可以遍历数组或类数组对象(`String, Maps, Sets, arguments`)？
为什么不能用来遍历一个对象？

循环数组时，需要两个信息：
> 1. 对应下标的值
> 2. 是否遍历结束的标志

在控制台打印一个数组看一下结构
```js
const arr = [1, 2, 3];
console.dir(arr);
```
在__proto__中可以看到`Symbol(Symbol.iterator)`
**数组或类数组对象的原型中都实现了一个方法`Symbol.iterator`**

可以用以下方法查看
```js
const map = new Map();
console.dir(map);
const str = new String();
console.dir(str);
const set = new Set();
console.dir(set);
```

## iterator(迭代器)

[迭代协议 mdn文档](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Iteration_protocols)

The iterator protocol(可迭代协议允许) JavaScript 对象去定义或定制它们的迭代行为.
所以上面出现的`Symbol.iterator`就是数组对于这个协议的实现。

### 数组怎么实现了一个iterator呢？

[MDN 文档](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Iterators_and_Generators)

一个迭代器对象 ，知道如何每次访问集合中的一项， 并跟踪该序列中的当前位置。在  JavaScript 中 迭代器是一个对象，它提供了一个next() 方法，用来返回序列中的下一项。这个方法返回包含两个属性：done和 value。

这里获取上面数组的`Symbol.iterator`, 打印出来看看
```js
const arr = [1, 2, 3];
let iterator = arr[Symbol.iterator]();
console.dir(iterator);
```
在iterator的原型中有`next`方法，执行next方法
```js
iterator.next(); // 输出 {value: 1, done: false}
iterator.next(); // 输出 {value: 2, done: false}
iterator.next(); // 输出 {value: 3, done: false}
iterator.next(); // 输出 {value: undefined, done: true}
```
> 当下标超出时，value:undefined
iterator每次都返回一个对象，这个对象包含两个信息，当前下标的值`value`, 遍历是否结束的标志`done`

**为什么for of 不能遍历一个对象呢？JavaScript 的对象中没有实现一个这样的 iterator**

可以打印看一下`console.log({})`


### 为什么在Object中没有内置迭代器？

先了解一下基本概念

遍历对象只会在两种层级上对一个`JavaScript`对象进行遍历：
- 程序的层级。对一个对象进行迭代，是在迭代展示其结构的对象属性。举个栗子：`Array.prototype.length`这个属性与对象的结构相关，但却不是它的数据。
- 数据的层级。迭代数据结构并提取它的数据。举个栗子：迭代数组，对它的每个数据进行迭代，如果`arr=[a，b，c]`，迭代器访问的是`1,2,3`

**`JavaScript`虽然不支持用`for of`遍历对象，但提供了`for in` 方法来遍历所有非`Symbol`类型并且是可枚举的属性。**

标准不支持，自己实现一个for-of来遍历对象：
```js
Object.prototype[Symbol.iterator] = function*() {
    for (const [key, value] of Object.entries(this)) {
        yield { key, value };
    }
}

for (const { key, value } of { a: 1, b: 2, c: 3 }) {
  console.log(key, value);
}

```
在实现iterator代码中，用到了Generator 结构：`function*() {}`

## [Generators](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Generator)
语法：
```js
function* gen() { 
  yield 1;
  yield 2;
  yield 3;
}

let g = gen(); 
// "Generator { }"
```

这里打印一下gen， `console.dir(gen)`
可以看到`next`方法。执行看结果
```js
let s = gen();
s.next(); // {value: 1, done: false}
s.next(); // {value: 2, done: false}
s.next(); // {value: 3, done: false}
s.next(); // {value: undefined, done: true}
```

generator可以实例化出一个iterator，yield语句就是用来中断代码的执行的。配合next() 方法，每次只会执行一个yield语句。


### generator特性
- yield后面可以跟上另一个Generator, 并且他们会按照次序执行
```js
function* gen() {
  yield 1;
  yield* gen2();
  yield 2;
  return;
}

function* gen2() {
  yield 4;
  yield 5;
}

let iterator = gen();
console.log(iterator.next());
console.log(iterator.next());
console.log(iterator.next());
console.log(iterator.next());

// 1,4,5,2
```
- return 会终结整个Generator。卸载return后的yield不会执行。

### Generator有什么用？

能够中断执行代码，帮助我们控制异步代码的执行顺序。

例如有两个异步的函数 A 和 B, 并且 B 的参数是 A 的返回值，也就是说，如果 A 没有执行结束，我们不能执行 B

```js
function* effect() {
  const { param } = yield A();
  const { result } = yield B(param);
  console.table(result);
}

const iterator = effect();
iterator.next();
iterator.next();

```
执行两次 next() 得到结果，看起来很繁琐。
假设每次执行 A() / B() 的请求结束之后，都会自动执行 next() 即可解决。

参考[co](https://github.com/tj/co)源码


## Generator原理
async 和await 只是Generator的语法糖。
[dva](https://dvajs.com/guide/concepts.html#effect)中有Effect概念，它就是使用Generator来解决异步请求的问题。

### Generator和Promise如何异步编程
一些基本概念：
- Generator作为 ES6 中使用协程的解决方案来处理异步编程的具体实现，它的特点是: Generator 中可以使用 yield 关键字配合实例 gen 调用 next() 方法，来将其内部的语句分割执行。 简言之 : next() 被调用一次，则 yield 语句被执行一句，随着 next() 调用， yield 语句被依次执行。


Promise表示一个异步操作的最终状态（完成或失败），以及其返回的值。参考[Promise-MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Promise)


异步编程使用Generator和Promise实现的原理：
1. 因为 Generator 本身 yield 语句是分离执行的，所以我们利用这一点，在 yield 语句中返回一个 Promise 对象
2. 首次调用 Generator 中的 next() 后, 假设返回值叫 result ,那么此时 result.value 就是我们定义在 yield 语句中的 Promise 对象

> 注意：在这一步，我们已经把原来的执行流程暂停，转而执行 Promise 的内容,已经实现了控制异步代码的执行，因为此时我们如果不继续执行 next() 则 generator 中位于当前被执行的 yield 后面的内容，将不会继续执行,这已经达到了我们需要的效果
3. 接下来我们就是在执行完当前 Promise 之后，让代码继续往下执行，直到遇到下一个 yield 语句:
这一步是最关键的  所以我们怎么做呢:

- 步骤1： 在当前的 Promise 的 then() 方法中，继续执行 gen.next()
- 步骤2： 当 gen.next() 返回的结果 result.done === true 时,我们拿到 result.value【也就是一个新的 Promise 对象】再次执行并且在它的then() 方法中继续上面的步骤1，直至 result.done === false 的时候。这时候调用 resolve() 使 promise 状态改变，因为所有的 yield 语句已经被执行完。

步骤1 保证了我们可以走到下一个 yield 语句
步骤2 保证了下一个 yield 语句执行完不会中断，直至 Generator 中的最后一个 yield 语句被执行完。

## 具体实现
> 从co库中的一个demo开始，了解我们的整个异步请求封装实现

```js
co(function*() {
    yield me.loginAction(me.form);
    ...
});

```
引入co库，并且用co来包裹了一个generator（生成器）对象。
接下来我们看下co对于包裹起来的generator做了什么处理

```js
function co(gen) {
  // 1.获取当前co函数的执行上下文环境,获取到参数列表
  var ctx = this;
  var args = slice.call(arguments, 1);
  // 2.返回一个Promise对象
  return new Promise(function(resolve, reject) {
    //  判断并且使用ctx:context(上下文环境)和arg:arguments(参数列表)初始化generator并且复制给gen
    // 注意:
    // gen = gen.apply(ctx, args)之后
    // 我们调用 gen.next() 时，返回的是一个指针，实际的值是一个对象
    // 对象的形式：{done:[false | true], value: ''}
    if (typeof gen === 'function') gen = gen.apply(ctx, args);
    // 当返回值不为gen时或者gen.next的类型不为function【实际是判断是否为generator】时
    // 当前promise状态被设置为resolve而结束
    if (!gen || typeof gen.next !== 'function') return resolve(gen);
    // 否则执行onFulfilled()
    onFulfilled();
  });
}

```

这里发生了什么

1. 返回一个 promise
2. promise 中将被包裹的 generator 实例化为一个指针，指向 generator 中第一个 yield 语句
3. 判断 generator 实例化出来的指针是否存在：如果没有 yield 语句则指针不存在, 判断指针 gen.next() 方法是否为 function ：如果不为 function 证明无法执行 gen.next()
条件有一项不满足就将 promise 的状态置为 resolve
否则执行 onFulfilled()

看下 onFulfilled() 的实现

```js
function onFulfilled(res) {
    // 在执行onFulfilled时，定义了一个ret来储存gen.next(res)执行后的指针对象
    var ret;
    try {
    ret = gen.next(res);
    // 在这里，yield语句抛出的值就是{value:me.loginAction(me.form), done:false}
    } catch (e) {
    return reject(e);
    }
// 将ret对象传入到我们定义在promise中的next方法中
    next(ret);
    return null;
}

```
onFulfilled 最主要的工作就是

1. 执行 gen.next() 使代码执行到 yield 语句
2. 将执行后返回的结果传入我们自定义的 next() 方法中

next() 方法
```js
function next(ret) {
// 进入next中首先判断我们传入的ret的done状态:
// 情况1:ret.done = true 代表我们这个generator中所有yield语句都已经执行完。
// 那么将ret.value传入到resolve()中，promise的状态变成解决，整个过程结束。
    if (ret.done) return resolve(ret.value);
// 情况2:当前ret.done = false 代表generator还未将所有的yield语句执行完，那么这时候
// 我们把当前上下文和ret.value传入toPromise中，将其转换为对应的Promise对象`value`
    var value = toPromise.call(ctx, ret.value);
    if (value && isPromise(value)) return value.then(onFulfilled, onRejected);
// 当value确实是一个promise对象的时候，return value.then(onFulfilled,onRejected)
// 我们重新进入到了generator中，执行下一条yield语句
    return onRejected(new TypeError('You may only yield a function, promise, generator, array, or object, '
    + 'but the following object was passed: "' + String(ret.value) + '"'));
}

```

next 主要工作

1. 判断上一次 yield 语句的执行结果
2. 将 yield 的 result 的 value 值【其实就是我们要异步执行的 Promise 】
3. 执行 value 的 then 方法，重新进入到 onFulfilled 方法中，而在 onFulfilled 中，我们又将进入到当前方法，如此循环的调用，实现了 generator 和 Promise 的执行切换，从而实现了 Promise 的内容按照我们所定义的顺序执行。

至此实现异步操作的控制。


## 参考链接
- [前端怪谈_2从 Dva 的 Effect 到 Generator + Promise 实现异步编程](https://juejin.im/post/5c4045d1f265da617831ace3)