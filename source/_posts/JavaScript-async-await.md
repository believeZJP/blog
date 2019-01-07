---
title: JavaScript - async/await
date: 2019-01-07 19:01:49
updated: 2019-01-07 19:01:49
tags:
- JavaScript
- es8
---
[参考链接](https://segmentfault.com/a/1190000017718513)

ES8 引入的 `async/await` 在 JavaScript 的异步编程中是一个极好的改进。
它提供了使用同步样式代码编写异步代码的方式，而不会阻塞主线程。

# async 作用是什么

根据[MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/async_function):

async 函数返回的是一个 Promise 对象。
async 函数（包含函数语句、函数表达式、Lambda表达式）会返回一个 Promise 对象，如果在函数中 return 一个直接量，
async 会把这个直接量通过 Promise.resolve() 封装成 Promise 对象。

如果 async 函数没有返回值， 它会返回 Promise.resolve(undefined)。

> 语法：async function name([param[, param[, ... param]]]) { statements }

# await 作用是什么([MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/await))

> 语法：[return_value] = await expression;

await 等待的是一个表达式，这个表达式的计算结果是 Promise 对象或者其它值（换句话说，await 可以等任意表达式的结果）。

如果它等到的不是一个 Promise 对象，那 await 表达式的运算结果就是它等到的东西。

如果它等到的是一个 Promise 对象，await 就忙起来了，它会阻塞后面的代码，等着 Promise 对象 resolve，然后得到 resolve 的值，作为 await 表达式的运算结果。

> 这就是 await 必须用在 async 函数中的原因。async 函数调用不会造成阻塞，它内部所有的阻塞都被封装在一个 Promise 对象中异步执行。

# async/await 的优点

async/await 带给我们的最重要的好处是同步编程风格。

代码演示:

```js
// async/await
async getBooksByAuthorWithAwait(id) {
    const books = await bookModel.fetchAll();
    // 这里的books就是异步执行返回的结果
    return books.filter(b => b.authorId === id);
}

// Promise
getBooksByAuthorWithPromise(id) {
    return bookModel.fetchAll().then(books => {
        return books.filter(b => b.authorId === id));
    }
}
```
这里调用`this.getBooksByAuthorWithAwait(id)`返回的是Promise对象， 需要执行.then才能获取到异步返回的结果

- 很明显async/await版本比Promise版本更容易理解，如果忽略await关键字，代码看起来像其他任何同步代码。
目前所有主流浏览器都完全支持异步功能。

- 浏览器支持意味着不必转换代码。便于调试。

- async关键字的好处。async声明`getBooksByAuthorWithAwait`函数返回值是一个Promise。

调用者可以安全的使用`getBooksByAuthorWithAwait.then(...)`或`await getBooksByAuthorWithAwait()`.

Promise在异常情况下不能调用`.then`。有了async声明，这种情况就不会出现

如下：
```js
getBooksByAuthorWithPromise(id) {
    if(!authorId) {
        return null;
    }
    return bookModel.fetchAll()
        .then(books => books.filter(b => b.authorId === id));
}
```
这里如果调用`getBooksByAuthorWithPromise`可能返回Promise(正常情况)或null(异常情况id为空), 在这种情况下，调用者不能调用.then()

# async/await 可能会产生误导
