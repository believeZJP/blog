---
title: js 代码片段
date: 2019-06-20 16:03:49
updated: 2019-06-20 16:03:49
tags:
---
## js比较版本号

```js
/**
 * 版本比较 versionCompare
 * @param {String} currVer 当前版本.
 * @param {String} promoteVer 比较版本.
 * @return {Boolean} false 当前版本小于比较版本返回 true.
 *
 * 使用
 * versionCompare("6.3","5.2.5"); // false.
 * versionCompare("6.1", "6.1"); // false.
 * versionCompare("6.1.5", "6.2"); // true.
 */
function versionCompare(currVer = '0.0.0', promoteVer = '0.0.0') {
    if (currVer === promoteVer) {
        return false;
    }
    const currVerArr = currVer.split('.');
    const promoteVerArr = promoteVer.split('.');
    const len = Math.max(currVerArr.length, promoteVerArr.length);
    // ~是按位取反的意思，计算机里面处理二进制数据时候的非，
    // ~~利用两个按位取反的符号，进行类型的转换，转换成数字
    for (let i = 0; i < len; i++) {
        // 将比较对象转成数字
        const proVal = ~~promoteVerArr[i];
        const curVal = ~~currVerArr[i];
        if (proVal < curVal) {
            return false;
        }
        else if (proVal > curVal) {
            return true;
        }
    }
    return false;
}
```

## bind

bind 返回的是一个新的函数，你必须调用它才会被执行

function() {}.bind(thisArg [, arg1 [, arg2, …]]);

bind函数传参会先于新函数调用时的参数传入

```js
var fn = function(){
    setTimeout(function(){
        console.log(this.name)
    }.bind({name: 2}), 100)
}

var obj1 = {name:1}
fn.call(obj1) //输出2 ，因为bind的参数先于其他参数。

自己实现bind

if (!function() {}.bind) {
    Function.prototype.bind = function(context) {
        var self = this
            , args = Array.prototype.slice.call(arguments);

        return function() {
            return self.apply(context, args.slice(1));
        }
    };
}


```

## 把queryString转换成js对象

```js
function getQueryObject(url){
    url=url==null?window.location.href:url;
    var search=url.substring(url.lastIndexOf("?")+1);
    var obj={};
    var reg=/([^?&=]+)=([^?&=]*)/g;
    search.replace(reg,function(rs,$1,$2){
        var name=decodeURIComponent($1);
        var val=decodeURIComponent($2);
        obj[name]=String(val);
        return rs;
    })
    return obj;
}

getQueryObject("http://www.cnblogs.com/zichi/p/4359786.html?aa=111&bb=3dadsads&43=43a");
```

## 实现一个异步缓存器，第一次调用，发送请求，第二次调用，直接取结果

用发布订阅者模式

不管谁调用都是拿的同一个Promise，

## Promise 写法

```js
// 标准写法：

var promise = new Promise(function(resolve, reject) {
    // ... some code
    if ( /* 异步操作成功 */ ) {
        resolve(value);
    } else {
        reject(error);
    }
});

promise.then(function(value) {
    // success
}, function(error) {
    // failure
});


new Promise(function (resolve, reject) {
// 一、这里是Promise要执行的代码
    log('start new Promise...');
    var timeOut = Math.random() * 2;
    log('set timeout to: ' + timeOut + ' seconds.');
    setTimeout(function () {
        if (timeOut < 1) {
            log('call resolve()...');
            // 二、这里才是异步执行后调用的步骤
            resolve('200 OK');
        }
        else {
            log('call reject()...');
            reject('timeout in ' + timeOut + ' seconds.');
        }
    }, timeOut * 1000);
}).then(function (r) {
    log('Done: ' + r);
}).catch(function (reason) {
    log('Failed: ' + reason);
});

```

## 自己实现promise.all

思路，用一个数组将所有要请求的存起来，循环发送执行后，根据数组长度判断是否执行完成。

1、接收一个 Promise 实例的数组或具有 Iterator 接口的对象，

2、如果元素不是 Promise 对象，则使用 Promise.resolve 转成 Promise 对象

3、如果全部成功，状态变为 resolved，返回值将组成一个数组传给回调

4、只要有一个失败，状态就变为 rejected，返回值将直接传递给回调
all() 的返回值也是新的 Promise 对象

```js
function promiseAll(promises) {
  return new Promise(function(resolve, reject) {
    if (!isArray(promises)) {
      return reject(new TypeError('arguments must be an array'));
    }
    var resolvedCounter = 0;
    var promiseNum = promises.length;
    var resolvedValues = new Array(promiseNum);
    for (var i = 0; i < promiseNum; i++) {
      (function(i) {
        Promise.resolve(promises[i]).then(function(value) {
          resolvedCounter++
          resolvedValues[i] = value
          if (resolvedCounter == promiseNum) {
            return resolve(resolvedValues)
          }
        }, function(reason) {
          return reject(reason)
        })
      })(i)
    }
  })
}

```

## 手动写多次异步调用回调

场景一：先调用getData1，再调用getData2，再调用getData3  ...

```js

//创建一个Promise实例，获取数据。并把数据传递给处理函数resolve和reject。需要注意的是Promise在声明的时候就执行了。
var getData1=new Promise(function(resolve,reject){
    $.ajax({
        type:"get",
        url:"index.aspx",
        success:function(data){
            if(data.Status=="1"){
                resolve(data.ResultJson)//在异步操作成功时调用
            }else{
                reject(data.ErrMsg);//在异步操作失败时调用
            }
        }
    });
})

var getData2= new Promise(function(resolve,reject){
    $.ajax({
        type:"get",
        url:"index.aspx",
        success:function(data){
            if(data.Status=="1"){
                resolve(data.ResultJson)//在异步操作成功时调用
            }else{
                reject(data.ErrMsg);//在异步操作失败时调用
            }
        }
    });
})
var getData3=new Promise(function(resolve,reject){
    $.ajax({
        type:"get",
        url:"index.aspx",
        success:function(data){
            if(data.Status=="1"){
                resolve(data.ResultJson)//在异步操作成功时调用
            }else{
                reject(data.ErrMsg);//在异步操作失败时调用
            }
        }
    });
})
getData1.then(function(res){
　　return getData2(res)
}).then(function(res){
　　return getData3(res)
}).then(function(res){
　　console.log(res)
}).cache(function(error){
　　console.log(error)
})
场景二：getData3的执行依赖getData1和getData2
//Promise的all方法，等数组中的所有promise对象都完成执行
Promise.all([getData1,getData2]).then(function([ResultJson1,ResultJson2]){
    //这里写等这两个ajax都成功返回数据才执行的业务逻辑
　　getData3()
})
```

## Object.defineProperty(obj, prop, descriptor)

value
属性对应的值,可以使任意类型的值，默认为undefined

writable
属性的值是否可以被重写。设置为true可以被重写；设置为false，不能被重写。默认为false

enumerable
此属性是否可以被枚举（使用for...in或Object.keys()）。设置为true可以被枚举；设置为false，不能被枚举。默认为false。

configurable
是否可以删除目标属性或是否可以再次修改属性的特性（writable, configurable, enumerable）。设置为true可以被删除或可以重新设置特性；设置为false，不能被可以被删除或不可以重新设置特性。默认为false。

这个属性起到两个作用：

目标属性是否可以使用delete删除

目标属性是否可以再次设置特性

//第一种情况：configurable设置为false，不能被删除。
//第二种情况：configurable设置为true，可以被删除。

```js
//对象新添加的属性的特性描述
Object.defineProperty(obj,"newKey",{
    configurable:true | false,
    enumerable:true | false,
    value:任意类型的值,
    writable:true | false
});


存取器描述
当使用存取器描述属性的特性的时候，允许设置以下特性属性：

var obj = {};
Object.defineProperty(obj,"newKey",{
    get:function (){} | undefined,
    set:function (value){} | undefined
    configurable: true | false
    enumerable: true | false
});


属性对应的值,可以使任意类型的值，默认为undefined



getter 是一种获得属性值的方法

setter是一种设置属性值的方法。
var obj = {};
var initValue = 'hello';
Object.defineProperty(obj,"newKey",{
    get:function (){
        //当获取值的时候触发的函数
        return initValue;
    },
    set:function (value){
        //当设置值的时候触发的函数,设置的新值通过参数value拿到
        initValue = value;
    }
});
//获取值
console.log( obj.newKey );  //hello

//设置值
obj.newKey = 'change value';

console.log( obj.newKey ); //change value

```

## 字符串重复

```js
'x'.repeat(3) // "xxx"
264 'hello'.repeat(2) // "hellohello"
265 'na'.repeat(0) // ""
```

## 数组重复

```js
Array.prototype.cp = function(n){
    var arr = [];
    while(n>0){
        console.log(this);
        n--;
        arr= arr.concat(this);
        console.log(arr);
    }
}

```

## js复制数组

一、 slice

slice 方法返回一个 Array 对象，
其中包含了 arrayObj 的指定部分。

如果省略 end ，那么 slice 方法将一直复制到 arrayObj 的结尾。
如果 end 出现在 start 之前，不复制任何元素到新数组中。

```js
var arr = ["One","Two","Three"];

var arrtoo = arr.slice(0);
arrtoo[1] = "set Map";

// arr  One,Two,Three
// arrtoo  One,set Map,Three

```

二、concat() 方法用于连接两个或多个数组。
该方法不会改变现有的数组，而仅仅会返回被连接数组的一个副本。

```js
var arrtooo = arr.concat();
arrtooo[1] = "set Map To";
```

三、虽然说assgin也是深拷贝，但是他只是第一层深拷贝，第二层之后还是进行浅拷贝

## 模拟链式调用

```js
var obj={};
obj.a=function(){
    console.log("a")
    return this
}
obj.b=function(){
    console.log("n")
    return this
}
obj.a().b();
```

## 参数链式调用

```js
const functionFunction = (s) => {
  const func = (str) => {
    s += ',' + str;
    return func;
  }
  func.toString = func.valueOf = () => s;
  return func;
}

alert(functionFunction(2)(3)(4)) // 2,3,4
```

## Promise异步链式写法

```js
function fn_a(num) {
    return new Promise(function (resolve, reject) {
        if(num!= undefined){
            num=num+1;
            setTimeout(resolve(num), 500);
        }else{//错误
            reject("num未定义");
        }
    });
}
function fn_b(num,parm) {
    return new Promise(function (resolve, reject) {
            num=num*parm;
            setTimeout(resolve(num), 1000);

    });
}
fn_a(1).then(num=>{
    return fn_b(num,5);
},error=>{
    console.log(error);
}).then(num=>{
    console.log(num);//在1.5秒回返回10
})
```

## map，forEach， filter， reduce

```js
var a=new Array(1,2,3,3,2,1);

Array.isArray(a)); //true

a.indexOf(2)); //1
a.lastIndexOf(2); //4

a.forEach(function(e,i,array){
    array[i]=e+1;
});

a.every(function(e,i,arr){
    console.log(i+' : '+e);
    return e<5;
});

a.map(function(e){
    return e*e;
});

a.filter(function(e){
    return e%2==0;
})

a.reduce(function(v1,v2){
    return v1+v2;
})

// 数组 arr = [1,2,3,4] 求数组的和

forEach 实现
var arr = [1,2,3,4],
sum = 0;
arr.forEach(function(e){sum += e;}); // sum = 10
map 实现
var arr = [1,2,3,4],
sum = 0;
arr.map(function(obj){sum += obj});//return undefined array. sum = 10
reduce实现
var arr = [1,2,3,4];
arr.reduce(function(pre,cur){return pre + cur}); // return 10
```

## 写一个方法clone; 实现js五种数据类型(string, number, boolean, array, object)的复制

number , string , boolean 直接赋值

object , array 遍历后赋值

方法中用到的apply方法

```js
function clone(obj) {
    var copy;
    switch(typeof obj){
        case 'number':
        case 'string':
        case 'boolean':
        copy = obj;
        break;
        case 'object':
        if (obj == null) {
            copy = null
        } else if (toString.apply(obj) === '[object Array]') {
            copy = [];
            for (var i in obj) {
                copy.push(clone(obj[i]))
            };
        } else {
            copy = {};
            for (var j in obj) {
                copy[j] = clone(obj[j]);
            }
        }
    }
    return copy;
}

　　//各种类型的返回值; call 和 apply 返回值相同; 只是参数不同
　　 console.log("string" +toString.apply(str))
　　 // string[object String]  
    console.log("number" +toString.apply(num))
    // number[object Number]
    console.log("object" +toString.apply(obj))
    // object[object Object]
    console.log("array" + toString.apply(arr))
    // array[object Array]
    console.log("boolean" + toString.apply(bool))
    // boolean[object Boolean]
    console.log("undefined" + toString.apply(undefined))
    //undefined[object Undefined]
    console.log("null" + toString.apply(null))
    //  null[object Null]
```

## 纯js的ajax

```js
/**
 * 得到ajax对象
 */
function getajaxHttp() {
    var xmlHttp;
    try {
        // Firefox, Opera 8.0+, Safari
        xmlHttp = new XMLHttpRequest();
        } catch (e) {
            // Internet Explorer
            try {
                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            } catch (e) {
            try {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {
                alert("您的浏览器不支持AJAX！");
                return false;
            }
        }
    }
    return xmlHttp;
}
/**
 * 发送ajax请求
 * url--url
 * methodtype(post/get)
 * con (true(异步)|false(同步))
 * parameter(参数)
 * functionName(回调方法名，不需要引号,这里只有成功的时候才调用)
 * (注意：这方法有二个参数，一个就是xmlhttp,一个就是要处理的对象)
 * obj需要到回调方法中处理的对象
 */
function ajaxrequest(url,methodtype,con,parameter,functionName,obj){
    var xmlhttp=getajaxHttp();
    xmlhttp.onreadystatechange=function(){
        if(xmlhttp.readyState==4){
            //HTTP响应已经完全接收才调用
            functionName(xmlhttp,obj);
        }
    };
    xmlhttp.open(methodtype,url,con);
    xmlhttp.send(parameter);
}
//这就是参数
function createxml(){
    var xml="<user><userid>haorooms 纯js ajax请求<\/userid><\/user>";//"\/"这不是大写V而是转义是左斜杠和右斜杠
    return xml;
}
//这就是参数
function createjson(){
    var json={id:0,username:"haorooms"};
    return json;
}
function c(){
    alert("");
}
//测试
ajaxrequest("http://www.haorooms.com","post",true,createxml(),c,document);
```

## reduce用法

## 将数组所有项相加

```js
var total = [0, 1, 2, 3].reduce(function(a, b) {
    return a + b;
});
// total == 6
```

## 数组扁平化  有多种解决办法

```js
var flattened = [[0, 1], [2, 3], [4, 5]].reduce(function(a, b) {
    return a.concat(b);
});
// flattened is [0, 1, 2, 3, 4, 5]

使用递归实现

function flattenDepth(array, depth=1) {
  let result = [];
  array.forEach (item => {
    let d = depth;
    if(Array.isArray(item) && d > 0){
      result.push(...(flattenDepth(item, --d)))
    } else {
      result.push(item);
    }
  })
  return result;
}
console.log(flattenDepth([1,[2,[3,[4]],5]]))
```

## 数组去重多种方法

```js
扩展运算符（…）内部使用for…of循环

[...new Set([1,2,3,1,'a',1,'a'])]

Array.from(new Set(array));

// 原理：利用forEach的三个参数和indexOf()的第二个参数(从哪里开始查找)，
在数组中检测该元素后方是否有与该元素相同的元素。
distinct = (arr) =>{
    let _arr = [];
    arr.forEach((item, index, arr) => {
    var bool = arr.indexOf(item,index+1);
 if(bool === -1){
            _arr.push(item);
        }
    })
    return _arr;
}
let arr = [2,1,3,5,1,2,4];
distinct(arr);
=> [3, 5, 1, 2, 4]   //1是后面的1，2也是后出现的2.

// 原理：splice()删除元素，会改变原数组。

distinct = (arr) =>{
    let len = arr.length;  
 for(let i = 0; i < len; i++) {  
     for(let j = i + 1; j < len; j++) {  
         if(arr[i] === arr[j]) {  
             arr.splice(j,1);  
             len--;  
             j--;  
         }  
     }  
 }  
 return arr;
}
let arr = [2,1,3,5,1,2,4];
distinct(arr);
=>[2, 1, 3, 5, 4]


```

## 获取数组最大最小值

```js
Array.max = function( array ){
return Math.max.apply( Math, array );
};
Array.min = function( array ){
return Math.min.apply( Math, array );
};



Array.prototype.max = function(){
return Math.max.apply({},this)
}
Array.prototype.min = function(){
return Math.min.apply({},this)
}
[1,2,3].max()// => 3
[1,2,3].min()// => 1

var a=[1,2,3,[5,6],[1,4,8]];
var ta=a.join(",").split(",");//转化为一维数组
alert(Math.max.apply(null,ta));//最大值
alert(Math.min.apply(null,ta));//最小值

//sort()排序默认为升序，reverse()将数组掉个
var max3 = arr.sort().reverse()[0];
console.log(max3)


使用ES6的扩展运算符
 var arr = [22,13,6,55,30];
 console.log(Math.max(...arr)); // 55
```

## 防抖（debounce）

函数防抖和节流都能控制一段时间内函数执行的次数.

函数防抖: 将本来短时间内爆发的一组事件组合成单个事件来触发。等电梯就是一个非常形象的比喻，电梯不会立即上行，而是等待一段时间内没有人再上电梯了才上行，换句话说此时函数执行时一阵一阵的，如果一直有人上电梯，电梯就永远不会上行。
> 使用场合：用户输入关键词实时搜索，如果用户每输入一个字符就发请求搜索一次，就太浪费网络，页面性能也差；再比如缩放浏览器窗口事件；再再比如页面滚动埋点

函数节流: 控制持续快速触发的一系列事件每隔'X'毫秒执行一次,就像Magic把瓢泼大雨编程了绵绵细雨。
> 使用场合：页面滚动过程中不断统计离底部距离以便懒加载。
作用是在短时间内多次触发同一个函数，只执行最后一次，或者只在开始时执行。

```js
// debounce 函数接受一个函数和延迟执行的时间作为参数
function debounce(fn, delay){
    // 维护一个 timer
    let timer = null;

    // 返回的函数并没有使用箭头函数，目的是在事件执行时确定上下文
    return function() {
        // 获取函数的作用域和变量
        let context = this;
        let args = arguments;

        timer && clearTimeout(timer);
        timer = setTimeout(function(){
            fn.apply(context, args);
        }, delay)
    }
}

function foo() {
  console.log('trigger');
}
// 在 debounce 中包装我们的函数，过 2 秒触发一次
window.addEventListener('resize', debounce(foo, 2000));

每一次事件被触发，都会清除当前的 timer 然后重新设置超时调用。
只有在最后一次触发事件，才能在 delay 时间后执行。
```

## 节流（throttle）

节流是在一段时间内只允许函数执行一次。

时间戳实现：

```js

function throttle(func, wait = 100) {
  let timerId
  let start = Date.now()
  return function(...args) {
    const now = Date.now()
    clearTimeout(timerId)
    if (now - start >= wait) {// 可以保证func一定会被执行
      func.apply(this, args)
      start = now
    } else {
      timerId = setTimeout(() => {
        func.apply(this, args)
      }, wait)
    }
  }
}

```

使用时间戳实现的节流函数会在第一次触发事件时立即执行，以后每过 delay 秒之后才执行一次，并且最后一次触发事件不会被执行；而定时器实现的节流函数在第一次触发时不会执行，而是在 delay 秒之后才执行，当最后一次停止触发后，还会再执行一次函数。

## 柯里化

参数够了就执行，参数不够就返回一个函数，之前的参数存起来，直到够了为止。

3个常见作用：1. 参数复用；2. 提前返回；3. 延迟计算/运行。

```js
function curry(func) {
  var l = func.length;
  return function curried() {
    var args = [].slice.call(arguments);
    if(args.length < l) {
      return function() {
        var argsInner = [].slice.call(arguments)
        return curried.apply(this, args.concat(argsInner))
      }
    } else {
      return func.apply(this, args)
    }
  }
}

var f = function(a,b,c) {
  return console.log([a,b,c])
}
var curried = curry(f);
curried(1)(2)(3)

```

## 浅拷贝

```js
　function extendCopy(p) {

　　　　var c = {};

　　　　for (var i in p) {
　　　　　　c[i] = p[i];
　　　　}

　　　　c.uber = p;

　　　　return c;
　　}
```

## 深拷贝

```js
function deepCopy(p, c) {

　　　　var c = c || {};

　　　　for (var i in p) {

　　　　　　if (typeof p[i] === 'object') {

　　　　　　　　c[i] = (p[i].constructor === Array) ? [] : {};

　　　　　　　　deepCopy(p[i], c[i]);

　　　　　　} else {

　　　　　　　　　c[i] = p[i];

　　　　　　}
　　　　}

　　　　return c;
}
```

## 自己实现bind方法

```js
Function.prototype.bind=Function.prototype.bind||function(context){
    var self=this;
    return function(){
        return self.apply(contex,arguments);
    };
}
```
