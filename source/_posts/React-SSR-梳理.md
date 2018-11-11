---
title: React SSR 梳理
date: 2018-11-11 20:22:41
updated: 2018-11-11 20:22:41
tags:
- React
- SSR
---
[参考链接](https://mp.weixin.qq.com/s/BXC6tZyY6fsi8l8dJ40nug)
# 基本概念
什么是服务器端渲染？什么是客户端渲染？什么是同构？

1. 客户端渲染 CSR
页面初始加载的HTML中无网页展示内容，需要加载JavaScript中的React代码,通过JavaScript渲染生成页面，
同时，JavaScript代码会完成页面交互事件的绑定。

流程如下：
1. 服务端返回HTML到浏览器
2. 浏览器下载JS
3. 浏览器执行js, React-------在这之前都是loading(包括3)
4. 页面显示，可交互

2. 服务器渲染
用户请求服务器，服务器上直接生成HTML内容并返回浏览器。页面内容直接由Server端生成。
服务器端渲染的页面交互能力有限，要实现复杂交互，还是要通过引入JavaScript文件来辅助实现。

3. 同构SSR
这个概念存在于Vue， React这些新型的前端框架中，同构实际是客户端渲染和服务器渲染的一个整合。
把页面的展示内容和交互写在一起，让代码执行两次。服务器端执行一次，用于实现服务器端渲染，
客户端再执行一次，用于接管页面交互。

流程如下：
1. 服务器发送已经渲染好的HTML到浏览器----仅在这一过程页面loading
2. 浏览器渲染页面,页面显示，开始下载JS
3. 浏览器执行JS/React
4. 页面可交互


# 为什么使用SSR技术
主要因素：
1. CSR项目的TTFP(Time To First Page)时间较长。加载HTML，下载JavaScript，JavaScript渲染生成页面。
在这个渲染过程中至少涉及到两个HTTP请求周期，所以会有一定的耗时。这也是为什么低俗网络下，初始页面会有白屏的原因。
2. CSR项目的SEO能力极弱。搜索引擎主要识别的内容还是HTML，对JavaScript文件内容的识别都还比较弱。


SSR的产生，主要就是为了解决上面两个问题。在React中使用SSR，让React在服务器端先执行一次，使得用户下载的HTML
已经包含了所有的页面展示内容，这样页面展示的过程只需经历一个HTTP请求周期，TTFP时间得到一倍以上缩减。同时HTML
中已经包含了网页的所有内容，SEO效果也会变得非常好。

之后React在客户端再次执行，为HTML中的内容添加数据及事件的绑定，页面就具备了React的各种交互能力。


# SSR技术架构图
```
客户端(浏览器)          Node服务器                    API服务器
访问地址---------      1.接收请求
                      2.路由分析获取即将展示的组件信息
                      3. 获取组件所需数据-----------  4.接收请求，返回接口数据
6.显示HTML,            5.渲染组件，返回渲染后的HTML
加载需要的bundle.js     (服务端渲染完成)                 
7.获取bundle.js文件    8.接收请求
                      9.返回bundle.js                    
10. 加载运行bundle.js
进行客户端渲染
11. bundle.js发送请求   12.收到请求，代理到业务接口    13. 接受请求，返回接口数据
                       14.获取到数据返回
15.获取到请求数据，
完成客户端渲染
```

使用SSR使得原本简单的React项目变得非常复杂，项目的可维护性降低，代码追溯变得困难。
有时这些副作用比起优势要大得多。一般除非特别依赖搜索引擎流量，或对首屏时间有特殊要求，不建议使用SSR。


# SSR技术难点剖析

## 虚拟DOM和SSR的关系
**SSR之所以能实现，本质上上因为虚拟DOM的存在**

SSR的工程中，React代码会在客户端和服务端各执行一次。如果React代码中存在直接操作DOM的代码，那么就无法实现SSR
这种技术。因为在node环境中，没有DOM这个概念存在。所以这些代码在node环境下会报错。

虚拟DOM是真实DOM的一个JavaScript对象映射。React在做页面操作时，实际上不是直接操作DOM，而是操作虚拟DOM，
也就是操作普通JavaScript对象，这就使得SSR成为了可能。

在服务端，可以操作JavaScript对象，判断环境是服务器环境，把虚拟DOM映射成字符串输出；
在客户端，操作JavaScript对象，判断是客户端环境，将虚拟DOM映射成真实DOM，完成页面挂载。

## 细说流程图

第3步：服务器要根据请求地址，判断展示什么页面。这一步叫做服务器端路由。
第10步：客户端接收到JavaScript文件后，要根据当前路径，在浏览器上再判断当前要展示的组件，重新进行一次客户端渲染，
这时，还要经历一次客户端路由(前端路由)


### SSR中客户端渲染与服务端渲染路由代码差异
实现React的SSR架构，需要让相同的React代码在客户端和服务端各执行一次。
这里说的相同的React代码，指的是各种组件代码，所以在同构中，只有组件代码是可以共用的。
而路由这样的代码是没有办法公用的。

原因：
服务端需要通过请求路径，找到路由组件；在客户端需通过浏览器中的网址，找到路由组件，是完全不同的两套机制。
所以这部分代码肯定无法公用。

代码示例：
客户端路由
```javascript
const App = () => {
  return (
    <Provider store={store}>
      <BrowserRouter>
        <div>
          <Route path='/' component={Home}>
          </div>
      </BrowserRouter>
    </Provider>
  )
}
ReactDom.render(<App/>, document.querySelector('#root'))
```

服务端路由：
```javascript
const App = () => {
  return 
    <Provider store={store}>
      <StaticRouter location={req.path} context={context}>
        <div>
          <Route path='/' component={Home}>
        </div>
      </StaticRouter>
    </Provider>
}
return ReactDom.renderToString(<App/>)
```
服务端路由代码相对复杂点，需要把location(当前请求路径)传递给StaticRouter组件，这样StaticRouter才能根据
路径分析出当前所需要的组件是哪个。
> StaticRouter是React-Router针对服务端渲染专门提供的一个路由组件

BrowerRouter能够匹配到浏览器即将显示的路由组件，对浏览器来说，需要将组件转化成DOM，用ReactDom.render进行DOM挂载。

StaticRouter能够在服务器端匹配到将要显示的组件，对服务端来说，需要将组件转化成字符串，用ReactDom.renderToString方法，就可以及时得到App组件对应的HTML字符串

对一个React应用来说，路由一般是整个程序的执行入口，在SSR中，服务端的路由和客户端的路由不一样，
意味着服务端的入口代码和客户端的入口代码是不同的。

所以，针对代码运行环境的不同，要进行有区别的webpack打包。

### 服务端和客户端代码的打包差异



