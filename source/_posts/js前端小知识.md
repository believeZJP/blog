---
title: js前端小知识
date: 2019-12-05 17:03:46
updated: 2019-12-05 17:03:46
tags:
---

## 前端替换字符串中的特殊字符

 比如回车，换行，等。
在window中，换行有可能是\r\n连起来的。

```js
    str.replace(/\\n/g, "\\n")
      .replace(/\n/g, "\\n")
      .replace(/\\'/g, "\\'")  
      .replace(/" "/g, "")
      .replace(/\\"/g, "\\\"")  
      .replace(/\\&/g, "\\&")  
      .replace(/\\r/g, "\\r")  
      .replace(/\\t/g, "\\t")  
      .replace(/\\b/g, "\\b")  
      .replace(/\\f/g, "\\f");
```

<!-- more -->
## js获取options的列表和每个的文本和值

`var opts=document.getElementById("option").options;`
opts[0].value得到第一个value的值
opts[0].text得到显示的文本值

js获取时间戳
`var nowTimestamp = new Date().getTime();`
获取3个小时前的时间戳
`var threeHourAgo = nowTimestamp - 3 *60 * 60* 1000;`

---

## js获取select选中的值

```js
$("#s option:selected").text();  //获取选中的option的文本值

// 获取select中option的被选中的value值，
$("#s").val();
$("#s option:selected").val();


// js获取select选中的值
var sel=document.getElementById("select1");
var index = sel.selectedIndex; // 选中索引
albumid= sel.options[index].value;//要的值
```

---

## 获取文本为{}的元素

$("table tr td:contains('{}')")

---

## 在当前元素上添加一个父元素

```js
//给table添加一个div.table-responsive的父元素，可以使table变成响应式的。
$('table').addClass('table').wrap('<div class="table-responsive"/>');
```

## js 触发resize

jQuery: $(selector).resize()
 eg: $(window).resize();

js的暂未找到！！！！！！

## js设置时间为标准时间格式

* 普通 new Date();
* var a = new Date('2016-10-12 12:12:11');
* 这种情况在safari下不能用
会返回Invalid Date
* 可以用a == 'Invalid Date' 判断
new Date('2016/10/12 12:12:11')
* 这种可以在sarafi和chrome下使用
* 于是，
* var a = '2016-10-12 12:12:11'
* a = a.replace(/-/g,"/")
* var a = new Date(a)

---

## setTimeout

```js
function a(){
    console.log('a');
    setTimeout(function(){
        console.log('aaa');
    },0);
}
function b(){
    console.log('b');
}
a();
b();
```

调用 setTimeout 函数会在一个时间段过去后在队列中添加一个消息。这个时间段作为函数的第二个参数被传入。如果队列中没有其它消息，消息会被马上处理。但是，如果有其它消息，setTimeout 消息必须等待其它消息处理完。因此第二个参数仅仅表示最少的时间 而非确切的时间
所以即使，时间设置为0，也是会照样先执行函数b

---

## js replace 替换空格

var a = '{"string":" ","hex":"20","":" "}'
a.replace(/" "/g, "")

输出结果："{"string":,"hex":"20","":}"
解决办法：
    a.replace(/" "/g, '""')
    a.replace(/" "/g, "\" \"")

---

## css去除所有边框

1. border: none;
2. cellpadding="0" cellspacing="0"

## css 换行

`word-break: break-word;`
在火狐下不支持，解决方案：
所有的浏览器都支持

```css
overflow: hidden;
word-wrap: break-word;
word-break: break-all;
```

1、对已有对象进行扩充方法和属性

```js
 var object = new Object();
    object.name = "zhangsan";//每个对象需要写这些语句
    object.sayName = function(name){//每个对象需要写这些语句
        this.name = name;
    };
    object.sayName("lisi");
    alert(object.name);
```

2、工厂方式创建对象

```js
 function createObject() {
        var object = new Object();
        object.username = "zhangsan";
        object.password = "123456";
        object.get = function(){
            alert(this.username + "," + this.password);
        }
        return object;
    }
    var object1 = createObject();
    var object2 = createObject();
    object1.get();
    object2.get();

    // 带参数的构造方法
    function createObject(username, password){
        var object = new Object();
        object.username = username;
        object.password = password;
        object.get = function(){//缺点是，多少个对象则方法就有多少个
            alert(this.username + ", " + this.password);
        }
        return object;
    }
    var object1 = createObject("zhangsan",123456);
    object1.get();

    // 最佳改进方式
    function get(){//使该函数被多个对象共享
        alert(this.username + ", " + this.password);
    }
    function createObject(username, password){//创建对象
        var object = new Object();
        object.username = username;
        object.password = password;
        object.get = get;
        return object;
    }
    var object1 = createObject("zhangsan", "123456");
    var object2 = createObject("wangwu", "654321");
    object1.get();
    object2.get();
```

3、构造函数方式创建对象

```js
 function Person(){
        //在执行第一行代码欠，js引擎会为我们生成一个对象
        this.username = "zhangsan";
        this.password = "123";
        this.getInfo = function(){
            alert(this.username + ", " + this.password);
        }
        //此处有一个隐藏的return语句，用于将之前生成对象返回。
    }
    var p1 = new Person();
    p1.getInfo();

    //带参数
    function Person(username, password){
        this.username = username;
        this.password = password;
        this.getInfo = function(){
            alert(this.username + ", " + this.password);
        }
    }
    var p1 = new Person("zhangsan","1234546");
    p1.getInfo();
```

4、原型（“prototype”）方式

```js
function Person(){}
    Person.prototype.username = "zhangsan";
    Person.prototype.password = "123456";
    Person.prototype.getInfo = function(){
        alert(this.username + ", " + this.password);
    }

    var person = new Person();
    var person2 = new Person();
    person.username = "haha";
    person.getInfo();
    person2.getInfo();


    //单纯使用原型方式定义对象无法在构造函数中为属性赋值，只能在对象生成后再去改变属性值
    function Person(){}

    Person.prototype.username = new Array();
    Person.prototype.password = "123456";

    Person.prototype.getInfo = function(){
        alert(this.username + ", " + this.password);
    }

    var person = new Person();
    var person2 = new Person();
    person.username.push("zhangsan");
    person.username.push("lisi");
    person.password = "321";
    person.getInfo();
    person2.getInfo();
```

5、综合方式（原型+构造函数方式搭配）

```js
  function Person(){
        this.username = new Array();//不被多个对象共享
        this.password = "123";
    }

    Person.prototype.getInfo = function()//被多个对象共享
    {
        alert(this.username + "," + this.password);
    }

    var p1 = new Person();
    var p2 = new Person();
    p1.username.push("zhangsan");
    p2.username.push("lisi");
    p1.getInfo();
    p2.getInfo();
```

6、动态原型方式

```js

function Person(){
    this.username = "zhangsan";
    this.password = "123";
    //通过标志量让所有的对象共享方法
    if(typeof Person.flag == "undefined"){
        alert("prototype");
        Person.prototype.getInfo = function() {
            alert(this.username + ", " + this.password);
        }
        Person.flag = true;
    }
}

var p = new Person();
var p2 = new Person();
p.getInfo();
p2.getInfo();
```

一道容易做错的JavaScript面试题

<http://caibaojian.com/toutiao/5446?fid=0#0-tsina-1-81079-397232819ff9a47a7b7e80a40613cfe1>

---

## js获取字符串字节数方法小结

  方法一：

```js
    //原理：把中文字符替换成2个英文字母，那么字节数就是2，
    //\u0000这个表示的是unicode编码
    alert('a你好'.replace(/[^\u0000-\u00ff]/g,"aa").length);
```

方法二：

```js
    //结果是6
    //原理也很简单，用正则判断是不是中文，如果是的话，字节数就加1。
    var str='我我我';
    var bytesCount;
    for (var i = 0; i < str.length; i++)
    {
      var c = str.charAt(i);
      if (/^[\u0000-\u00ff]$/.test(c)) //匹配双字节
      {
      bytesCount += 1;
      }
      else
      {
      bytesCount += 2;
      }
    }
    alert(bytesCount);
```

### 关键

匹配中文字符的正则表达式： [\u4e00-\u9fa5]

匹配双字节字符(包括汉字在内)：[^\u0000-\u00ff]

## 过滤特殊字符

```js

// /["'<>%;)(&+]/

if (/['")-><&\\\/\.]/.test(value)) {
    alert('包含特殊字符，不允许提交!');
}

IllegalString = "\`~!#$%^&*()+{}|\\:\"<>?-=/,\'";

var pattern = new RegExp("[%--`~!@#$^&*()=|{}':;',\\\\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");

if (/[ ,\\`,\\~,\\!,\\@,\#,\\$,\\%,\\^,\\+,\\*,\\&,\\\\,\\/,\\?,\\|,\\:,\\.,\\<,\\>,\\{,\},\\(,\\),\\'',\\;,\\=,\"]/.test(key)) {

if (/['")-><&\\\/\.]/.test(key)) {
 alert('包含特殊字符，不允许提交!');
    return;
}

```

## 1.如何通过css使div 实现全屏效果

--全屏要素：
    1.全屏的元素及其父元素都要设置为height:100%,
    2.将html,body标签设置为height100%,
注：height:100%是跟随其父元素高度变化而变化的

## jQuery插件的封装

```js
    (function($){
        // do something
    })(jQuery);
```

闭包的作用
    --避免全局依赖
    --避免第三方破坏
    --兼容jQuery操作符‘$’和jQuery

## 开发方式

类级别组件开发
    -即给jQuery命名空间下添加新的全局函数，也称静态方法。

```js
jQuery.myPlugin = function(){
        //do something
};
```

例如： $.ajax,$.extend()

## 对象级别组件开发

-即挂在jQuery原型下的方法，这样通过选择器获取的jQuery对象实例也能共享该方法，
    也称动态方法。

```js
$.fn.myPlugin = function(){
    //do something
};
这里$.fn===$.prototype
```

例如：addClass()、attr()等，需要创建实例来调用

## 链式调用

```js
   eg: $("div").next().addClass()....
    $.fn.myPlugin = function(){
        return this.each(function(){
            //do something
        });
    };
```

代码说明：

* return this 返回当前对象，来维护插件的链式调用
* each 循环实现每个元素的访问

## 单例模式

```js
    $.fn.myPlugin  = function(){
        var me = $(this),
                instance = me.data("myPlugin");
        if(!instance){
            me.data("myPlugin",(instance= new Plugin()));
        }
    };
```

代码说明：
    -如果实例存在则不再重新创建实例
    -利用data()来存放插件对象的实例

## es6 从数组中查找一个元素

```js
let users = data.users
result = users.find(ele => {
    return ele.username === username && ele.password === password
})
```

从数组中删除某个元素

```js
splice(index, 1)
```

## 数组比较

```js
const arr1 =['a', 'b', 'c'];
const arr2 =['b', 'c', 'a'];
console.log(
    arr1.sort() === arr1,
    arr2.sort() === arr2,
    arr1.sort() === arr2.sort()
);
// true, true, false
```

解析:

arr.sort方法对原始数组进行排序，并返回该数组的引用，调用.sort(), 对数组内对象进行排序

当比较对象时，数组的排序顺序并不重要。由于arr1.sort()和arr1指向内存中的同一对象，因此第一个和第二个返回true.

arr1.sort()和arr2.sort()排序顺序相同；但他们指向内存中的不同对象，所以返回false

## 前端实现即时通讯的方式有哪些，并介绍对应的优缺点

### 短轮询

短轮询的原理很简单，每隔一段时间客户端就发出一个请求，去获取服务器最新的数据，一定程度上模拟实现了即时通讯。

优点：兼容性强，实现非常简单
缺点：延迟性高，非常消耗请求资源，影响性能

### comet

comet有两种主要实现手段， 一种是基于AJAX的长轮询(1ong-polling) 方式， 另一种是基于Iframe及html file的流(streaming) 方式，通常被叫做长连接。

a.长轮询优缺点：
优点：兼容性好，资源浪费较小
缺点：服务器hold连接会消耗资源， 返回数据顺序无保证，难于管理维护

b.长连接优缺点：
优点：兼容性好，消息即时到达，不发无用请求
缺点：服务器维护长连接消耗资源

### SSE

SSE(Server-Sent Event， 服务端推送事件) 是一种允许服务端向客户端推送新数据的HTML 5技术。

a.优点：基于HTTP而生， 因此不需要太多改造就能使用， 使用方便， 而websocket非常复杂， 必须借
助成熟的库或框架
b.缺点：基于文本传输效率没有websocket高， 不是严格的双向通信，客户端向服务端发送请求无法复用之前的连接，需要重新发出独立的请求

### Web socket

Web socket是一个全新的、独立的协议， 基于TCP协议，与http协议兼容、却不会融入http协议， 仅仅作为htmL 5的一部分， 其作用就是在服务器和客户
端之间建立实时的双向通信。
a.优点：真正意义上的实时双向通信，性能好，低延迟
b.缺点：独立与http的协议， 因此需要额外的项目改造，使用复杂度高，必须引入成熟的库，无法兼容低版本浏览器

### Service workers

Service Worker从英文翻译过来就是一个服务工人， (服务于前端页面的后台线程， 基于Web Worker实现。有着独立的js运行环境，分担、协助前端页面完成前端开发者分配的需要在后台悄悄执行的任
务。基于它可以实现拦截和处理网络请求、消息推送、静默更新、事件同步等服务。

优势及使用场景：

①离线缓存：可以将H5应用中不变化的资源或者很少变化的资源长久的存储在用户端，提升加载速度
降低流量消耗、降低服务器压力。如中重度的H5游戏、框架数据独立的web资讯客户端、web邮件客户端等

②消息推送：激活沉睡的用户，推送即时消息、公告通知，激发更新等。如web资讯客户端、web即时通讯工具、h5游戏等运营产品。

③事件同步：确保web端产生的任务即使在用户关闭了web页面也可以顺利完成。如web邮件客户端、web即时通讯工具等。

④定时同步：周期性的触发Service Worker脚中的定时同事件，可借助它提前刷新缓存内容。如web资讯客户端。

## 数组push

```js
function addToList(item, list) {
    return list.push(item);
}
const result = addToList('abc', ['de']);
console.log(result);
// 结果是2
```

push方法返回新数组的长度
push方法修改原始数组，如果想从函数返回数组而不是数组长度，应该先push，后返回

```js
list.push(item);
return list;
```

## 实现Promise.all

思路

1. 接收一个Promise实例的数组或具有Iterator接口的对象作为参数
2. 这个方法返回一个新的promise对象
3. 遍历传入的参数，用promise.resolve()将参数包一层，使其变成一个promise对象
4. 参数所有回调成功才是成功，返回值数组与参数顺序一致
5. 参数数组其中一个失败，则触发失败状态，第一个触发失败的Promise错误信息作为Promise.all的错误信息

扩展

一般来说，Promise.all用来处理多个并发请求，也是为了页面数据构造的方便，将一个页面所用到的在不同接口的数据一起请求过来。
不过如果其中一个借口失败了，多个请求也就失败了，页面可能啥也出不来，这就看当前页面的耦合程度了。

```js

function promiseAll(promises) {
    return new Promise((resolve, reject) => {
        if (!Array.isArray(promises)) {
            throw new TypeError('argument must be a array')
        }
        let resolvedCounter = 0;
        let promiseNum = promises.length;
        let resolvedResult = [];
        for(let i=0;i<promiseNum;i++) {
            Promise.resolve(promises[i]).then(value => {
                resolvedCounter++;
                resolvedResult[i] = value;
                if (resolvedCounter === promiseNum) {
                    return resolve(resolvedResult)
                }
            }, error => {
                return reject(error)
            })
        }

    })
}
// test
let p1 = new Promise((resolve, reject) => {
    setTimeout(() => {
        resolve(1)
    }, 1000)
})
let p2 = new Promise((resolve, reject) => {
    setTimeout(() => {
        resolve(2)
    }, 2000)
})
let p3 = new Promise((resolve, reject) => {
    setTimeout(() => {
        resolve(3)
    }, 3000)
})
promiseAll([p3, p1, p2]).then(res => {
    console.log(res)
});
```
