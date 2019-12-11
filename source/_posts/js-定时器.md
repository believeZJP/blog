---
title: js 定时器
date: 2018-11-16 18:05:59
updated: 2018-11-16 18:05:59
tags:
- JavaScript
- 定时器
---
## 一、定时器

## setTimeout: 设置一个定时器，在定时器到期后，执行一段代码或代码段

```js
var timeoutId = window.setTimeout(func[, delay, param1, param2, ... ]);
var timeoutId = window.setTimeout(code[, delay]);

```

* timeoutId: 定时器ID
* func: 延迟执行的函数
* code: 延迟执行的代码字符串，不推荐使用，原理类似eval
* delay: 延迟的时间(单位：毫秒)，默认值0
* param1, param2: 向延迟函数传递的参数。

<!--- more --->

## setInterval: 以固定时间间隔重复调用一个函数或代码段

```js
var intervalId = window.setInterval(func, delay[, param1, param2, ...]);
var intervalId = window.setInterval(code, delay);
```

* intarvalId: 重复操作的ID
* func: 延迟调用的函数
* code: 代码段
* delay: 延迟时间，没有默认值

## setImmediate： 在浏览器完全结束当前运行的操作之后立即执行指定的函数(仅IE10和Node0.10+实现)，类似setTimeout(func, 0)

setImmediate设计来是为保证让代码在下一次事件循环执行，以前setTimeout(0)这种不可靠的方式可以丢掉了。

```js
var immediateId = setImmediate(func[, param1, param2, ...]);
var immediateId = setImmediate(func);


(function testSetImmediate() {
    const label = 'setImmediate';
    console.time(label);

    setImmediate(() => {
        console.timeEnd(label);
    });
})();
```

* immediateId: 定时器ID
* func: 回调

## requestAnimationFrame: 帧动画的API,根据浏览器的刷新频率而定

```js
var requestId = window.requestAnimationFrame(func);
```

* func: 回调

## Promise

es6中的异步模型。在setTimeout(0), setImmediate,requestAnimationFrame和Promise中，Promise优先级最高。

```js

function testSetImmediate() {
    const label = 'setImmediate';
    console.time(label);

    setImmediate(() => {
        console.timeEnd(label);
    });
}

function testPromise() {
    const label = 'Promise';
    console.time(label);
    new Promise((resolve, reject) => {
        resolve();
    }).then(() => {
        console.timeEnd(label);
    });
}

testSetImmediate();
testPromise();

```

尽管setImmediated 先注册，Promise先执行

## process.nextTick

是Nodejs中的API，比Promise更早执行

> 事实上，Promise不会进入异步队列，而是直接在主线程队列尾强插一个任务，虽然不会阻塞主线程，但会阻塞异步任务的执行。如果有嵌套的process.nextTick，那异步任务就永远没机会被执行到了。
使用的时候要谨慎。但Vue中的nextTick是这个实现的吗？？？

## 二、 show me the code

## 基本用法

```js
var intervalId, timeoutId;
timeoutId = setTimeout(function(){
    console.log(1);
}, 300);

setTimeout(function(){
    clearTimeout(timeoutId);
    console.log(2);
}, 100);

setTimeout('console.log(5)', 400);

intervalId = setInterval(function(){
    console.log(4);
    clearInterval(intervalId);
}, 200);

// 分别输出2,4,5

```

## setInterval 和setTimeout 的区别

```js
setTimeout(function(){
   console.log('timeout');
}, 1000);

setInterval(function(){
    console.log('interval');
}, 1000);

// 输出一次timeout，每隔1s输出一次interval


/*****-------------------***/
//通过setTimeout模拟setInterval和setInterval的区别

var callback = function(){
    if (times++ > max) {
       clearTimeout(timeoutId);
       clearInterval(intervalId);
    }

    console.log('start', Date.now() - start);
    for(var i=0; i< 990000000; i++){}
    console.log('end', Date.now() - start);
},
delay = 100,
times = 0,
max = 5,
start = Date.now(),
intervalId,
timeoutId;

function imitateInterval(fn, delay) {
    timeoutId = setTimeout(function(){
        fn();
        if(times <= max) {
            imitateInterval(fn, delay);
        }
    }, delay);
}

imitateInterval(callback, delay);
intervalId = setInterval(callback, delay);


```

* setTimeout 和setInterval 仅在执行次数上有区别：setTimeout只执行一次，setInterval执行n次。

* 通过setTimeout模拟的setInterval与setInterval的区别在于：
    **setTimeout只在回调完成之后才回去调用下一次定时器**，
    而setInterval不管回调函数执行情况，**到达规定时间就会在事件队列中插入一个执行回调的事件**，所以，用setInterval时要谨慎，比如发送请求失败，会造成死链堆积。

## show me what you can do

```js
//题目1
var t = true;
setTimeout(function(){
    t = false;
}, 1000);

while(t){}

alert('end');

/**----------------------*/

// 题目2
for(var i=0; i<5; i++){
    setTimeout(function(){
        console.log(i);
    }, 0);
}

/**----------------------*/

// 题目3

var obj = {
    msg: 'obj',
    shout: function (){
        alert(this.msg);
    },
    waitAndShout: function(){
        setTimeout(function (){
            this.shout();
        }, 0);
    }
};
obj.waitAndShout();





```

## The truth

* 第一题：

> alert永远不会执行，因为js是单线程，且定时器的回调在等待当前正在执行的任务完成后才执行，
而while(true){}进入死循环一直占用线程，不给回调函数执行机会

* 第二题

> 输出55555. 当i=0时，生成一个定时器，将回调插入事件队列中，等待当前队列无任务执行再执行。此时for循环正在执行，回调被搁置。当for循环执行完成后，队列中有5个回调函数，都执行console.log(i),因为当前js没有使用块级作用域，所以i的值在for循环结束后一直为5，输出5个5.

* 第三题

> 报错：Uncaught TypeError: this.shout is not a function
setTimeout()调用的代码运行在与所在函数完全分离的执行环境上，导致代码中的this指向window(或全局)对象，window对象不存在shout方法，所以报错。

修改方案

```js
var obj = {
    msg: 'obj',
    shout: function () {
        alert(this.msg);
    },
    waitAndShout: function() {
        var self = this; // 这里将this赋给一个变量
        setTimeout(function () {
            self.shout();
        }, 0);
    }
};
obj.waitAndShout();

```

## 需要注意

* JS引擎基于事件循环，只有一个线程，会强制异步事件排队执行
* 如果setInterval的回调执行时间长于指定的延迟，setInterval将无间隔的一个接一个执行
* this的指向问题可以通过bind函数，定义变量，箭头函数的方式解决。
* 多个定时器如不及时清除，会存在干扰，是延迟时间捉摸不透。所以不管定时器有没有执行完，及时清除已经不需要的定时器是个好习惯。
* 如果setTimeout和setInterval都在延迟100ms之后执行，那么谁先注册谁就先执行回调函数。

[JavaScript定时器与执行机制解析](http://www.alloyteam.com/2016/05/javascript-timer/)
[参考](http://ssh.today/blog/something-about-js-timer)
