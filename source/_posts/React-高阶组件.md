---
title: React 高阶组件
date: 2018-12-09 19:30:57
updated: 2018-12-09 19:30:57
tags:
    - React
---

# 高阶组件
高阶组件（ higher-order component ，HOC ）是 React 中复用组件逻辑的一种进阶技巧。
它本身并不是 React 的 API，而是一种 React 组件的设计理念，众多的 React 库已经证明了它的价值，例如耳熟能详的 react-redux。

高阶函数是把函数作为参数传入到函数中并返回一个新的函数。
把函数替换成组件，就是高阶组件。高阶组件就是一个函数，用来封装重复的逻辑。
传进去一个老组件，返回一个新组件

`const EnhancedComponent = higherOrderComponent(WrappedComponent);`

实现高阶组件的两种方式：
1. 属性代理(Props Proxy): 高阶组件操控传递给 WrappedComponent 的 props，
2. 反向继承（Inheritance Inversion）：高阶组件继承（extends）WrappedComponent。

可以用高阶组件做什么？
- 代码复用，逻辑抽象，抽离底层准备（bootstrap）代码
- 渲染劫持
- State 抽象和更改
- Props 更改


## 实例

例如，假设你有一个接受外部数据源渲染评论列表的CommentList组件：

```JavaScript
class CommentList extends React.Component {
  constructor() {
    super();
    this.handleChange = this.handleChange.bind(this);
    this.state = {
      // "DataSource" is some global data source
      comments: DataSource.getComments()
    };
  }

  componentDidMount() {
    // Subscribe to changes
    DataSource.addChangeListener(this.handleChange);
  }

  componentWillUnmount() {
    // Clean up listener
    DataSource.removeChangeListener(this.handleChange);
  }

  handleChange() {
    // Update component state whenever the data source changes
    this.setState({
      comments: DataSource.getComments()
    });
  }

  render() {
    return (
      <div>
        {this.state.comments.map((comment) => (
          <Comment comment={comment} key={comment.id} />
        ))}
      </div>
    );
  }
}
```
随后，你编写一个订阅单个博文的组件，其遵循类似的模式:

```JavaScript
class BlogPost extends React.Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
    this.state = {
      blogPost: DataSource.getBlogPost(props.id)
    };
  }

  componentDidMount() {
    DataSource.addChangeListener(this.handleChange);
  }

  componentWillUnmount() {
    DataSource.removeChangeListener(this.handleChange);
  }

  handleChange() {
    this.setState({
      blogPost: DataSource.getBlogPost(this.props.id)
    });
  }

  render() {
    return <TextBlock text={this.state.blogPost} />;
  }
}

```

CommentList和BlogPost是等价的，除了它们调用DataSource的不同方法，有不同的输出。但它们大部分的实现是类似的:

- 组件mount结束后，都添加DataSource的change监听
- 除了监听函数，无论什么时候datasource改变之后，都会调用setState
- 组件unmount之后，都会移除监听。

以上两个组件在大型项目中订阅及setState的方法会一次次出现。

**我们需要将其抽象出来，使得我们能够在一个地方定义逻辑并且在组件中共享。这就是高阶组件的优点**

写一个函数，能够创建类似于CommentList和BlogPost这类订阅DataSource的新的组件。这个函数接受一个子组件作为参数，这个子组件接受订阅数据源作为props，调用withSubscription如下：

```JavaScript
const CommentListWithSubscription = withSubscription(
  CommentList,
  (DataSource) => DataSource.getComments()
);

const BlogPostWithSubscription = withSubscription(
  BlogPost,
  (DataSource, props) => DataSource.getBlogPost(props.id)
});
```
第一个参数是被包含的组件，第二个参数根据给定的DataSource和当前的props取回我们需要的数据。

当CommentListWithSubscription和CommentListWithSubscription被渲染时，CommentList和BlogPost将会被传递data属性，其中包含从DataSource取回的最新数据。

```JavaScript
// This function takes a component...
function withSubscription(WrappedComponent, selectData) {
  // ...and returns another component...
  return class extends React.Component {
    constructor(props) {
      super(props);
      this.handleChange = this.handleChange.bind(this);
      this.state = {
        data: selectData(DataSource, props)
      };
    }

    componentDidMount() {
      // ... that takes care of the subscription...
      DataSource.addChangeListener(this.handleChange);
    }

    componentWillUnmount() {
      DataSource.removeChangeListener(this.handleChange);
    }

    handleChange() {
      this.setState({
        data: selectData(DataSource, this.props)
      });
    }

    render() {
      // ... and renders the wrapped component with the fresh data!
      // Notice that we pass through any additional props
      return <WrappedComponent data={this.state.data} {...this.props} />;
    }
  };
}
```

高阶组件既不会修改输入组件，也不会通过继承来复制行为。相反，通过包裹的形式，高阶组件将原先的组件组合在container组件中。高阶组件是纯函数，没有副作用。

被包裹的元素接受 container 的所有props和新的props，并使用其渲染输出。高阶组件并不关心数据将会如何或者为什么使用，并且被包裹的元素并不关心数据的源头。

因为withSubscription只是一个普通函数，你可以按照你的意愿添加很多或者很少的参数。例如，你可能希望data的名字是可以配置的，为了进一步隔离高阶组件和被包裹组件。或者你可以接受一个参数，它可以配置shouldComponentUpdate,或者是可以配置数据的来源。这都是可行的，因为高阶组件可以完全自己控制组件该如何定义。

和组件相类似，withSubscription和被包裹组件的联系是基于props的。只要为被包裹元素提供相同的属性，那么很容易将一个高阶组件组件转化成不同的高阶组件。例如，如果你想要改变数据获取的库，这将非常有用。






## 不要改变原始组件，而是使用组合

要忍住在高阶组件修改组件原型(或者修改其他)的冲动。

```JavaScript
function logProps(InputComponent) {
  InputComponent.prototype.componentWillReceiveProps(nextProps) {
    console.log('Current props: ', this.props);
    console.log('Next props: ', nextProps);
  }
  // The fact that we're returning the original input is a hint that it has
  // been mutated.
  return InputComponent;
}

// EnhancedComponent will log whenever props are received
const EnhancedComponent = logProps(InputComponent);
```
这里存在一些问题，一个是输入组件(InputComponent)不能脱离增强组件分别重用。更重要的是，如果将另一个也修改componentWillReceiveProps的高阶组件应用于EnhancedComponent组件，第一个高阶组件的功能将会别覆盖。这个高阶组件对函数组件不会起作用，因为函数组件没有生命周期函数。

具有修改功能的高阶组件是一个漏洞的抽象过程：用户必须知道它是怎么实现的从而避免与其他高阶组件的冲突。

**相比于修改，高阶组件最好是通过将输入组件包裹在容器组件的方式来使用组合:**
```js
function logProps(WrappedComponent) {
  return class extends React.Component {
    componentWillReceiveProps(nextProps) {
      console.log('Current props: ', this.props);
      console.log('Next props: ', nextProps);
    }
    render() {
      // Wraps the input component in a container, without mutating it. Good!
      return <WrappedComponent {...this.props} />;
    }
  }
}
```
这个高阶组件与之前的修改原型的版本有着相同的功能，但又避免了潜在的冲突可能。其在class类型和函数类型的组件都起作用。并且，因为是纯函数，它可以与其他高阶组件，甚至是自己组合。

你可能已经注意到高阶组件和被称为**容器组件**(container components)的模式有相同之处。容器组件是分离责任策略的一部分。这个分离策略是关于高层次和低层次关注点之间的责任分离。容器管理着类似订阅和状态这类东西，和给组件传递属性来处理类似渲染UI这类事情。高阶组件使用容器作为其实现的一部分。你可以将高阶组件视为定义参数化容器组件。

## 约定: 给包裹组件传递不相关的属性(Props)

高阶组件可以向组件添加功能。他不应该大幅度地改变功能。期望地是高阶组件返回的组件和被包裹组件具有相似的界面。

高阶组件应该通过props传递那些与特定功能无关的特性。大多数的高阶组件包含如下的render函数:

```js
render() {
  // Filter out extra props that are specific to this HOC and shouldn't be
  // passed through
  const { extraProp, ...passThroughProps } = this.props;

  // Inject props into the wrapped component. These are usually state values or
  // instance methods.
  const injectedProp = someStateOrInstanceMethod;

  // Pass props to wrapped component
  return (
    <WrappedComponent
      injectedProp={injectedProp}
      {...passThroughProps}
    />
  );
}
```

这个约定帮助确定高阶组件能够足够灵活和可以被重用。

## 约定: 最大化组合(Maximizing Composability)

不是所有的高阶组件看起来都是一样的。有时候，它接受包裹组件作为单一参数：

```js
const NavbarWithRouter = withRouter(Navbar);
```

通常情况下，高阶组件接受其他的参数。在Relay这个例子中，配置对象用来指定组件的数据依赖关系：

```js
const CommentWithRelay = Relay.createContainer(Comment, config);
```

高阶组件最常见的签名如下：

```js
// React Redux's `connect`
const ConnectedComment = connect(commentSelector, commentActions)(Comment);
```
## 约定: 最大化组合(Maximizing Composability)

不是所有的高阶组件看起来都是一样的。有时候，它接受包裹组件作为单一参数：

```js
const NavbarWithRouter = withRouter(Navbar);
```

通常情况下，高阶组件接受其他的参数。在Relay这个例子中，配置对象用来指定组件的数据依赖关系：

```js
const CommentWithRelay = Relay.createContainer(Comment, config);
```

高阶组件最常见的签名如下：

```js
// React Redux's `connect`
const ConnectedComment = connect(commentSelector, commentActions)(Comment);
```

**什么?!**，如果你把它分开，就更容易看到发生了什么。

```js
// connect is a function that returns another function
const enhance = connect(commentListSelector, commentListActions);
// The returned function is an HOC, which returns a component that is connected
// to the Redux store
const ConnectedComment = enhance(CommentList);
```

总的来说，`connect`是一个返回高阶组件的高阶函数！

这种形式看起来是混乱的或者是没有必要的，但是它是一个有用的属性。单参数的高阶组件类似于`connect`函数所返回的函数，其签名为`Component => Component`。返回的函数的输出类型和输入类型是相同的，很容易相互组合。

```js
// Instead of doing this...
const EnhancedComponent = connect(commentSelector)(withRouter(WrappedComponent))

// ... you can use a function composition utility
// compose(f, g, h) is the same as (...args) => f(g(h(...args)))
const enhance = compose(
  // These are both single-argument HOCs
  connect(commentSelector),
  withRouter
)
const EnhancedComponent = enhance(WrappedComponent)
```

(这个相同的属性还允许连接和其他增强型高阶属性作为装饰器(decorators),这是一个实验性的JavaScript提案)。

包括lodash(例如[lodash.flowRight](https://lodash.com/docs/4.17.4#flowRight))、[Redux](http://redux.js.org/docs/api/compose.html)和[Ramda](http://ramdajs.com/docs/#compose)在内的许多第三方库都提供了组合函数。


## 约定:为了方便调试包装显示名称(display name)

由高阶属性创建的容器组件在React开发者工具中显示同其他的组件相似。为了方便调试，选择一个显示名称(display name)，表示它是高阶组件的结果。

最常见的方法是给被包裹元素包裹一个显示名称(display name)。因此，如果你的高阶组件名字为`withSubscription`，被包裹的元素名称为`CommentList`，那就选择名称为`WithSubscription(CommentList)`。


```js
function withSubscription(WrappedComponent) {
  class WithSubscription extends React.Component {/* ... */}
  WithSubscription.displayName = `WithSubscription(${getDisplayName(WrappedComponent)})`;
  return WithSubscription;
}

function getDisplayName(WrappedComponent) {
  return WrappedComponent.displayName || WrappedComponent.name || 'Component';
}
```


## 警告

高阶组件有以下几个警告，如果你是刚接触React，这些警告可能不会立刻就被发现。

### 不要在render函数中使用高阶组件

React的diff算法(又称为reconciliation)使用组件标识符(component identity)来决定是否应该更新已有的子树或者将其抛出并安装一个新的子树。如果从render返回的组件等同于(===)之前render函数返回的组件，React将会迭代地通过diff算法更新子树到新的子树。如果不相等，则先前的子树将会完全卸载。

通常情况下，你不需要考虑这些。但是这对高阶组件非常重要，因为这意味你在组件的render方法中不能通过高阶组件产生组件:

```js
render() {
  // A new version of EnhancedComponent is created on every render
  // EnhancedComponent1 !== EnhancedComponent2
  const EnhancedComponent = enhance(MyComponent);
  // That causes the entire subtree to unmount/remount each time!
  return <EnhancedComponent />;
}
```

这个问题不仅仅关乎于性能，卸载组件会造成组件状态和其子元素全部丢失。

相反地，在组件定义外应用高阶组件，以便生成的组件只会被创建一次。然后，它的标识符在每次渲染中都是相同的。无论如何，这才是你想要的。

在一些极少的例子中你需要动态地引用高阶组件，你可以在组件的声明周期函数中使用或者在构造函数中使用。

### 静态方法必须复制

有时候，在React组价中定义静态方法是非常有用的。例如，Relay容器对外暴露一个静态方法`getFragment`，来帮助组合GraphQL代码。

当你将一个组件应用于高阶组件式，虽然原有的组件被容器组件所包裹，但这以为这新的组件没有之前组件的静态函数。

```js
// Define a static method
WrappedComponent.staticMethod = function() {/*...*/}
// Now apply an HOC
const EnhancedComponent = enhance(WrappedComponent);

// The enhanced component has no static method
typeof EnhancedComponent.staticMethod === 'undefined' // true
```

为了解决这个问题，在返回之前，可以向容器组件中复制原有的静态方法：

```js
function enhance(WrappedComponent) {
  class Enhance extends React.Component {/*...*/}
  // Must know exactly which method(s) to copy :(
  Enhance.staticMethod = WrappedComponent.staticMethod;
  return Enhance;
}
```

然而，这需要你明确地知道哪些方法需要别复制。你可以使用[hoist-non-react-statics](https://github.com/mridgway/hoist-non-react-statics)来自动复制非React的静态方法。

```js
import hoistNonReactStatic from 'hoist-non-react-statics';
function enhance(WrappedComponent) {
  class Enhance extends React.Component {/*...*/}
  hoistNonReactStatic(Enhance, WrappedComponent);
  return Enhance;
}
```

另一个有效的方法是将静态方法与组件本身相分离：

```js
// Instead of...
MyComponent.someFunction = someFunction;
export default MyComponent;

// ...export the method separately...
export { someFunction };

// ...and in the consuming module, import both
import MyComponent, { someFunction } from './MyComponent.js';
```

### Refs不会被传递

尽管惯例是高阶组件会给被包裹组件传递所有的属性(props)，但是不会传递`refs`。因为`ref`不是一个属性，就像`key`一样，它是由React特殊处理的。如果你给高阶组件产生的组件的元素添加`ref`,`ref`引用的是外层的容器组件的实例，而不是被包裹的组件。

如果你遇到这个问题，最好的解决方法是避免使用`ref`。有时候，React新手用户依赖于`refs`，这时候`props`是更好的选择。

也就是说，也就是说`refs`有时候是必要的，否则React也不会提供`refs`。
选中输入框(focusing an input field)是一个你可能希望强制控制组件的例子。在这种例子中，一个解决办法是通过起一个别名，将`ref`作为一个普通的props传递：

```js
function Field({ inputRef, ...rest }) {
  return <input ref={inputRef} {...rest} />;
}

// Wrap Field in a higher-order component
const EnhancedField = enhance(Field);

// Inside a class component's render method...
<EnhancedField
  inputRef={(inputEl) => {
    // This callback gets passed through as a regular prop
    this.inputEl = inputEl
  }}
/>

// Now you can call imperative methods
this.inputEl.focus();
```

无论如何，这都是一个完美的解决方案。我们倾向于`refs`是由库去处理，而不是要求你手动地处理。我们正在寻找解决这个问题的办法，以便在使用高阶组件时不需要注意这个问题。


# [参考链接]
[React 进阶之高阶组件](https://github.com/MrErHu/React-Advanced-Guides-CN/blob/master/doc/Higher%20Order%20Components.md)

[深入理解 React 高阶组件](https://www.jianshu.com/p/0aae7d4d9bc1)

## 一个简单的高阶组件
```js
import React, {Component} from 'react';
import simpleHoc from './simpleHoc';

class Usual extends Component {
    render() {
        console.log(this.props, 'props);
        return (
            <div>
                Usual
            </div>
        )
    }
}
export default simpleHoc(Usual);
```

simpleHoc.js
```js
import React, { Component } from 'react';

const simpleHoc = wrappedComponent => {
    console.log('simpleHoc');
    return class extends Component {
        render() {
            return <wrappedComponent {...this.props} />
        }
    }
}
export default simpleHoc;
```

## 装饰器模式

高阶组件可以看做是装饰器模式(Decorator Pattern) 在React的实现。即允许向一个现有对象添加新功能，同时不改变其结构，属于包装模式(Wrapper Pattern)的一种

上面例子可以改写为
```js
import React, { Component } from 'react';
import simpleHoc from './simple-hoc';

@simpleHoc
export default class Usual extends Component {
  render() {
    return (
      <div>
        Usual
      </div>
    )
  }
}
```

## 两种形式

### 属性代理

属性代理本质上是返回了一个全新的 Component，此时原组件的静态属性、生命周期等一系列内容都被屏蔽，导致上层的高阶组件、对组件的操作都拿不到应有的内容。

一个简单例子中用的就是属性代理(Props Proxy)的形式。本来传给Usual的props在hoc中接收到，就是props proxy. 这里可以做一些操作

```js
function ppHOC(WrappedComponent) {
  return class PP extends React.Component {
    render() {
      return <WrappedComponent {...this.props}/>
    }
  }
}

```
这里高阶组件的 render 方法返回了一个 type 为 WrappedComponent 的 React Element（也就是被包装的那个组件），我们把高阶组件收到的 props 传递给它，因此得名 Props Proxy。

注意：
```js
<WrappedComponent {...this.props}/>
// is equivalent to
React.createElement(WrappedComponent, this.props, null)
```

Props Proxy 可以做什么
- 更改 props
- 通过 refs 获取组件实例
- 抽象 state
- 把 WrappedComponent 与其它 elements 包装在一起

- 操作props

 接收到props可以做任何读取，编辑，删除等自定义操作。都可以通过props再传下去

```js
import React, { Component } from 'react';

const propsProxyHoc = WrappedComponent => class extends Component {

  handleClick() {
    console.log('click');
  }

  render() {
    return (<WrappedComponent
      {...this.props}
      handleClick={this.handleClick}
    />);
  }
};
export default propsProxyHoc;
```
在Usual组件中会接收到handleClick属性

## 反向继承

反向继承(Inheritance Inversion), 简称II，

简单的实现：
```js
function iiHOC(WrappedComponent) {
  return class Enhancer extends WrappedComponent {
    render() {
      return super.render()
    }
  }
}
```
返回的高阶组件类（Enhancer）继承了 WrappedComponent。这被叫做反向继承是因为 WrappedComponent 被动地被 Enhancer 继承，而不是 WrappedComponent 去继承 Enhancer。通过这种方式他们之间的关系倒转了。

反向继承允许高阶组件通过 this 关键词获取 WrappedComponent，意味着它可以获取到 state，props，组件生命周期（component lifecycle）钩子，以及渲染方法（render）。









