---
title: React进阶读书笔记
date: 2018-11-07 19:34:55
updated: 2018-11-07 19:34:55
tags:
- React
- 读书笔记
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

<!-- more -->

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
无状态组件数据从父级获取, 组件解耦更彻底.

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

React元素是一个普通的Javascript对象, 通过DOM节点或React组件描述界面.
JSX语法就是用来创建React元素的。

React组件是一个class或函数，它接收一些属性作为输入，返回一个React元素。
React组件由若干React元素组件而成。

# React生命周期

## 1. 挂载阶段

1. constructor
组件被创建时，会先调用组件的构造方法。构造方法接收一个props参数，props是从父组件中传入的属性对象，
如果父组件中没有传入属性而组件自身定义了默认属性，props执行组件默认属性。必须在和这个方法中先调用
`super(props)`才能保证props被传入组件中.

constructor常用于初始化组件的state以及绑定时间处理方法等工作。

2. componentWillMount
    组件被挂载到DOM前调用，只会调用一次。
    调用this.state不会引发组件重新渲染

3. render
    定义组件时唯一必要的方法(其他生命周期方法都可以省略)
    render并不负责组件的实际渲染工作，只返回UI的描述，渲染页面DOM的工作由React自身负责
    不能在render调用`this.setState`会改变组件状态

4. componentDidMount
    组件被挂载到DOM后调用, 且只会被调用一次。
    可以获取到DOM结构, 依赖DOM节点的操作可以放到这个方法中

    通常会用于向服务器请求数据, 调用`this.setState`会引起组件重新渲染

## 2. 更新阶段

props引起组件更新时由渲染该组件的父组件引起的.
    当父组件的render被调用时组件会发生更新过程，无论props是否改变，父组件render方法每调用一次，会导致组件更新。
state组件更新是通过this.state修改组件state来触发的。

1. componentWillReceiveProps(nextProps)
    props引起组件更新过程才会调用
    state引起的组件更新不会触发该方法执行。

    需要比较nextProps与this.props来决定是否执行props发生变化后的逻辑

    tips:
        - componentWillReceiveProps中调用setState，只有在最近render及其之后的方法中，this.state指向的才是更新后的state。
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
    执行清理工作，如：取消定时器，手动创建DOM元素，取消http请求，以避免内存泄漏。

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

- 受控组件：非表单元素只需根据组件的属性或状态进行渲染
    如果一个表单元素的值是由React来管理的，那么它就是一个受控组件。

- 状态不受React控制的表单元素为非受控组件。input，textarea，select等
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
    React156之前必须返回单个元素。现在支持两种新的返回类型：数组(由React元素组成)和字符串。

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

还提供了错误边界(Error Boundaries),可以输出错误日志，显示错误提示.
`componentDidCatch(error, info)`

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

解决办法：
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
        // 根节点下创建一个div节点
        this.container = document.createElement("div");
        document.body.appendChild(this.container);
    }
    componentWillUnmount() {
        document.body.removeChild(this.container);
    }
    render() {
        // 创建的DOM树挂载到this.container指向的div节点下面
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

state与组件的普通属性

定义：除了state，props以外的组件属性成为组件的普通属性。
 在ES6中，可以使用this.{属性名}定义一个class的属性，可以说属性是直接挂载到this下的变量。
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
当组件中需要用到一个变量，并且它与组件的渲染无关时，就应该把这个变量定义为组件的普通属性，直接挂载到this下，而不是作为组件state。
更直观的判断方法，看组件render方法中有没有用到这个变量，没有，就是普通属性。

总结：
判断一个变量是不是应该作为state可以通过以下4条依据判断：

1. 是否通过props从父组件中获取？是，不是state
2. 是否在组件整个生命周期中保持不变？是，不是state
3. 是否可以通过其他state或props计算得到？是，不是state
4. 是否在组件render方法中使用？是，不是state，定义为普通属性更合适

# state的修改

1. 不能直接修改 `this.state.title = 'react' //错误`
2. state更新是异步的
3. state的更新时一个合并的过程

# state与不可变对象

React官方建议把state当做不可变对象：

- 直接修改this.state, 组件不会重新render
- state中包含的所有状态都应该是不可变对象

state中的某个状态发生变化，应该重新创建这个状态对象，而不是直接修改原来的状态。

### 如何创建新的状态呢？三种情况

1. 不可变类型(数字，字符串，布尔值，null，undefined)---直接赋值

    ```javascript
    this.setState({
        count: 1,
        title: 'React',
        success: true
    })
    ```

2. 数组---concat, 扩展语法(spread syntax)

    ```javascript
    this.setState(preState => ({
        books: preState.books.concat(['React Guide'])
    }))

    this.setState(preState => ({
        books: [...preState.books, 'React Guide']
    }))
    ```

- 截取部分元素作为新状态

```javascript
this.setState(preState => ({
    books: preState.books.slice(1,3)
}))
```

- 过滤部分元素作为新状态

```javascript
this.setState(preState => ({
    books: preState.books.filter(item => {
        return item !== 'React';
    })
}))
```

注意：不要使用push,pop,shift,unshift,splice等方法修改数组类型状态。因为这些方法都是在原数组基础上修改，而从concat,slice,filter会
返回一个新数组。

3. 普通对象(不包含字符串，数组)---Object.assign,对象扩展语法(object spread properties)

```javascript
this.setState(preState => ({
    owner: Object.assign({}, preState.owner, {name: 'James Bond'})
}))

this.setState(preState => ({
    owner: {...preState.owner, name: 'James Bond'}
}))
```

总结：
    创建新状态对象的关键，避免使用会直接修改原对象的方法，而使用可以返回一个新对象的方法。
    也可用一些Immutable的JS库，(如Immutable.js)

为什么组件的状态是不可变对象？

- 对不可变兑现的修改会返回一个新对象，不用但系原有对象在不小心情况下修改导致的错误，方便管理和调试
- 出于性能考虑，当对象组件状态都是不可变对象时，在shouldComponentUpdate方法中仅需要比较前后两次状态对象的引用就可以判断状态是否真的改变，
避免不必要的render调用。

# componentDidMount执行请求最佳，原因两个

1. 在componentDidMount中执行请求可以保证获取到数据时，组件已处于挂载状态。即使操作DOM也是安全的。
    componentWillMount无法保证
2. 组件在服务端渲染时componentWillMount会调用两次，一次在服务端，一次在浏览器端。
    而componentDidMount能保证在任何情况下只调用一次。不会发送多余的请求。

组件更新阶段也可以发送请求，获取服务最新数据。
例如：组件需要以props中某个属性作为与服务器通信时请求参数，当这个值发生更新，需要重新发起请求。
在componentWillReceiveProps阶段处理。

```javascript
class ListContainer extends React.Component {
    // ...
    componentWillReceiveProps(nextProps) {
        fetch('url').then(res=>{
            // ...
        })
    }
}
```

fetch之前需要对nextProps判断，如果不一致再发起请求

# 组件通信

## 父子组件通信--通过props

父向子是通过父组件向子组件的props传递数据完成

子向父：父组件通过子组件的props传递给子组件一个回调函数，子组件在需要改变父组件时，调用这个回调函数

```javascript
// 父
<UserList users={this.state.users}/>

// 父
<UserList users={this.state.users} onAddUser={this.handleAddUser}/>
// 子
<button onClick={this.props.onAddUser}>
```

## 兄弟组件通信

兄弟组件：有相同父组件，不是父子组件的组件。

兄弟组件不能直接互传数据，需要通过状态提升的方式实现兄弟组件的通信。
把组件之间需要共享的状态保存到距离它们最近的共同父组件内，任一兄弟组件都可以通过父组件传递的回调函数来修改共享状态，父组件中的共享状态的变化也会
通过props向下传递给所有兄弟组件，完成兄弟组件之间的通信

## Context--实验性API,不建议使用，会让数据流变得混乱

组件层级太深，props传递层级繁琐。
context让任意层级的子组件都可以获取父组件的状态和方法

## 其他通信方式

- 消息队列
    改变数据的组件发起消息，使用数据的组件监听，在响应函数中触发setState改变组件状态。--观察者模式
    (EventEmitter或Postal.js等消息队列库)
- Redux, MobX状态管理库。

# ref

优点：
    获取表单元素，获取其他任意DOM元素，获取React组件实例
用处：控制元素焦点，文本选择，第三方操作DOM库集成

缺点：避免使用ref,破坏了React中以props为数据传递介质的典型数据流
ref接收一个回调函数作为值，在组件被挂载或卸载时，回调函数会被调用。
组件被挂载时，回调函数会接收当前DOM元素作为参数；组件被卸载时回调函数会接收null作为参数

1. 在DOM 上使用ref
让input自动获取焦点

```javascript
class AutoFocusInput extends React.Component {
    componentDidMount() {
        // 通过ref让input自动获取焦点
        this.textInput.focus();
    }
    blur= () => {
        this.textInput.blur();
    }
    render() {
        return (
            <div>
                <input type='text' ref={(input) => {this.textInput = input}}/>
            </div>
        )
    }
}
```

2. 组件上使用ref
ref的回调函数接收的参数是当前组件的实例。提供了一种在组件外部操作组件的方式。

```javascript
// 通过ref调用AutoFocusInput组件的方法
this.inputInstance.blur();
<AutoFocusInput ref={input => {this.inputInstance = input}}/>
```

注意：只能为累组件定义ref属性，不能为函数组件定义ref属性。但可以在函数组件内部使用ref引用其他DOM元素或组件。

```javascript
function MyFuncitonCom() {
    let textInput = null;
    function handleClick() {
        textInput.focus();
    }

    return(
        <div>
            <input ref={(input) => {textInput = input;}} />
            <button onClick={handleClick}>获取焦点</button>
        </div>
    )
}

```

3. 父组件访问子组件的DOM节点
因为ref只能访问子组件的实例对象，而不能获取子组件中的某个DOM元素。

可以采用一种间接方式获取子组件的DOM元素：在子组件的DOM元素上定义ref, ref的值是父组件传递给子组件的一个回调函数，回调函数可以通过一个自定义
的属性传递，例如inputRef,这样父组件的回调函数中就能获取到这个DOM元素。

```javascript
function Children(props) {
    // 子组件使用父组件传递的inputRef， 为input的ref赋值
    return (
        <div>
            <input ref={props.inputRef}/>
        </div>
    );
}

class Parent extends React.Component {
    render() {
        // 自定义一个属性inputRef, 值是一个函数
        return (
            <Children inputRef={el => this.inputElement = el} />
        );
    }
}

```

可以看到即使子组件是函数组件，这种方式同样有效。

# 虚拟DOM

虚拟DOM是用来描述真实DOM的JavaScript对象。

```
<div className='foo'>
    <h1>Hello React</h1>
</div>

对应的JavaScript对象
{
    type: 'div',
    props: {
        className: 'foo',
        children: {
            type: 'h1',
            props: {
                children: 'Hello React'
            }
        }
    }
}
```

虚拟DOM是普通的JavaScript对象，访问JavaScript对象当然比访问真实DOM快得多

# Diff算法

React采用声明式API描述UI结构，每次组件的状态或属性更新，render方法都会返回一个新的虚拟DOM对象，用来标书新的UI结构。如果每次render都直接使用
新的虚拟DOM来生成真实DOM结构，会带来大量对真实DOM操作，影响效率。React通过**比较两次虚拟DOM结构的变化找出差异部分，更新到真实DOM上**，从而减少
最终要在真实DOM上的操作，提高效率。这就是React的调和过程(Reconciliation).其中的关键是比较两个树形结构的Diff算法。
基于两种假设, 算法复杂度从O(N^3)--> O(N)

1. 两个元素类型不同，它们将生成两棵不同的树
2. 为列表元素设置key属性，用key标识对应元素在多次render过程中是否发生变化

## React如何比较两棵树的差异

从根节点开始比较，根节点类型不同，React执行的操作也不同

1. 根节点不同类型
React认为新树和旧树完全不同，不再继续比较其他属性和子节点。把整棵树拆掉重建(包括虚拟DOM和真实DOM)

虚拟DOM节点分为两类：DOM元素，div,p等；react组件类型，自定义组件等。
拆除过程中，旧的DOM元素类型节点被销毁，旧的react组件实例的componentWillUnmount会被调用
重建过程中，新的DOM元素被插入DOM树，新的组件实例的componentWillMount和componentDidMount会被调用

更新效率最低

2. 根节点是相同DOM元素类型
两个根节点相同类型的DOM元素，React会保留根节点，比较根节点的属性，然后只更新那些变化了的属性

3. 根节点是相同的组件类型
两个根节点是相同类型的组件，对应的组件实例不会被销毁，只是会执行更新操作。同步变化的属性到虚拟DOM树上，
组件的componentWillReceiveProps和componentWillUpdate会被调用

需在组件更新并且render方法执行完成后，根据render返回的虚拟DOM结构决定如何更新真实DOM树

如此递归比较，直到比较完两棵树上所有节点，计算得到最终差异，更新到DOM树上。

# key的重要性

对多个li这种情况，React提供了key属性。
key帮助React提高diff算法效率。当一组子节点定义了key，React会根据key来匹配子节点，在每次渲染之后，只要子节点的key值没有变化，React就认为这是
同一个节点。
尽量不要使用元素在列表中的索引值作为key，因为列表中的元素顺序发生变化，可能导致大量的key失效，进而引起大量的修改操作。

```javascript
<ul>
    {list.map((item, index) => <li key={index}>{item}</li>)}
</ul>
```

key的使用，减少了DOM操作，提高了DOM更新效率，当列表元素数量很多时，key的使用更显得重要

# React性能优化

1. 使用生产环境版本的库
2. 避免不必要的组件渲染--shouldComponentUpdate， pureComponent
3. 使用key

# 性能检测工具

1. React Developer Tools for Chrome
背景是黑色表示用生产环境版本的React，红色表示开发环境版本
2. Chrome Performance Tab
3. why-did-you-update

# 高阶组件

主要用来实现组件逻辑的抽象和服用
**本质**：也是一个函数，并不是一个组件  装饰器设计模式

## 基本概念

JavaScript中，高阶组件是以函数为参数，并且返回值也是函数的函数。
类似的高阶组件(简称HOC), 接收React组件作为参数，并且返回一个新的React组件

形式：`const EnhancedComponent = higherOrderComponent(WrappedComponent);`

## 主要功能

封装并分离组件的通用逻辑，让通用逻辑在组件间更好的被复用。

## 使用场景

1. 操纵props
2. 通过ref访问组件实例
3. 组件状态提升
4. 用其他元素包装组件

# React Router----

# 划分组件原则

划分页面组件需要根据页面结构、组件的复用性、组件的复杂度等因素综合考虑

划分组件两个极端，组件粒度过大或过小。过大，组件逻辑过于复杂，可维护性和复用性变差；
过小，组件数量激增，一个简单功能需引入大量组件，增加开发成本，过多也不利于查找。

一种观点是一个组件只负责一个功能。建议辩证看待。如果几个功能都很简单，且每一个功能都没有复用需求，
那么把这几个功能放到一个组件也可，提高开发效率。

# 代码分片

实现代码按需加载，提高应用加载速度

1. 借助[bundle-loader](https://github.com/webpack-contrib/bundle-loader)来实现按需加载。

```javascript
import ListContainer from 'bundle-loader?lazy&name=app-[name]!./app/list.js';
```

2. 动态import

-----

# Redux

Redux 通过reducer解析action

reducer是一个普通的JavaScript函数，接收action为参数，然后返回一个新的应用状态state。

主要思想：描述应用的状态如何根据action进行更新，Redux通过提供一系列API将这一主要思想的落地实施进行标准化和规范化。

## 三大原则

1. 唯一数据源
Redux只维护一个全局的状态对象，存储在Redux的store中。唯一数据源是一种集中式管理应用状态的方式，便于监控任意时刻应用的状态和调试应用，减少出错可能性。

2. 保持应用状态只读
任何时刻都不能直接修改应用状态。需要修改，必须发送一个action，由这个action描述如何修改应用状态。
保证了大型应用中状态管理的有序进行。

3. 应用状态的改变通过纯函数完成
action表明修改应用状态的意图，真正对应用状态做修改的是reducer

reducer必须是纯函数，所以reducer在接收action时，不能直接修改原来的状态对象，而要创建一个新的状态对象返回。

### 纯函数

必须满足两个条件

1. 对于同样的参数值，函数的返回结果总是相同的。函数结果不依赖任何在程序执行过程中可能改变的变量。
2. 函数的执行不会产生副作用，例如修改外部对象或输出到I/O设备。

## 主要组成

action, reducer, store

### action

action是Redux中信息的载体， 是store唯一的信息来源。
action发送给store必须通过store的dispatch。

action是普通的JavaScript对象，但每个action必须有一个type属性描述action的类型，一般被定义为字符串常量。除了type属性之外，action的结构完全由自己决定，但应该能确保action的结构能清晰的描述实际业务场景。

一般通过action creator创建action， action creator是返回action的函数。如下：

```JavaScript
function addTodo(text) {
    return {
        type: 'ADD_TODO',
        text
    }
}
```

### reducer

action用于描述应用发生了什么操作， reducer则根据action做出响应，决定如何修改state.

state既可以包含服务器端获取的数据，也可以包含UI状态。

最基本的reducer, eg:

```JavaScript
import { VisibilityFilters } from './acitons'

const initialState = {
    todos: [],
    visibilityFilter: VisibilityFilters.SHOW_ALL
}

// reducer
function todoApp(state = initialState, action) {
    return state
}

```

### store

store是action和reducer之间的桥梁。负责以下工作：

1. 保存应用状态
2. 通过getState访问应用状态
3. 通过dispatch(action)发送更新状态的意图
4. 通过subscribe(listener)注册监听函数、监听应用状态的改变。

一个Redux应用中只有一个store，store保存了唯一数据源。
store通过createStore()创建，创建时需要传递reducer作为参数，创建store。

```
import { createStore } from 'redux'
import todoApp from './reducers'

let store = createStore(todoApp)

```

## 总结redux数据流过程

1. 调用store.dispatch(action)。可以在任何地方调用。包括组件，XHR回调，定时器等。
2. store调用reducer。store传递两个参数给reducer：当前应用的状态和action。
3. 根reducer会把多个子reducer的返回结果组合成最终的应用状态。redux提供了combineReducer方便组合。
4. store保存根reducer返回的完整应用状态。此时应用状态才完成更新。

## react-redux

### 展示组件和容器组件

根据组件意图的不同，可以将组件划分为两类：展示组件(presentational components)和容器组件(container components).

展示组件负责应用的UI展示(how things look), 展示组件不关心渲染时使用的数据是如何获取的，数据如何获取是容器组件负责的事情。

容器组件负责应用逻辑的处理(how things work), 如发送请求，处理返回数据，将处理过的数据传递给展示组件等。还提供修改源数据的方法，通过展示组件的props传递给展示组件，当展示组件的状态变更引起源数据变化时，展示组件通过调用容器组件提供的方法同步这些变化。

展示组件和容器组件可以自由嵌套。这样的分工可以使与UI渲染无直接关系的业务逻辑由容器组件集中负责，展示组件只关注UI的渲染逻辑，从而使展示组件更容易被复用。

> 展示组件和容器组件与无状态组件和有状态组件区别：
划分依据：
展示组件和容器组件是根据组件的意图划分组件
无状态组件和有状态组件是根据组件内部是否使用state划分组件。

通常展示组件是通过无状态组件实现，容器组件通过有状态组件实现。但展示组件也可以是有状态组件，容器组件也可以是无状态组件。

### connect

react-redux提供了connect函数，用于把react组件和redux的store连接起来，生成一个容器组件，负责管理数据管理和业务逻辑。

```JavaScript
import { connect } from 'react-redux'
import TodoList from './TodoList'

const VisibleTodoList = connect()(TodoList);

```

根据Redux的数据流过程，VisibleTodoList需要承担两个工作：

1. 从Redux的store中获取展示组件所需的应用状态
2. 把展示组件的状态同步到Redux的store中

通过两个参数实现

```JavaScript
import { connect } from 'react-redux'
import TodoList from './TodoList'

const VisibleTodoList = connect(
    mapStateToProps,
    mapDispatchToProps
)(TodoList);
```

mapStateToProps 和 mapDsipatchToProps 的类型都是函数，前者负责从全局应用状态state中取出所需数据，映射到展示组件的props，后者负责把需要用到的action映射到展示组件的props上

### mapStateToProps

mapStateToProps作用是把state转换成props。state是store中保存的应用状态，会作为参数传递给mapStateToProps，props是被连接的展示组件的props。

每当store中的state更新时，mapStateToProps会重新执行，重新计算传递给展示组件的props，从而触发组件的重新渲染。

> store中的state更新一定会导致mapStateToProps重新执行，但不一定会触发组件render方法的重新执行。如果mapStateToProps新返回的对象和之前的对象浅比较(shallow comparison)相等，组件的shouldComponentUpdate会返回false，render不再触发。

connect可以省略mapStateToProps参数，这样state的更新就不会引起组件的重新渲染。

mapStateToProps除了接收state参数外，还可以使用第二个参数，代表容器组件的props对象

```JavaScript
// ownProps 是组件的props对象
function mapStateToProps(state, ownProps) {
    //...
}

```

### mapDispatchToProps

！！！！
容器组件除了可以从state中读取数据外，还可以发送action更新state，这依赖于connect的第二个参数 mapDispatchToProps. mapDispatchToProps 接收 store.dispatch 方法作为参数返回展示组件用来修改state的函数。

```JavaScript
// toggleTodo(id) 返回一个action
function toggleTodo(id) {
    return {type: 'TOGGLE_TODO', id}
}

function mapDispatchToProps(dispatch) {
    return {
        onTodoClick: funciton(id) {
            dispatch(toggleTodo(id))
        }
    }
}

```

这样展示组件内就可以调用 this.props.onTodoClick(id) 的action。
与mapStateToProps相同，mapDispatchToProps也支持第二个参数，代表容器组件的props。

### Provider组件

通过connect函数创建出容器组件，但这个容器组件如何获取到Redux的store？react-redux提供了Provider组件，示意代码如下：

```JavaScript
class Provider extends Component {
    getChildContext() {
        return {
            store: this.props.store
        };
    }

    render() {
        return this.props.children;
    }

}

Provider.childContextTypes = {
    store: React.PropTypes.object
}
```

Provider组件需要接收一个store属性，然后把store保存到context。Provider组件正是通过context把store传递给子组件，所以使用Provider组件时，一般把它作为根组件，这样内层的任意组件才可以从context中获取store对象。

```JavaScript
import {createStore} from 'redux'
import {Provider} from 'react-redux'
import todoApp from './reducers'
import App from './components/App'

let store = createStore(todoApp);

render(
    <Provider store={store}>
        <App />
    </Provider>,
    document.getElementById('root')
)

```

## 中间件与异步操作

### 中间件

redux的action类比web框架收到的请求，reducer类比web框架的业务逻辑层，因此redux的中间件代表action在到达reducer前经过的处理程序。

实际上，一个redux中间件就是一个函数。redux中间件增强了store的功能，可以利用中间件为action添加一些通用功能，如日志输出，异常捕获等。

通过改造 store.dispatch 增加日志输出功能：

```JavaScript
let next = store.dispatch

store.dispatch = function dispatchAndLog(action) {
    console.log('dispatching', action)
    let result = next(action)
    console.log('next state', store.getState())
    return result
}

```

通过重新定义store.dispatch，在发送action前后都添加了日志输出，这就是中间件的雏形。

对store.dispatch方法进行搞糟，在发出action和执行 reducer 这两步之间添加其他功能。

实际项目中通常使用别人直接写好的中间件。如redux-logger.

在应用中会用到applyMiddleware。通过applyMiddleware将中间件logger传给createStore, 完成store.dispatch功能的加强。

applyMiddleware把接收到的中间件放入数组chain中，通过compose(...chain)(store.dispatch)定义加强版的dispatch。

compose是工具函数，compose(f, g, h)等价于 (...args)=>f(g(h(args))). 每个中间件都接收一个包含getState和dispatch的参数对象，在利用中间件执行异步操作时，会用到这两个方法。

### 异步操作

redux中的异步操作必须借助中间件完成。

[redux-thunk]()是处理异步操作最常用的中间件。

store.dispatch 只能接收普通JavaScript对象代表的action，使用redux-thunk，store.dispatch 就能接收函数作为参数了。异步action先经过redux-thunk的处理，当请求返回后，再发送一个action: dispatch({type: 'RECEIVE_DATA', json}), 把返回的数据发送出去，这时的action就是一个普通的JavaScript对象了，处理流程和不使用中间件流程一样。

> 常用中间件 redux-promise, redux-sage等。

## 小结

本章详细介绍了redux架构以及Redux各组成部分(action, reducer, store)，在react项目中使用redux需要借助react-redux，可以方便的将react组件和redux的store连接。中间件是redux的一大利器，redux中执行异步操作就是通过引入中间件实现的。

# redux实战经验

## 设计state

设计state**容易犯的两个错误**：

1. 以API作为设计state的依据
以API作为设计state的依据往往是一个API对应全局state中的一部分结构，且这部分结构同API返回的数据结构保持一致或接近一致。

因为API是基于服务端逻辑设计的，而不是基于应用状态设计的。

2. 以页面UI为设计state的依据
基于页面UI设计state 。页面UI需要什么样的数据和数据结构，state就设计成什么样。

### 合理设计state

最重要一句话：像设计数据库一样设计state。

把state看做一个数据库，state中的每一部分状态看做数据库中的一张表，状态中每个字段对应表的一个字段。

设计数据库遵循三个原则：

- 1. 数据按照领域(Domain)分类存储在不同的表中，不同表中存储的列数据不能重复
- 2. 表中每一列的数据都依赖于这张表的主键
- 3. 表中除了主键以外其他列互相之间不能有直接依赖关系

对照以上三个原则，设计state原则：

- 1. 整个应用的状态按照领域分成若干子状态，子状态之间不能保存重复的数据
- 2. state以键值对的结构存储数据，以记录的key活ID作为记录索引，记录中的其他字段都依赖于索引
- 3. state中不能保存可以通过state中的已有字段计算而来的数据，即state中的字段不互相依赖。

> 有开发者习惯把UI状态数据保存在组件state中，由组件自己管理，而不是交给Redux管理。但将UI状态数据也交给redux统一管理有利于应用UI状态的追溯。

## 设计模块

定义模块不能只被UI组件使用，各个模块之间也可以互相调用

> action和reducer之间并不存在一对一的关系。一个action可以被多个模块的reducer处理，尤其是多个模块之间存在关联关系时。

良好的模块设计对外暴露的应该是模

块的接口，而不是模块的具体结构

# 性能优化

## React Fiber原理

React 在页面更新时，会自顶向下计算 virtual dom 上的不同处。如果计算任务耗时过长，渲染线程在 16 ms 中无法执行任务，页面会出现掉帧/卡死现象。

React Fiber 解决这个问题的思路是把渲染/更新过程（递归diff）拆分成一系列小任务。每次检查树上的一小部分，做完看是否还有时间继续下一个任务，有的话继续，没有的话把自己挂起，主线程不忙的时候再继续

```js
function repeat(str, count) {
    let result = ''
        for (let i = 0; i < count; i++) {
        result += str
    }
    return result;
}
// 这段代码会导致页面卡死10s左右
console.log(repeat('1', 9999999))
```

按照fiber思想，拆分计算任务，解决页面卡死的问题

```js
async function repeat(str, count) {
    let maxLoopCount = 999999;
    let loopCount = 0;
    let taskStr = '';

    async function runTask(count) {
        let taskStr = '';
        return new Promise((resolve, reject) => {
            window.requestAnimationFrame(() => {
                for(let i=0; i<count && i<maxLoopCount; i++) {
                    loopCount++;
                    taskStr += str;
                }
                resolve(taskStr);
            })
        })
    }
    while(loopCount < maxLoopCount) {
        taskStr += await runTask(count - loopCount);
    }
    return taskStr;
}
repeat('1', 9999999).then(res => {
    console.log(res)
})
```

【前端学习地图系列课程】状态设计与管理

状态的同步是状态管理中一个比较表面的问题

以图的形式组织数据节点并相互同步，复杂度指数级上升，难以维护

将数据中心化管理，依靠框架的变更机制同步数据很便捷

要确保数据只有唯一的副本，各节点通过id引用这个副本，避免复制

思考

react-hooks有没有可复用的hook

如果entityStore有几万个实体，其中一个变化会引起引用了未变化实体的组件的刷新，性能低下，有没有办法优化

用其他状态管理框架，比如recoil,要怎么实现相同效果，能不能变成一个可复用的库

-----

## 什么情况下用`useCallback`和`useMemo`

在子组件不需要父组件的值和函数的情况下，只需要使用`memo`函数包裹子组件即可。

在定义函数的函数时，需要考虑有没有函数传递给子组件使用`useCallback`，传递给子组件的事件要加`useCallback`。

而在值有所依赖的项，并且是对象和数组等值的时候而使用useMemo（当返回的是原始数据类型如字符串、数字、布尔值，就不要使用useMemo了）。

不要盲目使用这些hooks。

[代码示例](https://67cjb.csb.app/)
