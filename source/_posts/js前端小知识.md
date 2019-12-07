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
