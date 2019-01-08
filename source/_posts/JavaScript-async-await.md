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

**async/await 带给我们的最重要的好处是同步编程风格。**

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
目前所有主流浏览器都完全支持异步功能。

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

有人将`async/await`与Promise进行比较，并声称它是JavaScript下一代异步编程风格。
`async/await`是一种改进，但它只不过是一种语法糖，不会完全改变编码风格。

本质上，async 函数仍然是Promise。 正确使用async函数之前，必须先了解promise.更糟糕的是大多数时，需要在使用promise时同时使用async函数。

这意味着，getBooksByAuthorWithAwait将返回一个promise，所以也可以使用.then(...)方式来调用它。

# async/await常见错误

使用async/await时，常见错误：

## 太过串行化

尽管await可以使代码看起来像是同步的，但实际上他们仍然是异步的，必须避免太过串行化。

```js
async getBooksByAuthor(id) {
    const books = await bookModel.fetchAll();
    const author = await authorModel.fetch(id);
    return {
        author,
        books: books.filter(book => book.authorId === id)
    };
}
```
以上代码看似正确，然而这是错误的。
- 1. await bookModel.fetchAll() 会等待fetchAll()直到fetchAll返回结果
- 2. 然后await authorModel.fetch(id) 被调用

第二个fetch不依赖于第一个fetch的结果，实际上可以并行调用。然而这里用了await，两个调用变成串行，总的执行时间比并行版本要长的多。

正确写法：
```js
async getBooksByAuthor(id) {
    const bookPromise = bookModel.fetchAll();
    const authorPromise = authorModel.fetch(id);
    const book = await bookPromise;
    const author = await authorPromise;
    return {
        author,
        books: books.filter(book => book.authorId === id)
    };
}
```

如果数组中每个item都要请求异步数据，必须依赖promise

```js
async getAuthor(id) {
    // 会引起串行调用，增加运行时间
    // const authors = _.map(
    //     authorIds,
    //     id => await authorModel.fetch(id)
    // );
    // 正确方式
    const promises = _.map(authorIds, id => authorModel.fetch(id));
    const authors = await Promise.all(promises);
}
```

总之，仍需将流程视为异步的，然后用await写出同步的代码，在复杂的流程中，直接使用promise可能更方便。

# 错误处理

在promise中，异步函数有两个返回值： resolved 和 rejected。可以用.then()处理正常情况，用.catch()处理异常情况。然而用`async/await`方式处理错误比较棘手。

## try...catch

推荐用try...catch语法捕获异常。所以最好把await命令放到try...catch代码块中。

```js
class bookModel {
    fetchAll() {
        return new Promise((resolve, reject) => {
            window.setTimeout(() => {
                reject({error: 400})
            }, 1000);
        });
    }
}
// async/await
async getBooksByAuthorWithAwait(id) {
    try {
        const books = await bookModel.fetchAll();
    } catch (error) {
        console.log(error); // {error: 400}
    }
}
```
捕捉到异常处理方法：
- 返回一个正常值。(不在catch块中使用任何return语句，相当于return undefined)
- 想让调用者处理它，可以直接抛出普通的错误对象。如throw error。允许在promise.catch中处理错误。

使用try...catch好处：
- 简单，易于理解
- 如果不需要每部执行错误处理，可以在一个try...catch块中包装多个await调用来处理一个地方的错误。

这种方法有个缺陷，由于try...catch会捕获代码块中的异常，所以通常不会被promise捕获的异常也会被捕获到。
```js
class BookModel {
    fetchAll() {
        cb();// cb未定义，导致异常
        return fetch('/books');
    }
}

try {
    bookModel.fetchAll();
} catch(err) {
    console.log(err); // 打印 cb is not undefined
}
```
代码会打印`cb is not undefined`，这个错误是由console.log打印出来，而不是JavaScript本身。有时，这是致命的，如果BookModel被包含在一些列函数调用中，其中一个调用者吞噬了错误，那么很难找到这样一个未定义错误。

## 让函数返回两个值
`[err, user] = await to(UserModel.findById(1));`

## 使用.catch

await的功能：它将等待promise完成它的工作。promise.catch()也会返回一个promise。

所以我们可以这样处理错误：
```js
// books === undefined if error happens,
// since nothing returned in the catch statement
let books = await bookModel.fetchAll().catch(err => {console.log(err);});
```

这个方法有两个小问题：
- 它是promise和async函数的混合体。仍需要理解promise是如何工作的。
- 错误理解先于正常路径，这是不直观的。

# 结论

ES7引入的 async/await 关键字无疑是对J avaScrip t异步编程的改进。它可以使代码更容易阅读和调试。
然而，为了正确地使用它们，必须完全理解 promise，因为 async/await 只不过是 promise 的语法糖，本质上仍然是 promise。
