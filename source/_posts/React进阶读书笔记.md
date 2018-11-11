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

## 主要组成
action, reducer, store






# 纯函数
必须满足两个条件
1. 对于同样的参数值，函数的返回结果总是相同的。函数结果不依赖任何在程序执行过程中可能改变的变量。
2. 函数的执行不会产生副作用，例如修改外部对象或输出到I/O设备。





