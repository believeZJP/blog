---
title: React全家桶视频教程
date: 2019-12-05 16:42:34
updated: 2019-12-05 16:42:34
tags:
---
## [学习网址](http://jspang.com/2017/08/15/react_basic/)

[全家桶](http://jspang.com/2017/10/22/react-all-01/)

## 第一节 React 简介

## React

React起源于Facebook的内部项目，该公司积极尝试引入HTML5技术用来架设Instagram网站，开发中发现HTML5的性能下降明显，达不到预期的效果。他们就自己开发了React框架。

[ReactJS官方地址](https://facebook.github.io/react/)

[GitHub地址](https://github.com/facebook/react)

### react 特点

- 虚拟DOM: React也是以数据驱动的，每次数据变化React都会扫码整个虚拟DOM树，自动计算与上次虚拟DOM的差异变化，然后针对需要变化的部分进行实际的浏览器DOM更新。
- 组件化： React可以从功能角度横向划分，将UI分解成不同组件，各组件都独立封装，整个UI是由一个个小组件构成的一个大组件，每个组件只关系自身的逻辑，彼此独立。
- 单项数据流：React设计者认为数据双向绑定虽然便捷，但在复杂场景下副作用也是很明显，所以React更倾向于单向的数据流动-从父节点传递到子节点。（使用ReactLink也可以实现双向绑定，但不建议使用）

## 第二节 构建：create-react-app 快速脚手架 [官网](https://github.com/facebookincubator/create-react-app)

### creat-react-app优点

- 无需配置：官方的配置堪称完美，几乎不用你再配置任何东西，就可以上手开发项目。
- 高集成性：集成了对React，JSX，ES6和Flow的支持。
- 自带服务：集成了开发服务器，你可以实现开发预览一体化。
- 热更新：保存自动更新，让你的开发更简单。
- 全兼容性：自动处理CSS的兼容问题，无需添加-webkit前缀。
- 自动发布：集成好了发布成品功能，编译后直接发布，并且包含了sourcemaps功能。

## create-react-app安装

```bash
npm install -g create-react-app
```

### 创建React项目

```bash
create-react-app react-app
```

注意： 目录名不要使用大小写。因为Linux下是严格区分大小写的。

### 启动服务

```bash
npm start
```

注意： 听懂不等于学会，一定要动手做一做。

## 第二节 构建工具 generator-react-webpack

这也是个构建工具，需要yeoman支持。

### 优点介绍

- 基于webpack构建，可以很容易的配置自己需要的webpack。
- 支持ES6，集成了Babel-Loader。
- 支持不同风格的CSS（sass，less，stylus）。
- 支持PostCSS转换样式。
- 集成了esLint功能。
- 可以轻松配置单元测试，比如Karma和Mocha

#### 安装

需要先安装yeoman

```bash
npm install -g yo
npm install -g generator-react-webpack
```

#### 创建目录

```bash
mkdir new-react-demo
```

进入文件

```bash
cd new-react-demo
```

用生成器生成项目目录

```bash
yo react-webpack
```

#### 启动

```bash
npm start
```

## 第三节 构建： webpack一步一步构建01

从头开始自己构建一个简单的React开发环境。

建立文件夹,进入文件夹

```bash
mkdir react-webpack
cd react-webpack
```

对webpack初始化

```bash
npm init
```

如果感觉一直回车麻烦，可以加-y参数，这样npm就直接生成了。

```bash
npm init -y
```

初始化后，可以安装webpack了。

```bash
npm install --save-dev webpack
```

### 配置webpack.config.js

在根目录建立webpack.config.js , 建立基本的入口出口文件

```js
var path = require('path')
module.exports = {
    // 入口文件
    entry: './app/index.js',
    // 出口文件
    output: {
        filename: 'index.js',
        path: path.resolve(__dirname, 'dist')
    }
}
```

文件配置好后， 要根据文件的结构改造项目目录。在根目录下新建app和dist文件夹，
在app文件夹里新建index.js文件

### 新建index.html

在根目录新建index.html， 并引入webpack设置中的出口文件，代码如下。

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>React全家桶</title>
    </head>
    <body>
        <!-- 引入出口文件 -->
        <script src="./dist/index.js"></script>
    </body>
</html>>

```

### 新建index.js

在/app/index.js中

```js
function component() {
    var element = document.createElement('div')
    element.innerHTML = 'Hello React'
    return element
}

document.body.appendChild(component())
```

### 加入打包命令

在package.json中，scripts属性加入build命令

```json
"scripts": {
    "build": "webpack"
},
```

在终端中输入npm run build ，就可以看到打包结果。

### 总结

到这里为止，我们正确安装了webpack，进行了出入口配置，也看到了webpack的输出效果。

### 开发服务器配置

添加实时更新的服务

### 安装webpack-dev-server

```bash
npm install --save-dev webpack-dev-server
```

安装完成后配置webpack.config.js

```js
devServer: {
    contentBase: './',
    host: 'localhost',
    compress: true,
    port: 1717
}
```

配置好后，在package.json里增加scripts命令

```
"scripts": {
    "build": "webpack",
    "server": "webpack-dev-server --open"
},
```

--open是自动打开浏览器，都配置完成后可以在终端输入npm run server 看效果

### 自动刷新浏览器

修改代码时，并不能自动刷新浏览器，查看最新效果。而是要再次npm run build才可以。
只要在出口文件配置中增加一个publicPath: 'dist/'

```js
output: {
    filename: 'index.js',
    path: path.resolve(__dirname, 'dist'),
    publicPath: 'dist/'
},
```

在index.html中引入js

```js
    <script src="./dist/index.js"></script>
```

## 总结-3

这节课主要配置webpack的基本配置。

## 第4节 构建： webpack一步一步构建02

上节对webpack进行基础配置，已经能打包到页面中。这节主要针对ES6和React配置。
学习之前需确保上节配置完成。

### Babel安装配置

webpack配置Babel需要先加入babel-loader，还需要支持es2015,React，所以安装4个包。

```bash
npm install --save-dev babel-core babel-loader babel-preset-es2015 babel-preset-react
```

安装完成后，会在package.json中看到这些包和版本信息

```json
"devDependencies": {
    "babel-core": "^6.26.0",
    "babel-loader": "^7.1.2",
    "babel-preset-es2015": "^6.24.1",
    "babel-preset-react": "^6.24.1",
    "webpack": "^3.8.1",
    "webpack-dev-server": "^2.9.4"
}
```

### 配置module

在webpack.config.js中配置module，即loader。

```js
 module: {
    loaders: [
        {
            test: /\.js$/,
            exclude: /node_modules/,
            loaders: 'babel-loader',
            query: {
                presets: ['es2015', 'react']
            }
        }
    ]
}
```

### 编写React

webpakc已经配置完成。 这里写一个React文件来测试一下。

先安装React和React-dom这两个包。

### 安装React和React-dom

```bash
npm install --save react react-dom
```

安装完成后，将app/index.js中的原生js代码改写成React代码。

index.js

```js
import React from 'react'
import ReactDOM from 'react-dom'

ReactDOM.render(
    <div>Hello Webpack</div>,
    document.getElementById('app')
)
```

这里增加了#app的div，在index.html中添加

```html
<div id="app"></div>
```

配置完成后，npm run server可以看到效果。接下来就可以愉快的开发了

## 总结-4

其实自己配置React开发环境在实际工作中并不多。因为我们的配置不是很成熟，而且支持较少。

这里学习只是为了更好的掌握React构建过程和设置参数，实际工作中尽量使用合适的脚手架工具。

## 第5节 路由： Hello React路由

通过前面4节课已经可以顺利的构建React的基本开发环境了。

这节课开始用几节课的时间全面了解一下React Router。 路由在开发过程中都会用到。它是SPA(单页应用)的基础，可以说不会路由系统就无法使用React进行编程。

其实路由可以简单的看作我们平时访问的网址或地址。这样有助于理解，但并不正确。

### router包安装

```js
npm install --save react-router react-router-dom
```

- react-router: 是基本的router包，里面含的内容较多，但是在网页开发中有很多用不到，现在市面上的课程简单基本都是这个包的教程。
- react-router-dom: 随着React生态环境的壮大，后出现的包。这个包比react-router轻巧许多。

**注意：**

安装了react-router就不用安装react-router-dom包了，这里只是为了讲课方便，所以安装了两个包。在实际开发中，请跟进需要进行安装。

安装时，使用--save，因为在生产环境中也要使用。

### 复习component

之前学过React组件如何编写，这里简单复习一下。

做一个A页面的组件

在app文件夹下新建componentA.js，引入React包，并编写A页面的组件，代码如下：

componentA.js

```js
import React from 'react'

export default class componentA extends React.Component{
    render(){
        return(
            <div>A默认组件</div>
        )
    }
}
```

这里用了ES6语法，这也是React现在推荐的，如果使用老语法会出现警告

在index.js中引入A组件，并改写渲染代码

```js
import React from 'react'
import ReactDOM from 'react-dom'
import Componenta from './componentA'

ReactDOM.render(
    <Componenta/>,
    document.getElementById('app')
)

```

预览看效果

## 经验

> 之前写的时候是 `<componentA/>`, 会报两个错误

Warning: `<componentA />` is using uppercase HTML. Always use lowercase HTML tags in React.
警告： html标签一定要用小写

Warning: The tag `<componentA>` is unrecognized in this browser. If you meant to render a React component, start its name with an uppercase letter.
警告：标签`<componentA>`作为组件，首字母要大写

## 以上就是一个组件的开发和引用

接下来仿照上面的方法开发两个新组件，ComponentB， ComponentC。代码如下

ComponentB.js

```js

import React from 'react'

export default class componentB extends React.Component{
    render(){
        return(
            <div>这是B组件</div>
        )
    }
}

```

ComponentC.js

```js

import React from 'react'

export default class componentC extends React.Component{
    render(){
        return(
            <div>这是C组件</div>
        )
    }
}

```

写完后引入到index.js 文件

```js

import Componenta from './componentA'
import Componentb from './componentb'
import Componentc from './componentc'

```

## 引入和书写路由

页面制作好后，需要路由来切换。先引入路由包，这里用到两个模块Router，route。

```js

import {BrowserRouter as Router, Route} from 'react-router-dom'

```

改写文件，增加路由设置

```js

ReactDOM.render(
    <Router>
        <div>
            <Route exact path="/" component="{Componenta}"/>
            <Route path="/componentb" component="{Componentb}"/>
            <Route path="/componentc" component="{Componentc}"/>
        </div>
    </Router>,
    document.getElementById('app')
)

```

### 注意：这里是错误的，不能加引号，正确如下

```js

ReactDOM.render(
    <Router>
        <div>
            <Route exact path="/" component={Componenta}/>
            <Route path="/componentb" component={Componentb}/>
            <Route path="/componentc" component={Componentc}/>
        </div>
    </Router>,
    document.getElementById('app')
)

```

注意，这里的exact是精确匹配的意思，如果有多层路由嵌套时，exact可以帮助我们精确匹配到想要跳转的路由

路由设置完毕还不能切换，需要做一个切换的组件。命名为\<nav/>

### 开发Nav组件

在app文件夹下新建一个nav.js，引入React和React-router-dom

```js

import React from 'react'
import {NavLink} from 'raect-router-dom'

const NavBar = () => (
    <div>
        <div>
            <NavLink exact to="/">ComponentA</NavLink><br/>
            <NavLink to="/componentb">ComponentB</NavLink><br/>
            <NavLink to="/componentc">ComponentC</NavLink>
        </div>
    </div>
)

export default NavBar

```

组件编写完成后，引入index.js，并添加\<Nav/>标签到代码里

```js

ReactDOM.render(
    <Router>
        <div>
            <Nav/>
            <Route exact path="/" component={Componenta}/>
            <Route path="/componentb" component={Componentb}/>
            <Route path="/componentc" component={Componentc}/>
        </div>
    </Router>,
    document.getElementById('app')
)

```

到这里，就可以进行预览了，也可以顺利的切换页面内容，说明路由已经起作用了。
当然这只是路由最简单的写法。

## 总结

这里编写代码的时候遇到点问题：

1. 大小写要注意

    html标签一定要用小写

    标签`<componentA>`作为组件，首字母要大写，改为`<Componenta/>`
2. 有的地方是不需要引号的

## 第6节 路由： NavLink中常用选项

上节初识了React路由，并制作了小案例。这节学习NavLink标签上的选项

## Route和NavLink的exact选项

exact 精确匹配，一般而言，React会匹配所有能匹配的路由组件，exact可以使我们的匹配更精确。

exact的值为boolean, 为true表示严格匹配，为false表示正常匹配

```js

<Route path="/" component={Componenta}/>
<Route path="/componentb" component={Componentb}/>
// 这种情况，访问/componentb，会把component组件也显示出来
```

所以，用exact来解决这个问题

```js
<Route exact path="/" component={Componenta}/>
<Route path="/componentb" component={Componentb}/>
```

>**在多层(路由)路由嵌套时也会出现这个问题，要多用exact来解决精确匹配问题**

## NavLink使用样式

怎样给NavLink添加样式呢，要先配置一下webpack.config.js文件。

先写一个css,和nav.js放在一个文件夹下，命名为nav.css

nav.css

```css
.blue{
    color: blue;
}
```

在nav.js中引入css

```js
import './nav.css'
```

这时，会报错

```js
Module parse failed: Unexpected token (1:0)
You may need an appropriate loader to handle this file type.
```

 因为webpack还不能对css文件进行正确的解析，需要加入css的loader。先用npm安装style-loader和css-loader

 ```js
 npm install --save-dev style-loader css-loader
 ```

 安装好后，在webpack.config.js里配置css的loader。如下

 ```js
 {
    test: /\.css$/,
    loader: ['style-loader', 'css-loader']
}
 ```

 配置好后，需要重启一下服务器，才可以正确解析。
 这时候，就可以在NavLink上加ClassName指定css类了。

```js
<NavLink exact to="/" className="blue">ComponentA</NavLink><br/>
```

### 直接在NavLink上写样式

除了用css文件这种方式，还可以更直接，在NavLink上写样式，看下面

```js
<NavLink to="/componentb" style={{color:'red',fontSize:'30px'}}>ComponentB</NavLink><br/>

```

这种写法虽然只管好用，但是不建议在实际开发中使用，这增加了代码耦合度，不是一种好的编程方式。
**注意，跟原生写法完全不一样** 下面是我直接写的。错误↓↓↓↓↓↓

```js
<NavLink to="/componentb" style="{{color:red;font-size:30px;}}">ComponentB</NavLink><br/>

```

- 1. style后面的不能用引号引用，是个大对象
- 2. 里面是key-value形式的，一个属性结束不是用分号
- 3. 每个属性后面都要用引号引起来。

### activeClassName

作为一个链接，是有激活状态的。它接受一个类名。现在我们在nav.css定义一个active的类，把字体设为红色

.nav.css

```css
.blue{
    color: blue;
}
.active {
    color: red;
}
```

修改NavLink标签

nav.js

```js
import React from 'react'
import {NavLink} from 'react-router-dom'
import './nav.css'

const NavBar = () => (
    <div>
        <div>
            <NavLink exact to="/" className="blue">ComponentA</NavLink><br/>
            <NavLink to="/componentb" activeClassName="active" style={{color:'#2BAB40',fontSize:'14px'}}>ComponentB</NavLink><br/>
            <NavLink to="/componentc" activeClassName="active">ComponentC</NavLink>
        </div>
    </div>
)

export default NavBar
```

## 总结-6

这节课虽然简单，但都是实际工作中常用到的小技巧，例如activeClassName，className，还有webpack配置也是必须掌握的。

一定要注意原生和React语法区别~~~~

## 第7节 路由： 404设置和跳转

项目中都要设置404页面，即路由不存在时跳转的页面。React中的404主要是靠Switch组件来完成的。

这节来学习Switch组件相关知识和跳转的相关知识。

### Switch组件的使用

1. 在index.js页面中，在引入路由的地方，引入Switch。

    ```js
    import {BrowserRouter as Router, Route, Switch} from 'react-router-dom'

    ```

2. 编写404页面
    在app文件夹下新建error.js, 封装成组件，方便路由调用

    error.js

    ```js
    import React from 'react'

    export default class error extends React.Component{
        render(){
            return(
                <h2>404页面</h2>
            )
        }
    }
    ```

3. 在nav.js中加入一个不存在的链接NavLink，以便错误时跳转到404页面

    nav.js

    ```js
    <NavLink to="/notfound" activeClassName="active">404</NavLink>

    ```

4. Switch登场，改写index.js页面，如下：

```js
import React from 'react'
import ReactDOM from 'react-dom'
import {BrowserRouter as Router, Route, Switch} from 'react-router-dom'
import Componenta from './componentA'
import Componentb from './componentB'
import Componentc from './componentC'
import Nav from './nav'
import Error from './error' // 新增

ReactDOM.render(
    <Router>
        <div>
            <Nav/>
            //新增
            <Switch>
                <Redirect from="/redirect" to="/componentb"/>
                <Route exact path="/" component={Componenta}/>
                <Route path="/componentb" component={Componentb}/>
                <Route path="/componentc" component={Componentc}/>
                <Route component={Error}/> //新增
            </Switch>
        </div>
    </Router>,
    document.getElementById('app')
)

```

> **==注意==：Switch要将Route包括在里面**

在浏览器中点击404 ，会跳转到error.js页面，这里的链接是随便写的，但是成功的跳到了错误页面。

注意顺序： 404应该在最后。

### Redirect组件使用

开发中有时需要在程序中根据业务逻辑进行跳转，或点击一个链接直接跳转到其他链接，这时，可以用Redirect组件来解决。

1. 引入Redirect组件

    在index.js中引入Redirect 组件

    ```js
    import {BrowserRouter as Router, Route, Switch, Redirect} from 'react-router-dom'

    ```

2. 加入跳转链接

    在nav.js里加入一个准备跳转的链接，如下：

    ```js
    <NavLink to="/redirect" activeClassName="active">redirect</NavLink>

    ```

    这时候点击链接会跳转到404页面，但我们希望跳转到componentB页面。

3. 加入`<Redirect>` 标签

在index.js中加入`<Redirect>`标签

```js
<Router>
    <div>
        <Nav/>
        <Switch>
            <Redirect from="/redirect" to="/componentb"/>
            <Route exact path="/" component={Componenta}/>
            <Route path="/componentb" component={Componentb}/>
            // 新增
            <Route path="/componentc" component={Componentc}/>
            <Route component={Error}/>
        </Switch>
    </div>
</Router>,

```

* from: 表示来自于什么链接，也就是当前链接是redirect时，触发跳转命令
* to: 表示要跳转到的链接，这里跳转到componentb组件。

写完后，就可以在浏览器中查看跳转效果了。

## 总结-7

设置404和跳转都要先加入Switch的支持，在制作404时，一定要把404的Route设置到所有路由的后面。

跳转时使用Redirect标签，这个很容易实现。

## 第8节： 路由: 通过路由传值的方法

开发中路由传值是必不可少的，虽然React有更优雅的方式，这里还是来学习一下路由如何传值。

## 最常见的传值

传值是比较简单的，主要依靠props接收。

基础课程中已经学了组件之间的传值方法。路由和页面之间的传值也类似。

1. 在nav.js页面传值，如下

    ```js
    <NavLink exact to="/componentc/ILoveWeb" activeClassName="active" className="blue">ComponentC传值</NavLink><br/>

    ```

    在路由后面跟了个ILoveWeb作为值传递给组件
2. Route中的设置， 用冒号来通知路由

    ```js
    <Route path="/componentc/:param" component={Componentc}/>
    ```

3. 在componentc组件中获取
    现在Componentc组件的生命周期中看一下props里有什么值。
    componentC.js

    ```js
    import React from 'react'

    export default class componentC extends React.Component{
        // 新增
        componentWillMount () {
            console.log(this.props)
        }

        render(){
            return(
                <div>这是C组件</div>
            )
        }
    }
    ```

    在console中可以看到match.params里有值了。

4. 在页面中显示传递的参数
    componentC.js

    ```js
    import React from 'react'

    export default class componentC extends React.Component{
        componentWillMount () {
            console.log(this.props)
        }

        render(){
            return(
            // 新增
                <div>这是C组件：参数：{this.props.match.params.param}</div>
            )
        }
    }
    ```

5. 传递2个值
nav.js

```js
<NavLink exact to="/componentc/ILoveWeb/HelloReact" activeClassName="active" className="blue">ComponentC传值</NavLink><br/>
```

index.js

```js
<Route path="/componentc/:param/:a" component={Componentc}/>
```

componentC.js

```js
<div>这是C组件：参数：{this.props.match.params.param}, {this.props.match.params.a}</div>

```

## 第9节 路由： Router中的属性和路由模式

上节学习了React路由导航的基本方法，这节课学习标签上的属性和方法。还有一个重点是路由5种模式的讲解。

### basename属性

basename是增加一级导航目录，如之前访问<http://localhost:1717/componentb，现在访问同一个页面，但路径是http://localhost:1717/demo/componentb.这时，就可以使用basename属性来设置。>

basename是放在`<Router>`标签中的

index.js

```js

ReactDOM.render(
    <Router basename="demo">
        <div>
            <Nav/>
            <Switch>
                <Redirect from="/redirect" to="/componentb"/>
                <Route exact path="/" component={Componenta}/>
                <Route path="/componentb" component={Componentb}/>
                <Route path="/componentc/:param/:a" component={Componentc}/>
                <Route component={Error}/>
            </Switch>
        </div>
    </Router>,
    document.getElementById('app')
)

```

这时再点击导航，已经都加了/demo。

==注意：==
此时的设置是全局增加，如果是单个路由增加，需要特殊个性设置。

### forceRefresh 属性

这个属性是开启或关闭React Router，也就是说把forceRefresh 设为true，将关闭React路由系统，真实的去服务器端请求信息

现在把forceRefresh设为true，会发现路由已经不能使用

```js

ReactDOM.render(
<!--新增-->
    <Router basename="demo" forceRefresh={true}>
        <div>
            <Nav/>
            <Switch>
                <Redirect from="/redirect" to="/componentb"/>
                <Route exact path="/" component={Componenta}/>
                <Route path="/componentb" component={Componentb}/>
                <Route path="/componentc/:param/:a" component={Componentc}/>
                <Route component={Error}/>
            </Switch>
        </div>
    </Router>,
    document.getElementById('app')
)
```

这个操作经常在大项目中使用。在服务器跳转和ReactRouter切换时使用。比如做一个APP活动页，第一次请求时到服务器请求整个页面，将整个页面缓存。生成ReactRouter实现本地单页应用，设置forceRefresh为false，即可。

## 5种路由方式

我们一直用的是BrowserRouter，也就是浏览器的路由方式，其实React还有几种路由方式。

- ### 1.BrowserRouter

    浏览器的路由方式，也是我们一直学习的路由方式。开发中最常使用。

- ### 2. HashRouter

    在路径钱加入#号称为一个哈希值。Hash模式的好处是，再也不会因为刷新而找不到对应路径。

- ### 3.MemoryRouter

    不存储history，所有路由过程都存在内存中，不能前进后退，浏览器地址不会发生。

- ### 4.NativeRouter

    经常配合ReactNative使用，多用于移动端。

- ### 5. StaticRouter

    设置静态路由，需要和后台服务器配合设置，比如设置服务端渲染时使用。

每中模式都有优缺点，根据项目的需求选择合适的使用即可。

### 示例 使用HashRouter 或MemoryRouter模式

1. 引入

    ```js
    import {BrowserRouter as Router ,HashRouter,MemoryRouter, Route , Switch ,Redirect} from 'react-router-dom';
    ```

2. 设置

HashRouter

```js
<HashRouter basename="demo" >
    <div>
        <Nav/>
        <Switch>
            <Route  exact  path="/"  component={Jspang} />
            <Route  path="/Jspangb" component={Jspangb} />
            <Route  path="/Jspangc/:param" component={Jspangc} />
            <Redirect from="/redirect" to="/Jspangb" />
            <Route  component={Error} />
        </Switch>

    </div>
</HashRouter>,
```

MemoryRouter

```js
<MemoryRouter basename="demo" >
    <div>
        <Nav/>
        <Switch>
            <Route  exact  path="/"  component={Jspang} />
            <Route  path="/Jspangb" component={Jspangb} />
            <Route  path="/Jspangc/:param" component={Jspangc} />
            <Redirect from="/redirect" to="/Jspangb" />
            <Route  component={Error} />
        </Switch>

    </div>
</MemoryRouter>,
```

### 总结-9

这节课重点是路由的方式。在项目开始时就应该根据需求选择好，也是要掌握的重点之一。上手项目容易遇到坑。

## 第10节 路由 prompt用法详解

在很多项目中，离开一个页面，都会弹出一个提示框。确定是否离开。React也有这样的组件，就是Prompt。

## `<Prompt>`标签

要使用`<Prompt>`标签要先引入。

componentB.js

```js
import React from 'react'
// 新增
import { Prompt } from 'react-router-dom'

export default class componentB extends React.Component{
    render(){
        return(
            <div>
                这是B组件
                // 新增
                <Prompt message="残忍离开?" />
                </div>
        )
    }
}
```

需要注意的是，如果使用MemoryRouter，`<Prompt>`不起作用。

### `<Prompt>`有两个属性

* message: 用于显示提示的文本信息
* when： 传递布尔值，相当于标签的开关，默认是true，设置为false，prompt失效。

如何动态改变when的状态呢？做个小实例。

```js
import React from 'react'
import { Prompt } from 'react-router-dom'

export default class componentB extends React.Component{
    constructor (props) {
        super(props)
        this.state = {
            power: false
        }
        this.changePower = this.changePower.bind(this)
    }
    changePower () {
        alert('已经开启')
        this.setState({
            power: true
        })
    }
    render(){
        return(
            <div>
                这是B组件
                <Prompt message="残忍离开?"  when={this.state.power}/>
                <button onClick={this.changePower}>启用</button>
                </div>
        )
    }
}
```

Flux和Redux的学习建议在官网学习。

### [官方文档](https://redux.js.org/)

### [中文文档](http://cn.redux.js.org/)

### 经验-10

移动端样式看起来大部分用flex就可以满足。
常用组件Text，View，TextInput，Image
Image src属性为source
样式的编写与原生区别
