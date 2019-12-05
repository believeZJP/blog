---
title: Koa2 进阶
date: 2019-12-05 16:52:32
updated: 2019-12-05 16:52:32
tags:
---

> Koa2是现在最流行的基于Node.js平台的web开发框架，它很小，但扩展性很强。Koa给人一种干净利落的感觉，体积小、编程方式干净。
> 使用 koa 编写 web 应用，通过组合不同的 generator，可以免除重复繁琐的回调函数嵌套，并极大地提升错误处理的效率。一个Koa应用就是一个对象，包含了一个middleware数组，这个数组由一组Generator函数组成。这些函数负责对HTTP请求进行各种加工，比如生成缓存、指定代理、请求重定向等等。这些中间件函数基于 request 请求以一个类似于栈的结构组成并依次执行。

前置知识：
js,ES6,node ,npm

# 第一节 Koa开发环境搭建

1. 新建目录

```
mkdir koa2Tutorial
cd koa2Tutorial
```

2. 生成package.json 文件

```
npm init -y
```

3. 安装koa包

```
npm install --save koa
```

4. coding

开始编写koa启动代码

```
const Koa = require('koa')
const app = new Koa()

app.use( async (ctx) => {
  ctx.body = 'Hello Koa2'  
})

app.listen(8040)
console.log('[demo] start quick is starting at port 8040')

```

5. 启动

在命令行输入

```
node index.js
```

在浏览器中输入： localhost:8040就能看到结果了

# 第2节 async/await 使用方法

什么是async和await

async是异步的简写

await这里是async await简写

async是声明一个方法是异步的，await是等待异步完成。

注意await必须是在async方法中才可以使用因为await访问本身会造成程序停止，所以必须在异步方法中才可以使用

## async 到底起什么作用

async是让方法变成异步，关键是他的返回值是什么，得到后如何处理？

看一下async方法的返回值

```
async function testAsync() {
    return 'Hello Async'
}

const result = testAsync()
console.log(result)
```

在终端中运行node testAsync.js，发现返回的是Promise

```
node test.js
Promise { 'Hello async' }
```

## await在等什么

await一般是在等async方法执行完毕。但其实await等待的只是一个表达式(Promise对象)，也可以接收普通值。看代码：

```

function getSomething(){
    return 'something'
}

async function testAsync(){
    return 'Hello Async'
}

async function test () {
    const v1 = await getSomething()
    const v2 = await testAsync()
    console.log(v1, v2)
}

test()
```

上面代码一个是异步函数，一个是普通函数。

可以看到都是直接返回结果。

## async/await 同时使用

通过前面两个例子，已经分别了解到async和await。现在做个虚假的例子，看下等待问题。

```
function takeLongTime(){
    return new Promise(resolve => {
        setTimeout(() => {
            resolve('long_time_value')
        }, 1000)
    })
}

async function test(){
    const v = await takeLongTime()
    console.log(v)
}

test()
```

# 第3节 Get请求接收

这节课看一下Koa如何处理get请求

### query和querystring区别

在Koa2中，Get请求通过request接收，但接收方法有两种：query和querystring。

- query： 返回的是格式化好的参数对象
- querystring： 返回的是请求字符串

写个简单的例子看下输出结果。

demo1.js

```
const Koa = require('koa')
const app = new Koa()

app.use( async (ctx) => {
 let url = ctx.url
 let request = ctx.request
 let req_query = ctx.request.query
 let req_querystring = ctx.request.querystring
   ctx.body = {
    url,
    req_query,
    req_querystring
   }
})

app.listen(8040)
console.log('[demo] start quick is starting at port 8040')
```

上面的代码，在body中返回了从ctx中取到的url, request, requeststring.

在终端用node demo1.js启动服务，在浏览器输入查看页面效果

```
http://localhost:8040/?user=admin&age=18
```

页面输出的结果

```
{"url":"/?user=admin&age=18","req_query":{"user":"admin","age":"18"},"req_querystring":"user=admin&age=18"}
```

### 直接从ctx中获取Get请求

上面代码是在ctx.request中获取的request和requeststring，

还可以直接从ctx中得到Get请求。

```
const Koa = require('koa')
const app = new Koa()

app.use( async (ctx) => {
 let url = ctx.url
 
 // 从 request 中获取GET请求
 let request = ctx.request
 let req_query = ctx.request.query
 let req_querystring = ctx.request.querystring

 // 从上下文获取GET请求
 let ctx_query = ctx.query
 let ctx_querystring = ctx.querystring


   ctx.body = {
    url,
    req_query,
    req_querystring,
    ctx_query,
    ctx_querystring
   }
})

app.listen(8040)
console.log('[demo] start quick is starting at port 8040')

```

可以在浏览器中看效果。

### 总结

- 获取GET请求方式有两种
    1. 从request获取
    2. 从ctx中获取。

- 获取的格式也有两种
    1. request
    2. requeststring

# 第4节 POST请求如何接收(1)

这节学习POST请求的接收方法。

对于POST，Koa2没有封装方便的获取参数方法，需要通过解析上下文context中的原生node.js请求对象req来获取。

获取Post请求的步骤：

1. 解析上下文ctx中的原生node.js对象req
2. 将post表单数据解析成query string 字符串。
3. 将字符串转换成JSON

ctx.request和ctx.req区别
-

- ctx.request:是Koa2中context经过封装的请求对象，用起来更简单直观
- ctx.req: 是context提供的node.js原生HTTP请求对象。可以得到更多的内容。

## ctx.mothed得到的请求类型

Koa2提供了ctx.method属性，来获取请求类型。根据不同类型编写不同的响应。在工作中很常用。

先做个小例子。根据请求类型获取不同的页面内容。GET请求时得到表单填写页面，POST请求时，得到POST处理页面。

```
const Koa = require('koa')
const app = new Koa()

app.use( async (ctx) => {
    // 当请求是get时，显示表单让用户填写
    if(ctx.url === '/' && ctx.method === 'GET'){
        let html = `
            <h1>Koa2 request post demo</h1>
            <form method="POST"  action="/">
                <p>userName</p>
                <input name="userName" /> <br/>
                <p>age</p>
                <input name="age" /> <br/>
                <p>webSite</p>
                <input name='webSite' /><br/>
                <button type="submit">submit</button>
            </form>
        `
        ctx.body = html
    }else if(ctx.url === '/' && ctx.method === 'POST'){
        ctx.body = '接收到的请求'
    }else {
        ctx.body = `
            <h1>404</h1>
        `
    }

})

app.listen(8040)
console.log('[demo] start quick is starting at port 8040')
```

写完执行node index.js，在浏览器中输入<http://localhost:8040/，第一次展现的是表单页面，点击提交后，返回接收到的请求。输入其他地址，返回404.>

## 总结

这节课理论上学习了如何获取POST请求参数。
学习了如何获取请求类型，ctx.method,并编写了一个小案例。

# 第5节 POST请求如何接收参数(2)

这节课具体学习怎么解析POST参数。

### 解析Node原生POST参数

先声明一个对象，用Promise对象解析。这里使用ctx.req.on接收事件。

```
function parsePostData(ctx) {
    return new Promise((resolve, reject) => {
        try{
            let postData = ''
            ctx.req.on('data', (data) => {
                postData += data
            })

            ctx.req.addListener('end', function(){
                resolve(postData)
            })
        }catch(err){
            reject(err)
        }
    })
}
```

修改上节接收POST请求的处理方法，如下

```
// ctx.body = '接收到的请求'
let postData = await parsePostData(ctx)
ctx.body = postData
```

现在，点击提交可以看到返回字符串

### POST字符串解析成JSON对象

上面返回的是字符串，这里写一个封装JSON对象的方法

```
function parseQueryStr(queryStr) {
    let queryData = {}
    let queryStrList = queryStr.split('&')
    console.log(queryStrList)
    for(let [index, queryStr] of queryStrList.entries()) {
        let itemList = queryStr.split('=')
        console.log(itemList, 'item')
        queryData[itemList[0]] = decodeURIComponent(itemList[1]);
    }
    return queryData
}
```

修改parsePostData中resolve返回前的调用

```

// 处理post参数，合并为字符串
function parsePostData(ctx) {
    return new Promise((resolve, reject) => {
        try{
            let postData = ''
            ctx.req.on('data', (data) => {
                postData += data
            })

            ctx.req.addListener('end', function(){
                let parseData = parseQueryStr(postData)
                resolve(parseData)

            })
        }catch(err){
            reject(err)
        }
    })
}
```

现在返回的是json对象。

# 第6节 koa-bodyparser中间件

上面已经学会如何自己编写代码接收并解析POST请求。有现成的工具可以直接使用，koa-bodyparser.

这种轮子叫做中间件。对于POST请求的处理，koa-bodyparser中间件可以把koa2上下文呢的formData数据解析到ctx.request.body中

1. 安装中间件

```
npm install --save koa-bodyparser
```

2. 引用

```
const bodyParser = require('koa-bodyparser')

app.use(bodyParser)
```

3. 直接用ctx.request.body获取POST请求参数，中间件自动做了解析

```

const Koa = require('koa')
const app = new Koa()
const bodyParser = require('koa-bodyparser')

// app.use(bodyParser)  错误写法！！！！！！！！！！！！！！！！！
app.use(bodyParser())

app.use( async (ctx) => {
    // 当请求是get时，显示表单让用户填写
    if(ctx.url === '/' && ctx.method === 'GET'){
        let html = `
            <h1>Koa2 request post demo</h1>
            <form method="POST"  action="/">
                <p>userName</p>
                <input name="userName" /> <br/>
                <p>age</p>
                <input name="age" /> <br/>
                <p>webSite</p>
                <input name='webSite' /><br/>
                <button type="submit">submit</button>
            </form>
        `
        ctx.body = html
    }else if(ctx.url === '/' && ctx.method === 'POST'){
        // ctx.body = '接收到的请求'
        // 这里是新增的
        let postData = ctx.request.body
        ctx.body = postData
    }else {
        ctx.body = `
            <h1>404</h1>
        `
    }

})

app.listen(8040)
console.log('[demo] start quick is starting at port 8040')
```

## 经验

注意在引用时，切记 ==app.use(bodyParser())== 中的括号，不写括号会报错

```
koa-bodyparser ctx.onerror is not a function
```

# 第7节 Koa2原生路由实现

路由用来根据不同的url切换显示的页面内容。这节课不借助中间件，用原生方法实现简单路由。

### ctx.request.url

要实现路由，需要得到地址栏的请求路径。根据路径的不同进行跳转。

通过一个简单的例子，了解如何通过ctx.request.url来获取访问路径。

```
const Koa = require('koa')
const app = new Koa()

app.use(bodyParser())

app.use( async (ctx) => {
    let url = ctx.request.url
    ctx.body = url

})

app.listen(8040)
```

这时，访问<http://localhost:8040/demo,页面输出/demo。>

根据这个，可以获取到不同的请求链接。

### 原生路由实现

大体思路：

1. 根据传入的url，选择对应的页面名称
2. 调用fs读取文件，将文件内容传给ctx.body。
3. 页面显示

### 注意

case中写选项时，要注意url的全路径，刚开始写的'todo', '404' 这是不生效的，
要写成'/todo', '/404'

```
const fs = require('fs')
const Koa = require('koa')
const app = new Koa()

app.use( async (ctx) => {
    let url = ctx.request.url

    ctx.body = await router(url)

})

async function router(url) {
    let page = '404.html'
    switch(url) {
        case '/':
            page = 'index.html'
            break
        case '/index':
            page = 'index.html'
            break
        case '/todo':
            page = 'todo.html'
            break
        case '/404':
            page = '404.html'
            break
        default:
            break
    }
    // 用异步来接收html，防止页面卡死
    let html = await render(page)
    return html
}

function render(page){
    return new Promise((resolve, reject)=>{
        let pageUrl = `./page/${page}`
        fs.readFile(pageUrl, 'UTF-8', (err, data)=>{
            if(err){
                reject(err)
            }else{
                resolve(data)
            }
        })
    })
}


app.listen(8040)
console.log('[demo] start quick is starting at port 8040')

```

## 总结

    这节课了解了如何原生实现路由。

# 第8节 Koa-router中间件入门(1)

上节写的路由只是很简单的例子，实际项目中都会用开源的中间件来完成路由配置。

这节课用koa-router来实现。

## 1. 安装koa

```
npm install --save koa-router
```

## 2. koa基础案例

先写一个最简单的koa例子。

1. 引入
2. 新建一个实例
3. 不同路由配置
4. use

```
const Koa = require('koa')
const Router = require('koa-router')

const app = new Koa()
const router = new Router()

router.get('/', function(ctx, next){
    ctx.body = 'Hello Koa2'
})

app.use(router.routes())
    .use(router.allowedMethods())

app.listen(8040, ()=>{
    console.log('[demo] start quick is starting at port 8040')
})
```

## 多页面配置

多页面配置，只需要加get,post即可。现在增加一个todo页面。

```
const Koa = require('koa')
const Router = require('koa-router')

const app = new Koa()
const router = new Router()

router.get('/', function(ctx, next){
    ctx.body = 'Hello Koa2'
})
.get('/todo', function(ctx, next){
    ctx.body = 'Todo Page'
})


app.use(router.routes())
    .use(router.allowedMethods())

app.listen(8040, ()=>{
    console.log('[demo] start quick is starting at port 8040')
})

```

分别访问<http://localhost:8040> 和<http://localhost:8040/todo，可以看到不同的结果。>

# 第9节 Koa-router中间件 层级(2)

## 设置前缀

有时需要把所有路径前加一个层级，例如， <http://localhost:8040/todo> 加一个demo层级，变成<http://localhost:8040/demo/todo.>

路由在创建时可以指定一个前缀。这个前缀会被添加到路由最顶层。

```
const router = new Router({
    prefix: '/demo'
})

```

访问：

<http://localhost:8040/demo/todo>

http://localhost:8040/demo

可以看到页面，访问原来的路径，会提示Not Found

## 路由层级

上面是为全局设置层级，这里为单个页面设置层级，只要在use时，使用路径就可以了。

这里演示两个不同层级的路由设置。一个是home,一个是page,通过use赋予不同的前层级。

```
// 使用koa-router

const Koa = require('koa')
const Router = require('koa-router')

const app = new Koa()

// 两个单独的路由
let home = new Router()
home.get('/koa', async(ctx) =>{
    ctx.body = 'Hello Koa'
})
.get('/todo', async(ctx) => {
    ctx.body = 'learning Koa'
})

let page = new Router()
page.get('/koa', async(ctx) =>{
    ctx.body = 'Hello Koa Page'
})
.get('/todo', async(ctx) => {
    ctx.body = 'learning Koa Page'
})

// 装载所有子路由
let router = new Router()
router.use('/home', home.routes(), home.allowedMethods())
router.use('/page', page.routes(), page.allowedMethods())

// 加载路由中间件
app.use(router.routes()).use(router.allowedMethods())


app.listen(8040, ()=>{
    console.log('[demo] start quick is starting at port 8040')
})
```

分别访问/home/todo,/home/koa,/page/todo, /page/koa可以看到结果。

# 第10节 Koa-router 中间件参数 (3)

这节学习如何传参

用ctx.query接收参数

# 第11节 Koa中使用Cookie

这节学习操作cookie。

Koa的上下文(ctx)直接提供了读取和写入的方法。

- ctx.cookies.get(name, [options]): 读取cookie
- ctx.cookies.set(name, value, [options]): 写入cookie

这里的cookie是写入浏览器中了？？？

代码

```
// 操作cookie

const Koa = require('koa')

const app = new Koa()

app.use(async(ctx) => {
    if(ctx.url === '/index'){
        ctx.cookies.set('name', 'Hello Koa')
        ctx.body = 'cookie is set.'
    }else{
        ctx.body = 'Hello Koa'
    }
})


app.listen(8040, ()=>{
    console.log('[demo] start quick is starting at port 8040')
})
```

访问localhost:8040/index ，按F12可以看到cookies

### Cookie选项

一些配置项

- domain: cookie所在域名
- path: 所在路径
- maxAge: 最大有效时长
- expires: cookie失效时间
- httpOnly: 是否只从http请求中获取
- overwrite: 是否允许重写

```
ctx.cookies.set('name', 'Hello Koa',{
    domain:'localhost', // 写cookie所在的域名
    path:'/index',       // 写cookie所在的路径
    maxAge:1000*60*60*24,   // cookie有效时长
    expires:new Date('2018-12-31'), // cookie失效时间
    httpOnly:false,  // 是否只用于http请求中获取
    overwrite:false  // 是否允许重写
})
```

### 读取cookie

用ctx.cookies.get()来读取

```
if(ctx.cookies.get('name')){
    ctx.body = ctx.cookies.get('name')
}else{
    ctx.body = 'No cookie is set~~'
}
```

注意，如果上面的path设置的是index的话，访问localhost:8040是获取不到name这个cookie的,
需要将path设为''

# 第12节 Koa2 的模板初识 (ejs)

开发不可能把所有的html代码全加载到JS里，也没办法完成大型web开发。必须借用模板来帮助我们开发。

这节简单了解一下Koa2的模板机制。需要靠中间件来完成开发。

### 安装中间件

```
npm install --save koa-views
```

### 安装 ejs 模板引擎

ejs是著名并且强大的模板引擎，可以单独安装。

```
npm install --save ejs
```

### 编写模板

为了模板统一管理，新建一个view文件夹，并新建index.ejs文件

views/index.ejs

```
// 引用ejs模板

const Koa = require('koa')
const views = require('koa-views')
const path = require('path')

const app = new Koa()

app.use(views(path.join(__dirname, './views'), {
    extension: 'ejs'
}))

app.use(async(ctx)=> {
    let title = 'Hello Koa2'
    await ctx.render('index', {
        title
    })
})


app.listen(8040, ()=>{
    console.log('[demo] start quick is starting at port 8040')
})
```

## 总结

这里只是简单的讲解了koa2的模板机制。

# 第13节： koa-static静态资源中间件

开发中不只要处理业务逻辑请求，也会有很多静态资源请求，如js, css, jpg, png 这些静态请求。有时候也会访问静态资源路径

用koa可以直接访问这些静态文件，但代码会冗长，这节课利用 koa-static 来实现静态资源访问。

### 安装koa-static

```
npm install --save koa-static
```

### 新建 static 文件夹

在static文件夹中放js, css, img
koa.png, test.js, style.css

### 使用koa-static

```
// 引用静态资源

const Koa = require('koa')
const path = require('path')
const static = require('koa-static')

const app = new Koa()

const staticPath = './static'

app.use(static(path.join(__dirname, staticPath)))

app.use( async ( ctx ) => {
    ctx.body = '访问静态资源试试 koa.png, test.js, style.css'
  })
  
app.listen(8040, ()=>{
    console.log('[demo] start quick is starting at port 8040')
})
```

在浏览器中访问：

<http://localhost:8040/style.css>

<http://localhost:8040/test.js>

<http://localhost:8040/koa.png>
