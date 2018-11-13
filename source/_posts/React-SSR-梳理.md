---
title: React SSR 梳理
date: 2018-11-11 20:22:41
updated: 2018-11-11 20:22:41
tags:
- React
- SSR
---
# 基本概念
什么是服务器端渲染？什么是客户端渲染？什么是同构？

1. 客户端渲染 CSR
页面初始加载的HTML中无网页展示内容，需要加载JavaScript中的React代码,通过JavaScript渲染生成页面，
同时，JavaScript代码会完成页面交互事件的绑定。

<!-- more -->

流程如下：
1. 服务端返回HTML到浏览器
2. 浏览器下载JS
3. 浏览器执行js, React-------在这之前都是loading(包括3)
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
3. 减少API请求次数

SSR的产生，主要就是为了解决上面两个问题。在React中使用SSR，让React在服务器端先执行一次，使得用户下载的HTML
已经包含了所有的页面展示内容，这样页面展示的过程只需经历一个HTTP请求周期，TTFP时间得到一倍以上缩减。同时HTML
中已经包含了网页的所有内容，SEO效果也会变得非常好。

之后React在客户端再次执行，为HTML中的内容添加数据及事件的绑定，页面就具备了React的各种交互能力。

> 主要区别：客户端从无到有的渲染，服务端是先在服务端渲染一部分，在再客户端渲染一小部分。



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
# 缺点
使用SSR使得原本简单的React项目变得非常复杂，项目的可维护性降低，代码追溯变得困难。
有时这些副作用比起优势要大得多。一般除非特别依赖搜索引擎流量，或对首屏时间有特殊要求，不建议使用SSR。
只有NodeJS环境可以SSR：若后端使用python或是ruby等语言，处理React SSR就要多开一台NodeJS Render Server，多了维护上的麻烦。


# SSR技术难点剖析

## 虚拟DOM和SSR的关系
**SSR之所以能实现，本质上上因为虚拟DOM的存在**

SSR的工程中，React代码会在客户端和服务端各执行一次。如果React代码中存在直接操作DOM的代码，那么就无法实现SSR
这种技术。因为在node环境中，没有DOM这个概念存在。所以这些代码在node环境下会报错。

虚拟DOM是真实DOM的一个JavaScript对象映射。React在做页面操作时，实际上不是直接操作DOM，而是操作虚拟DOM，
也就是操作普通JavaScript对象，这就使得SSR成为了可能。

在服务端，可以操作JavaScript对象，判断环境是服务器环境，把虚拟DOM映射成字符串输出；
在客户端，操作JavaScript对象，判断是客户端环境，将虚拟DOM映射成真实DOM，完成页面挂载。

## 细说流程图

第3步：服务器要根据请求地址，判断展示什么页面。这一步叫做服务器端路由。
第10步：客户端接收到JavaScript文件后，要根据当前路径，在浏览器上再判断当前要展示的组件，重新进行一次客户端渲染，
这时，还要经历一次客户端路由(前端路由)


### SSR中客户端渲染与服务端渲染路由代码差异
实现React的SSR架构，需要让相同的React代码在客户端和服务端各执行一次。
这里说的相同的React代码，指的是各种组件代码，所以在同构中，只有组件代码是可以共用的。
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

客户端webpack配置
```javascript
{
  entry: './src/client/index.js',
  output: {
    filename: 'index.js',
    path: path.resolve(__dirname, 'public')
  },
  module: {
    rules: [{
      test: /\.js?$/,
      loader: 'babel-loader'
    },{
      test: /\.css?$/,
      use: ['style-loader', {
        loader: 'css-loader',
        options: {modules: true}
      }]
    },{
      test: /\.(png|jpeg|jpg|gif|svg)?$/,
      loader: 'url-loader',
      options: {
        limit: 8000,
        publicPath: '/'
      }
    }]
  }
}

```

### 服务端webpack配置
```javascript
{
// 这里不同
  target: 'node',
//   entry不同
  entry: './src/server/index.js',
  output: {
    filename: 'bundle.js',
    // 输出路径不同
    path: path.resolve(__dirname, 'build')
  },
//   这里不同
  externals: [nodeExternals()],
  module: {
    rules: [{
      test: /\.js?$/,
      loader: 'babel-loader'
    },{
      test: /\.css?$/,
      // 这里不同
      use: ['isomorphic-style-loader', {
        loader: 'css-loader',
        options: {modules: true}
      }]
    },{
      test: /\.(png|jpeg|jpg|gif|svg)?$/,
      loader: 'url-loader',
      options: {
        limit: 8000,
        // 这里不同
        outputPath: '../public/',
        publicPath: '/'
      }
    }]
  }
};
```

可以看到，服务端渲染和客户端配置是有差异的。

- node核心模块: 在服务端运行的代码，需要引入Node的一些核心模块。在模块打包时，需要Webpack识别出类似的核心模块，
一旦发现是核心模块，不必把模块的代码合并到最终生成的代码中。
解决这个问题，只需在服务端webpack中加入`target: node`。

- 第三方模块: 服务端渲染的代码，如果加载第三方模块，这些模块不用打包到最终源码中，因为Node环境下通过NPM已经
安装了这些包，直接引用就行，不需要额外再打包到代码里。
解决这个问题，可以使用[webpack-node-externals插件](https://www.npmjs.com/package/webpack-node-externals)

- CSS样式饮用: React代码中引入CSS样式代码，服务端打包的过程会处理一遍CSS，客户端又会处理一遍。
解决：服务端使用[isomorphic-style-loader](https://www.npmjs.com/package/isomorphic-style-loader)
它处理CSS时，只在对应的DOM元素上生成class类，返回生成的CSS样式代码。
                ---看文档有点没懂，还要改组件代码?需要测一下

- 图片引入: 图片等类型文件的引入，url-loader会在服务端和客户端打包的过程中分别打包。上述配置无论服务端还是
客户端打包，都把打包生成的文件存储在public目录下，这样虽然打包出来两遍，但后打包的会覆盖之前文件，看起来只有
一份文件。
这样做性能优雅性不高，可以让图片大打包只进行一次，借助webpack的插件或自己写loader。

---
**如果React的应用中没有一部数据的获取。单纯的做静态展示。经过上面配置，简单的SSR应用就可以实现了**

---

# 异步数据获取 + Redux使用

客户端渲染，异步数据结合Redux的使用方式遵循下面的流程(对应上面12步):
1. 创建Store
2. 根据路由显示组件
3. 派发Action获取数据
4. 更新Store中的数据
5. 组件Rerender

服务端，页面一旦确定，就没法Rerender了，这就要求组件显示时，把Store的数据都准备好。
所以服务端流程如下(对应第4步)：
1. 创建Store
2. 根据路由分析Store中需要的数据
3. 派发Action
4. 更新Store中的数据
5. 结合数据和组件生成HTML，一次性返回


## 分析服务端渲染流程
- 创建Store: 客户端渲染中，用户浏览器中永远只存在一个Store，所以代码如下：
```JavaScript
const store = createStore(reducer, defaultState)
export default store;
```
而在服务端的Store是所有用户共用的。如果如上创建Store，Store变成一个单例，所有用户共享Store，显示就有问题了。
所以在服务端渲染中，Store创建如下，返回一个函数，每个用户访问时，这个函数重新执行，为每个用户提供独立的Store：
```JavaScript
const getStore = (req) => {
  return createStore(reducer, defaultState);
}
export default getStore;
```
- 根据路由分析Store中需要的数据
在服务端，需要分析当前路由要加载的所有组件，借助第三方包，比如[react-router-config](https://www.npmjs.com/package/react-router-config).(所有路由path都要改为绝对路径)
这个包会根据传入服务的请求路径，分析出这个路径下要展示的所有组件。

- 派发Action获取数据
在**每个组件**上增加一个获取数据的方法：
```JavaScript
Home.loadData = (store) => {
    return store.dispatch(getHomeList())
}
```
需要将服务端渲染的Store传进来，它的作用就是帮助服务端的Store获取到这个组件所需的数据。所以组件有了这样的方法，
同时我们也有当前路由所需要的所有组件，依次调用各个组件上的loadData方法，就能获取到路由所需的所有数据内容.

- 更新Store中的数据
需要在生成HTML之前，保证所有的数据都获取完毕。怎么处理？
```JavaScript
// matchedRoutes 是当前路由对应的所有需要显示的组件集合
matchedRoutes.forEach(item => {
  if (item.route.loadData) {
    const promise = new Promise((resolve, reject) => {
      item.route.loadData(store).then(resolve).catch(resolve);
    })
    promises.push(promise);
  }
})
Promise.all(promises).then(() => {
  // 生成 HTML 逻辑
})
```
构建Promise队列，等待所有Promise都执行结束后，再生成HTML。

---
到此，就结合实现了Redux实现了SSR流程

---

服务器端渲染时，页面的数据是通过 loadData 函数来获取的。而在客户端，数据获取依然要做，
因为如果这个页面是你访问的第一个页面，那么你看到的内容是服务器端渲染出来的，
但是如果经过 react-router 路由跳转道第二个页面，
那么这个页面就完全是客户端渲染出来的了，所以客户端也要去拿数据。-------不都是通过React-router跳转的吗

客户端获取数据在componentDidMount阶段，这个阶段服务端不会执行，所以不必担心和loadData冲突。
这也是为什么数据的获取应该放到componentDidMount阶段，可以避免服务端和客户端获取数据冲突。

# Node只是一个中间层

在SSR架构中，一般node只是一个中间层，用来做React代码的服务端渲染，而node需要的数据通常由API服务器单独提供。

一是为了解耦，而是规避Node服务器的一些计算性能问题。

服务端直接请求API服务没问题，但在客户端，可能存在跨越问题。通过请求node服务器，经过代理转发，拿到API的数据。
可以通过[express-http-proxy](https://www.npmjs.com/package/express-http-proxy)这样的工具搭建proxy
代理功能，需要注意，让代理不服不仅转发请求，还要携带cookie，避免权限校验问题。
```JavaScript
// Node 代理功能实现代码
app.use('/api', proxy('http://apiServer.com', {
  proxyReqPathResolver: function (req) {
    return '/ssr' + req.url;
  }
}));
```

# 总结
整个SSR流程体系中的关键知识点和原理就讲完了。当然还有很多细节的处理。比如不同页面配置不同title和description来提示SEO，可以用[react-helmet](https://www.npmjs.com/package/react-helmet)等工具，还要工程目录的设计，404，301重定向的处理等等。需要在实践中各个击破~~


# 补充
React16.X中的SSR
1. hydrate
React在客户端渲染的render基础上，增加了新的方法hydrate.
如果尽在客户端呈现内容，使用render方法就已经够用了，如果客户端要在服务端的基础上渲染，用hydrate。使用方法：
```JavaScript
import {hydrate} from 'react-dom';
hydrate(<HomePage/>,document.getElementById('app'));
```
运行后会提示之后版本会移除render，完全用hydrate代替。

hydrate解决的是如何复用server端，ReactDOMServer的结果。

2. stream

针对renderToString和renderToStaticMarkUp提供了stream方法

- renderToNodeStream

- renderStaticNodeStream

这两个方法同样接收的参数为react element，但返回的不是HTML字符串，而是一个可读流。

React16之前用renderToString，和renderToNodeStream区别：
renderToNodeStream支持直接渲染到节点流，渲染到流可以减少TTFB时间，在文档的下一部分生成之前，将文档的开头至结尾发送到浏览器。当内容从服务器流式传输时，浏览器开始解析HTML。速度是renderToString的3倍(官方)。
```javascript
import {renderToStaticMarkup,renderToNodeStream} from 'react-dom/server'
const root = (<Provider store={store}>
                    <StaticRouter
                      location={req.url}
                      context={context}
                      >
                        <App></App>
                    </StaticRouter>
                </Provider>)
    const markupStream = renderToNodeStream(root)
    markupStream.pipe(res,{end:false})
    markupStream.on('end',()=>{
      res.end()
    })
})
```
必须包括可选参数 {end:false}告诉流当渲染完成不自动结束响应。这允许我们完成HTML主体，并在流完全写入响应后结束响应。

# 注意事项
- 尽量避免使用window等客户端变量
Server端没有window对象，如果需要使用从window开始逐级判断
- 客户端对象的判断用typeof
`if(window && window.autoScroll) => if(typeof window != "undefined" && window.autoScroll)`
- 避免往window等全局对象挂载定时器
可能内存泄漏
- 避免random()等不确定性输出(输出结果可预期，不依赖于环境等)
可能造成server端和web端DOM匹配检验不成功
- 避免使用第三方非react库
用react包装一个jQuery写的富文本编辑器


### 参考链接
- [React 中同构（SSR）原理脉络梳理](https://www.yuque.com/es2049/blog/zy0eq0)
