---
title: React进阶读书笔记
date: 2018-11-07 19:34:55
updated: 2018-11-07 19:34:55
tags:
---

# React 四大特点
- 声明式视图层
    采用JSX语法来声明视图层, 可以在视图层中随意使用各种状态数据
- 简单的更新流程
    从状态到UI单向数据流让React组件的更新流程更清晰
- 灵活的渲染实现
    基于虚拟dom渲染
- 高效的DOM操作
    React可以尽量减少虚拟dom到真实DOM的渲染次数, 以及每次渲染需要改变的真实DOM节点数。

React只是view层, 关注的是如何根据状态创建可复用的UI组件, 如何根据组件创建可组合的UI.
应用复杂时, 需要结合其他库(Redux, MobX等). 

# React组件名必须大写

因为DOM标签的首字母都是小写; React组件类型的标签必须首字母大写。
React正是通过首字母大小写判断渲染的是一个dom类型的标签还是React组件类型的标签。

# JSX语法实际是什么

JSX语法只是React.createElement(component, props, ...children)的语法糖, 所有的JSX语法最终都会被转换成对这个方法的调用。

```javascript
const ele = <div className='foo'>Hello, React</div>
```
转换后
```javascript
const ele = React.createElement('div', {className: 'foo', 'Hello, React'})
```

# 组件定义方式

有两种方式

1. ES6 class(类组件)
    需满足条件:
    1. class继承自React.Component
    2. class内部必须定义render方法, render返回代表该组件UI的React元素.

    eg:
    ```
    import React, { Component } from "react";
    export default class PostList extends Component {
        render() {
            return (
                <div>
                    列表
                </div>
            )
        }
    }

    ```

2. 使用函数(函数组件)
    函数组件接收props作为参数,返回这个组件UI的React元素结构.
    
    eg:
    ```
    function Welcome(props) {
        return <h1>Hello, {props.name}</h1>;
    }
    ```



# React组件数据驱动UI

React组件是由props和state两种类型的数据驱动渲染出组件UI. props是组件对外的接口, 组件通过props接收外部传入的数据(包括方法);
state是组件对内的接口, 组件内部状态的变化通过state来反映。
props是只读的, 不能再组件内部修改props, 要修改props只能在父组件中修改; 
state是可变的, 组件状态的变化
通过修改state来实现.

这也是state和props的区别

# 有状态组件 无状态组件
- 如果组件内部状态是不变的, 就不用state, 这样的组件称之为无状态组件。
**无状态组件尽量定义成函数组件.**

优点:
无状态组件不关心状态变化, 只聚焦于UI展示, 更容易被复用。

- 组件内部状态会发生变化，需要使用state来保存变化，这样的组件称为有状态组件。

建议:
开发React应用, 一定要先认真思考哪些组件应该设计成有状态组件, 哪些该设计成无状态组件.并且应尽可能多地使用无状态组件。
无状态组件数据从父级获取, 组件解耦更彻底.

React组件设计思路:
通过定义少数的有状态组件管理整个应用的状态变化, 将状态通过props传递给其余的无状态组件, 由无状态组件完成页面绝大部分UI的渲染工作。
有状态组件主要关注处理状态变化的业务逻辑, 无状态组件主要关注组件UI的渲染。


# 属性校验和默认值

```
import PropTypes from 'prop-types';

class PostItem extends React.Component {
    // ...
}

PostItem.propsTypes = {
    post: PropTypes.object,
    onVote: PropTypes.func
}
```
如果属性是一个对象或数组,至于对象的结构或数组元素类型无法确定。这种情况下使用`PropTypes.shape` 或`PropTypes.arrayOf`
```
style: PropTypes.shape({
    color: PropTypes.string,
    fontSize: PropTypes.number
}),
// 必传属性 isRequired
sqeuence: PropTypes.arrayof(PropTypes.number).isRequired

// 默认属性
PostItem.defaultProps = {
    name: 'Lucy'
}
```

# 组件与元素
React元素是一个普通的Javascript对象, 通过DOM节点或React组件描述界面.
JSX语法就是用来创建React元素的。

React组件是一个class或函数，它接收一些属性作为输入，返回一个React元素。
React组件由若干React元素组件而成。

# React生命周期

## 1. 挂载阶段

1. constructor
组件被创建时，会先调用组件的构造方法。构造方法接收一个props参数，props是从父组件中传入的属性对象，
如果父组件中没有传入属性而组件自身定义了默认属性，props执行组件默认属性。必须在和这个方法中先调用
`super(props)`才能保证props被传入组件中.

constructor常用于初始化组件的state以及绑定时间处理方法等工作。

2. componentWillMount
    组件被挂载到DOM前调用，只会调用一次。
    调用this.state不会引发组件重新渲染

3. render
    定义组件时唯一必要的方法(其他生命周期方法都可以省略)
    render并不负责组件的实际渲染工作，只返回UI的描述,渲染页面DOM的工作由React自身负责
    不能在render调用`this.setState`会改变组件状态

4. componentDidMount
    组件被挂载到DOM后调用, 且只会被调用一次。
    可以获取到DOM结构, 依赖DOM节点的操作可以放到这个方法中

    通常会用于向服务器请求数据, 调用`this.setState`会引起组件重新渲染


## 2. 更新阶段

props引起组件更新时由渲染该组件的父组件引起的.
    当父组件的render被调用时组件会发生更新过程，无论props是否改变，父组件render方法每调用一次，会导致组件更新。
state组件更新是通过this.state修改组件state来触发的。

1. componentWillReceiveProps(nextProps)
    props引起组件更新过程才会调用
    state引起的组件更新不会触发该方法执行。

    需要比较nextProps与this.props来决定是否执行props发生变化后的逻辑

    tips:
        - componentWillReceiveProps中调用setState，只有在最贱render及其之后的方法中，this.state指向的才是更新后的state。
        在render之前的方法shouldComponentUpdate、componentWillUpdate中，this.state依然指向的是更新前的state
        - 调用setState更新组件状态不会触发componentWillReceiveProps的调用，否则会进入死循环
        componentWillReceiveProps->this.setState->componentWillReceiveProps
2. shouldComponentUpdate
    通过比较nextprops、nextState和组件当前的props、state决定这个方法的返回结果。
    true： 继续更细过程
    false： 组件停止更新，后续方法不执行。

    可以减少组件不必要渲染，优化组件性能。

3. componentWillUpdate
    一般很少用到

    shouldComponentUpdate和componentWillUpdate都不能调用setState，否则会引起循环调用。
4. render

5. componentDidUpdate(preProps, preState)
    更新后调用可以操作更新后的DOM
    两个参数代表调用前的props和state

## 3. 卸载阶段
1. componentWillUnmount
    组件被卸载前调用
    执行清理工作，如：取消定时器，手动创建的DOM元素，取消http请求，以避免内存泄漏。

==**只有类组件才有生命周期方法，函数组件没有生命周期方法！！！！！！**==


# 事件绑定

```javascript
handleClick = (event) => {
    const number = ++this.state.number;

    this.setState({
        number: number
    });
}
<button onClick={this.handleClick}>Click</button>
```

# 受控组件 非受控组件
- 受控组件：非表单元素只需根据组件的属性或状态进行渲染
    如果一个表单元素的值是由React来管理的，那么它就是一个受控组件。

􏰢􏲐􏱕􏰃􏴠􏸕􏲝􏰍􏰇􏸡􏳭􏳮􏰣􏴞􏴟􏳑􏰉􏰗- 状态不受React控制的表单元素为非受控组件。input，textarea，select等
    React中，装填的修改必须通过组件的state，非受控组件的行为有悖于这一原则。
    为了让表单元素状态变更也能通过组件的state管理，React采用受控组件的技术达到这一目的。

    受控组件保证了表单元素的状态也由React统一管理，但需为每个表单元素定义onChange事件的处理函数，
    把表单状态同步到React组件的state。这一过程比较繁琐。

一种替代方案是使用非受控组件。
表单元素的状态依然由表单元素自己管理，而不是交给React组件管理。使用非受控组件需要有一种方式可以获取到表单元素的值，
React中提供了一种特殊的属性ref, 用来引用React组件或DOM实例。因此可以通过为表单元素定义ref属性获取元素的值。

看似简化了操作表单元素的过程，但破坏了React对组件状态管理的一致性，旺旺容易出现不容易排查的问题，
非特殊情况，不建议使用。


# React 16新特性

1. render新的返回类型
    React156之前必须返回单个元素。现在支持两种新的返回类型：数组(由React元素组成)和字符串。

```
class ListComponent extends Component {
    render() {
        return [
            <li key="A">First item</li>,
            <li key="B">Second item</li>,
            <li key="C">Third item</li>
        ];
    }
}

class StringComponent extends Component {
    render() {
        return "Just a strings";
    }
}
```

2. 错误处理

React16之前运行期执行出错，会阻塞整个应用的渲染。只能刷新页面才能恢复应用。

React16引入新的错误处理机制，默认情况下组件中抛出错误，组件会从组件树中卸载，避免整个应用崩溃。

还提供了错误边界(Error Boundaries),可以输出错误日志，显示错误提示。
`􏱂􏱃􏱋componentDidCatch(error, info)`


--------------我的点评--------------
项目中目前从后端返回的数据取值。eg:
```
res.data.userInfo[0].nickName
```
任何一个节点没有数据都可能引发异常
通常需要
```
res && res.data && res.data.userInfo && ...
```
解决办法：
可以自己写个isEmpty 或引用[lodash.isEmpty](https://www.npmjs.com/package/lodash.isempty)

3. Portals
可以把组件渲染到当前组件树以外的DOM节点上。典型应用场景是渲染应用的全局弹框。
使用Portals后，任意组件都可以将弹框组件渲染到根节点上。

Portals的实现依赖ReactDOM的一个新API:`ReactDOM.createPortal(child, container)`
第一个参数child是可以被渲染的React节点。container是一个DOM元素，child将被挂载到这个DOM节点。

eg:
```JavaScript
class Modal extends Component {
    constructor(props) {
        super(props);
        // 􏴟􏲭􏲮􏰖􏱡􏱢􏰫􏰚根节点下创建一个div􏲭􏲮节点
        this.container = document.createElement("div");
        document.body.appendChild(this.container);
    }
    componentWillUnmount() {
        document.body.removeChild(this.container);
    }
    render() {
        // 􏱡􏱢􏰉创建的DOM树挂载到􏹄􏵵􏰧􏲯this.container指向的div节点下面
        return ReactDOM.createPortal(
            <div className="modal">
                <span className="close" onClick=
                    {this.props.onClose}>
                    &times;
              </span>
                <div className="content">
                    {this.props.children}
                </div>
            </div>,
            this.container
        );
    }
}

```
App中使用Modal
```JavaScript
class App extends Component {
    constructor(props) {
        super(props);
        this.state = { showModal: true };
    }
    // 关闭
    closeModal = () => {
        this.setState({ showModal: false });
    };
    render() {
        return (
            <div>
                <h2>Dashboard</h2>
                {this.state.showModal && (
                    <Modal onClose={this.closeModal}>Modal Dialog</Modal>
                )}
            </div>);
    }
}
export default App;
```


4. 自定义DOM属性
    React16可以识别自定义属性, 传递给DOM元素
    `<div custom-attribute="something" />`

5. 还有其他特性
    setState传入null时不会再触发组件更新
    更高效的服务器端渲染方式



# 设计合适的state

state必须能代表一个组件UI呈现的完整状态集。组件的任何UI改变都可以从state的变化中反映出来; 同时state还必须代表一个组件UI呈现的最小状态集，
即state中的所有状态都用于反映组件UI的变化，没有任何多余状态，也不应该存在通过其他状态计算而来的中间状态。

eg:
错误的state
```
{
    purchaseList: [],
    totalCost: 0
}
```
包含无用的状态totalCost，totalCost可以根据购买的每一项物品的价格和数量计算得出。totalCost属于中间状态，可以省略。

state可以分为两类数据：
- 用作渲染组件时使用到的数据来源
- 用作组件UI展现形式的判断依据


state与组件的普通属性

定义：除了state，props以外的组件属性成为组件的普通属性。
 在ES6中，可以使用this.{属性名}定义一个class的属性，可以说属性是直接挂载到this下的变量。
因此state， props也是组件的属性，只不过它们是React为我们Component Class中预定义好的属性。

```JavaScript
class Hello extends React.Component {
    constructor(props) {
        super(props);
        this.timer = null; // 普通属性
        this.state = {
            date: new Date()
        }
    }
}
```

使用场景：
当组件中需要用到一个变量，并且它与组件的渲染无关时，就应该把这个变量定义为组件的普通属性，直接挂载到this下，而不是作为组件state。
更直观的判断方法，看组件render方法中有没有用到这个变量，没有，就是普通属性。

总结：
判断一个变量是不是应该作为state可以通过以下4条依据判断：
1. 是否通过props从父组件中获取？是，不是state
2. 是否在组件整个生命周期中保持不变？是，不是state
3. 是否可以通过其他state或props计算得到？是，不是state
4. 是否在组件render方法中使用？是，不是state，定义为普通属性更合适


# state的修改
1. 不能直接修改 `this.state.title = 'react' //错误`
2. state更新是异步的
3. state的更新时一个合并的过程
















