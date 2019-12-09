---
title: React 高阶组件
date: 2018-12-09 19:30:57
updated: 2018-12-09 19:30:57
tags:
    - React
---
[TOC]

## 高阶组件

高阶组件（ higher-order component ，HOC ）是 React 中复用组件逻辑的一种进阶技巧。
它本身并不是 React 的 API，而是一种 React 组件的设计理念，众多的 React 库已经证明了它的价值，例如耳熟能详的 react-redux。

<!-- more -->

高阶函数是把函数作为参数传入到函数中并返回一个新的函数。
把函数替换成组件，就是高阶组件。高阶组件就是一个函数，用来封装重复的逻辑。
传进去一个老组件，返回一个新组件

`const EnhancedComponent = higherOrderComponent(WrappedComponent);`

高阶组件可以抽离公共逻辑，像洋葱一样层层叠加给组件，每一层职能分明，可以方便地抽离与增添。在优化代码或解耦组件时，可以考虑使用高阶组件模式。

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

> **我们需要将其抽象出来，使得我们能够在一个地方定义逻辑并且在组件中共享。这就是高阶组件的优点**

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

例二:

```js
export default function withHeader(WrappedComponent) {
  return class HOC extends Component {
    render() {
      return <div>
        <div className="demo-header">
          我是标题
        </div>
        <WrappedComponent {...this.props}/>
      </div>
    }
  }
}
```

在其他组件中引用

```js
@withHeader
export default class Demo extends Component {
  render() {
    return (
      <div>
        我是一个普通组件
      </div>
    );
  }
}
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

- 操作 props
- 通过 refs 获取组件实例
- 抽象 state
- 把 WrappedComponent 与其它 elements 包装在一起

### 操作props

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

在修改或删除重要 props 的时候要小心，你可能应该给高阶组件的 props 指定命名空间（namespace），以防破坏从外传递给 WrappedComponent 的 props。

例子：添加新 props。这个currentLoggedInUser可以在 WrappedComponent 通过 this.props.user 获取

```js
function ppHOC(WrappedComponent) {
  return class PP extends React.Component {
    render() {
      const newProps = {
        user: currentLoggedInUser
      }
      return <WrappedComponent {...this.props} {...newProps}/>
    }
  }
}
```

### 通过refs获取组件实例

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

### 抽象state

这里不是通过ref获取state， 而是通过 { props, 回调函数 } 传递给wrappedComponent组件，通过回调函数获取state。这里用的比较多的就是react处理表单的时候。通常react在处理表单的时候，一般使用的是受控组件（文档），即把input都做成受控的，改变value的时候，用onChange事件同步到state中。

可以通过向 WrappedComponent 传递 props 和 callbacks（回调函数）来抽象 state，这和 React 中另外一个组件构成思想 [Presentational and Container Components](https://medium.com/@dan_abramov/smart-and-dumb-components-7ca2f9a7c7d0) 很相似。

```js
// 普通组件Login
import React, { Component } from 'react';
import formCreate from './form-create';

@formCreate
export default class Login extends Component {
  render() {
    return (
      <div>
        <div>
          <label id="username">
            账户
          </label>
          <input name="username" {...this.props.getField('username')}/>
        </div>
        <div onClick={this.props.handleSubmit}>提交</div>
      </div>
    )
  }
}
```

form-create.js

```js
//HOC
import React, { Component } from 'react';

const formCreate = WrappedComponent => class extends Component {

  constructor() {
    super();
    this.state = {
      fields: {},
    }
  }
  onChange = key => e => {
    const { fields } = this.state;
    fields[key] = e.target.value;
    this.setState({
      fields,
    })
  }
  handleSubmit = () => {
    console.log(this.state.fields);
  }
  getField = fieldName => {
    return {
      onChange: this.onChange(fieldName),
    }
  }
  render() {
    const props = {
      ...this.props,
      handleSubmit: this.handleSubmit,
      getField: this.getField,
    }
    return (<WrappedComponent
      {...props}
    />);
  }
};
export default formCreate;
```

这里我们把state，onChange等方法都放到HOC里，其实是遵从的react组件的一种规范，子组件简单，傻瓜，负责展示，逻辑与操作放到Container。比如说我们在HOC获取到用户名密码之后，再去做其他操作，就方便多了，而state，处理函数放到Form组件里，只会让Form更加笨重，承担了本不属于它的工作，这样我们可能其他地方也需要用到这个组件，但是处理方式稍微不同，就很麻烦了。

### 把 WrappedComponent 与其它 elements 包装在一起

出于操作样式、布局或其它目的，你可以将 WrappedComponent 与其它组件包装在一起。一些基本的用法也可以使用正常的父组件来实现（附录 B），但是就像之前所描述的，使用高阶组件你可以获得更多的灵活性。

```js
function ppHOC(WrappedComponent) {
  return class PP extends React.Component {
    render() {
      return (
        <div style={{display: 'block'}}>
          <WrappedComponent {...this.props}/>
        </div>
      )
    }
  }
}

```

## 反向继承

反向继承(Inheritance Inversion), 简称II，

简单的实现：

```js
function iiHOC(WrappedComponent) {
  return class Enhancer extends WrappedComponent {
    componentDidMount() {
      // 可以方便地得到state，做一些更深入的修改。
      console.log(this.state);
    }
    render() {
      return super.render()
    }
  }
}
```

返回的高阶组件类（Enhancer）继承了 WrappedComponent。这被叫做反向继承是因为 WrappedComponent 被动地被 Enhancer 继承，而不是 WrappedComponent 去继承 Enhancer。通过这种方式他们之间的关系倒转了。

反向继承允许高阶组件通过 this 关键词获取 WrappedComponent，意味着它可以获取到 state，props，组件生命周期（component lifecycle）钩子，以及渲染方法（render）。

**可以用反向继承高阶组件做什么？**

- 渲染劫持（Render Highjacking）
- 操作 state

### 渲染劫持

被叫做渲染劫持是因为高阶组件控制了 WrappedComponent 生成的渲染结果，并且可以做各种操作。

通过渲染劫持你可以：

- 『读取、添加、修改、删除』任何一个将被渲染的 React Element 的 props
- 在渲染方法中读取或更改 React Elements tree，也就是 WrappedComponent 的 children
- 根据条件不同，选择性的渲染子树
- 给子树里的元素变更样式

*渲染 指的是 WrappedComponent.render 方法

> 你无法更改或创建 props 给 WrappedComponent 实例，因为 React 不允许变更一个组件收到的 props，但是你可以在 render 方法里更改子元素/子组件们的 props。

就像之前所说的，反向继承的高阶组件不能保证一定渲染整个子元素树，这同时也给渲染劫持增添了一些限制。通过反向继承，你只能劫持 WrappedComponent 渲染的元素，这意味着如果 WrappedComponent 的子元素里有 Function 类型的 React Element，你不能劫持这个元素里面的子元素树的渲染。

例子1：条件性渲染。如果 this.props.loggedIn 是 true，这个高阶组件会原封不动地渲染 WrappedComponent，如果不是 true 则不渲染（假设此组件会收到 loggedIn 的 prop）

```js
function iiHOC(WrappedComponent) {
  return class Enhancer extends WrappedComponent {
    render() {
      if (this.props.loggedIn) {
        return super.render()
      } else {
        return null
      }
    }
  }
}
```

例子2：通过 render 来变成 React Elements tree 的结果

```js
function iiHOC(WrappedComponent) {
  return class Enhancer extends WrappedComponent {
    render() {
      const elementsTree = super.render()
      let newProps = {};
      if (elementsTree && elementsTree.type === 'input') {
        newProps = {value: 'may the force be with you'}
      }
      const props = Object.assign({}, elementsTree.props, newProps)
      const newElementsTree = React.cloneElement(elementsTree, props, elementsTree.props.children)
      return newElementsTree
    }
  }
}
```

在这个例子中，如果 WrappedComponent 的顶层元素是一个 input，则改变它的值为 “may the force be with you”。
这里你可以做任何操作，比如你可以遍历整个 element tree 然后变更某些元素的 props。这恰好就是 Radium 的工作方式。

> 注意：你不能通过 Props Proxy 来做渲染劫持
> 即使你可以通过 WrappedComponent.prototype.render 获取它的 render 方法，你需要自己手动模拟整个实例以及生命周期方法，而不是依靠 React，这是不值当的，应该使用反向继承来做到渲染劫持。要记住 React 在内部处理组件的实例，而你只通过 this 或 refs 来处理实例。

### 操作 state

高阶组件可以 『读取、修改、删除』WrappedComponent 实例的 state，如果需要也可以添加新的 state。需要记住的是，你在弄乱 WrappedComponent 的 state，可能会导致破坏一些东西。通常不建议使用高阶组件来读取或添加 state，添加 state 需要使用命名空间来防止与 WrappedComponent 的 state 冲突。

例子：通过显示 WrappedComponent 的 props 和 state 来 debug

```js
export function IIHOCDEBUGGER(WrappedComponent) {
  return class II extends WrappedComponent {
    render() {
      return (
        <div>
          <h2>HOC Debugger Component</h2>
          <p>Props</p> <pre>{JSON.stringify(this.props, null, 2)}</pre>
          <p>State</p><pre>{JSON.stringify(this.state, null, 2)}</pre>
          {super.render()}
        </div>
      )
    }
  }
}
```

### HOC和Mixin的比较

![hoc和Mixin比较](/img/mixin-hoc.png)

高阶组件属于函数式编程(functional programming)思想，对于被包裹的组件时不会感知到高阶组件的存在，而高阶组件返回的组件会在原来的组件之上具有功能增强的效果。而Mixin这种混入的模式，会给组件不断增加新的方法和属性，组件本身不仅可以感知，甚至需要做相关的处理(例如命名冲突、状态维护)，一旦混入的模块变多时，整个组件就变的难以维护，也就是为什么如此多的React库都采用高阶组件的方式进行开发。

作者：请叫我王磊同学
链接：<https://juejin.im/post/5914fb4a0ce4630069d1f3f6>
来源：掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

## 应用场景

- 用高阶组件优化之前老项目写的不好的地方，比如两个页面UI几乎一样，功能几乎相同，仅仅几个操作不太一样，却写了两个耦合很多的页面级组件。当我去维护它的时候，由于它的耦合性过多，经常会添加一个功能(这两个组件都要添加)，我要去改完第一个的时候，还要改第二个。而且有时候由于记性不好，会忘掉第二个... 就会出现bug再返工。所以加新功能时，写一个高阶组件，往HOC里添加方法，把那两个组件包装一下，也就是属性代理。这样新代码就不会再出现耦合，旧的逻辑并不会改变

- 另一种情况是之前写过一个组件A，做完上线，之后产品加了一个新需求，很奇怪要做的组件B跟A几乎一模一样，但稍微有区别。那我可能就通过II的方式去继承之前的组件A，比如它在didMount去fetch请求，需要的数据是一样的。不同的地方我就会放到HOC里，存储新的state这样，再通过劫持渲染，把不同的地方，添加的地方进行处理。但其实这算Hack的一种方式，能快速解决问题，也反映了组件设计规划之初有所不足(原因比较多)。

- Container解决不了的时候甚至不太优雅的时候。其实大部分时候包一层Container组件也能做到差不多的效果，比如操作props，渲染劫持。但其实还是有很大区别的。比如我们现在有两个功能的container，添加样式和添加处理函数的，对Usual进行包装。栗子：

```js
//usual
class Usual extends Component {

  render() {
    console.log(this.props, 'props');
    return <div>
      Usual
    </div>
  }
};
export default Usual;
//console - Object {handleClick: function}  "props"
```

```js
import React, { Component } from 'react';
import Usual from './usual';

class StyleContainer extends Component {

  render() {
    return (<div style={{ color: '#76d0a3' }}>
      <div>container</div>
      <Usual {...this.props} />
    </div>);
  }
}

export default StyleContainer;
```

```js
import React, { Component } from 'react';
import StyleContainer from './container-add-style';

class FuncContainer extends Component {
  handleClick() {
    console.log('click');
  }

  render() {
    const props = {
      ...this.props,
      handleClick: this.handleClick,
    };
    return (<StyleContainer {...props} />);
  }
}

export default FuncContainer;
```

外层Container必须要引入内层Container，进行包装，还有props的传递，同样要注意包装的顺序。当然你可以把所有的处理都放到一个Container里。那用HOC怎么处理呢，相信大家有清晰的答案了。

```js
const addFunc = WrappedComponent => class extends Component {
  handleClick() {
    console.log('click');
  }

  render() {
    const props = {
      ...this.props,
      handleClick: this.handleClick,
    };
    return <WrappedComponent {...props} />;
  }
};
```

```js
const addStyle = WrappedComponent => class extends Component {

  render() {
    return (<div style={{ color: '#76d0a3' }}>
      <WrappedComponent {...this.props} />
    </div>);
  }
};
```

```js
const WrappenComponent = addStyle(addFunc(Usual));

class WrappedUsual extends Component {

  render() {
    console.log(this.props, 'props');
    return (<div>
      <WrappedComponent />
    </div>);
  }
}
```

显然HOC是更优雅一些的，每个HOC都定义自己独有的处理逻辑，需要的时候只需要去包装你的组件。相较于Container的方式，HOC耦合性更低，灵活性更高，可以自由组合，更适合应付复杂的业务。每个HOC负责独立的功能，比如可能只是一个Loading的效果，很多列表页都需要，用HOC只需要包装一下就可以了，不需要在每个组件里再重写这部分逻辑了。当然当你的需求很简单的时候，还是用Container去自由组合，应用场景需要你清楚。

## 案例学习

### React-Redux

React-Redux 是 Redux 官方的对于 React 的绑定。 其中一个方法 connect 处理了所有关于监听 store 的 bootstrap 代码 以及清理工作，这是通过 Props Proxy 来实现的。

如果你曾经使用过 Flux 你会知道 React 组件需要和一个或多个 store 连接，并且添加/删除对 store 的监听，从中选择需要的那部分 state。而 React-Redux 帮你把它们实现了，自己就不用再去写这些了。

### Radium

Radium 是一个增强了行内（inline）css 能力的库，它允许了在 inline css 使用 CSS 伪选择器。[点此](https://github.com/FormidableLabs/radium)了解关于使用 inline css 的好处.

那么，Radium 是怎么允许 inline css 来实现 CSS 伪选择器的呢（比如 hover）？它实现了一个反向继承来使用渲染劫持，添加适当的事件监听来模拟 CSS 伪选择器。这要求 Radium 读取整个 WrappedComponent 将要渲染的元素树，每当找个某个元素带有 style prop，它就添加对应的时间监听 props。简单地说，Radium 修改了原先元素树的 props（实际上会更复杂，但这么说你可以理解到要点所在）。

Radium 只暴露了一个非常简单的 API 给开发者。这非常惊艳，因为开发者几乎不会注意到它的存在和它是怎么发挥作用的，而实现了想要的功能。这揭露了高阶组件的能力。

## 附录

### 附录A: 高阶组件和参数

有时，在高阶组件中使用参数是很有用的。这个在以上所有例子中都不是很明显，但是对于中等的 JavaScript 开发者是比较自然的事情。让我们迅速的介绍一下。

例子：一个简单的 Props Proxy 高阶组件搭配参数。重点是这个 HOCFactoryFactory 方法。

```js
function HOCFactoryFactory(...params) {
  // do something with params
  return function HOCFactory(WrappedComponent) {
    return class HOC extends React.Component {
      render() {
        return <WrappedComponent {...this.props}/>
      }
    }
  }
}
```

你可以这样使用它：

```js
HOCFactoryFactory(params)(WrappedComponent)
//or
@HOCFatoryFactory(params)
class WrappedComponent extends React.Component{}
```

例子：

```js
// 如果传入参数，则传入的参数将作为组件的标题呈现
@withHeader('Demo')
export default class Demo extends Component {
  render() {
    return (
      //...
    );
  }
}
```

withHead.js 接收参数，返回高阶组件

```js
export default function (title) {
  return function (WrappedComponent) {
    return class HOC extends Component {
      render() {
        return <div>
          <div className="demo-header">
            {title
              ? title
              : '我是标题'}
          </div>
          <WrappedComponent {...this.props}/>
        </div>
      }
    }
  }
}
```

ES6写法

```js
export default(title) => (WrappedComponent) => class HOC extends Component {
  render() {
    return <div>
      <div className="demo-header">
        {title
          ? title
          : '我是标题'}
      </div>
      <WrappedComponent {...this.props}/>
    </div>
  }
}
```
>
    柯里化 Curry
    概念：只传递函数的一部分参数来调用它，让它返回一个函数去处理剩下的参数。

    函数签名：fun(params)(otherParams)
    应用：在React里，通过柯里化，我们可以通过传入不同的参数来得到不同的高阶组件。
>

```js

```

### 附录 B：和父组件的不同之处

父组件就是单纯的 React 组件包含了一些子组件（children）。React 提供了获取和操作一个组件的 children 的 APIs。

例子：父组件获取它的 children

```js
class Parent extends React.Component {
  render() {
    return (
      <div>
        {this.props.children}
      </div>
    )
  }
}

render((
  <Parent>
    {children}
  </Parent>
), mountNode)

```

现在来总结一下父组件能做和不能做的事情（与高阶组件对比）：

- 渲染劫持
- 操作内部 props
- 抽象 state。但是有缺点，不能再父组件外获取到它的 state，除非明确地实现了钩子。
- 与新的 React Element 包装。这似乎是唯一一点，使用父组件要比高阶组件强，但高阶组件也同样可以实现。
- Children 的操控。如果 children 不是单一 root，则需要多添加一层来包括所有 children，可能会使你的 markup 变得有点笨重。使用高阶组件可以保证单一 root。
- 父组件可以在元素树立随意使用，它们不像高阶组件一样限制于一个组件。

通常来讲，能使用父组件达到的效果，尽量不要用高阶组件，因为高阶组件是一种更 hack 的方法，但同时也有更高的灵活性。

**高阶组件作为一个函数，它可以更加纯粹地关注业务逻辑层面的代码，比如数据处理，数据校验，发送请求等，可以改善目前代码里业务逻辑和UI逻辑混杂在一起的现状。父组件则是UI层的东西，我们先前经常把一些业务逻辑处理放在父组件里，这样会造成父组件混乱的情况。为了代码进一步解耦，可以考虑使用高阶组件这种模式。**

# 注意点

[原文链接](https://reactjs.org.cn/doc/higher-order-components.html)

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

## 组合多个高阶组件

```js
@withHeader
@withLoading
class Demo extends Component{

}
```

使用compose可以简化上述过程，也能体现函数式编程的思想。

```js
const enhance = compose(withHeader,withLoading);
@enhance
class Demo extends Component{

}
```

> 组合 Compose
> compose可以帮助我们组合任意个（包括0个）高阶函数，例如compose(a,b,c)返回一个新的函数d，函数d依然接受一个函数作为入参，只不过在内部会依次调用c,b,a，从表现层对使用者保持透明。
> 基于这个特性，我们便可以非常便捷地为某个组件增强或减弱其特征，只需要去变更compose函数里的参数个数便可。
compose函数实现方式有很多种，这里推荐其中一个recompact.compose，详情见下方参考类库。

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

### 使用compose组合HOC

函数式编程的套路... 例如应用redux中的middleware以增强功能。redux-middleware解析

```js
const addFuncHOC = ...
const addStyleHOC = ...//省略

const compose = (...funcs) => component => {
  if (funcs.lenght === 0) {
    return component;
  }
  const last = funcs[funcs.length - 1];
  return funcs.reduceRight((res, cur) => cur(res), last(component));
};

const WrappedComponent = compose(addFuncHOC, addStyleHOC)(Usual);
```

# 实战

## loading组件

实现Loading组件时，发现需要去拦截它的渲染过程，故使用了反向继承的方式来完成。

```js
import React, {Component} from 'react';
import {Spin} from 'antd';
export default function (loadingCheck) {
  return function (WrappedComponent) {
    return class extends WrappedComponent {
      componentWillUpdate(nextProps, nextState) {
        console.log('withLoading将会更新');
      }
      render() {
        if (loadingCheck(this.props)) {
          return <Spin tip="加载中" size="large">
            {super.render()}
          </Spin>
        } else {
          return super.render();
        }
      }
    }
  }
}

// 使用
@withLoading(props => {
  return props.IndexStore.accountList.length == 0;
})
```

## 实现一个copy组件

实现copy组件的时候，我们发现不需要去改变组件内部的展示方式，只是为其在外围增加一个功能，并不会侵入被传入的组件，故使用了属性代理的方式。

```js
import gotem from 'gotem';
import React, {Component} from 'react';
import ReactDom from 'react-dom';
import {message} from 'antd';
export default copy = (targetName) => {
  return (WrappedComponent) => {
    return class extends Component {
      componentDidMount() {
        const ctx = this;
        const dom = ReactDom.findDOMNode(ctx);
        const nodes = {
          trigger: dom,
          // targetName为DOM选择器，复制组件将会复制它的值
          target: dom.querySelector(targetName)
        };
        gotem(nodes.trigger, nodes.target, {
          success: function () {
            message.success('复制成功');
          },
          error: function () {
            message.error('复制失败，请手动输入');
          }
        });
      }
      render() {
        return <WrappedComponent {...this.props}/>;
      }
    };
  };
}
// 使用
// 传入 h3 ，让复制组件去获取它的值
@copy('h3')
class Info extends Component {
  render() {
    return (
      <div>
        <h3>
          阿里云,点击复制这段文字
        </h3>
      </div>
    );
  }
}
```

# [参考链接]

[React 进阶之高阶组件](https://github.com/MrErHu/React-Advanced-Guides-CN/blob/master/doc/Higher%20Order%20Components.md)

[深入理解 React 高阶组件](https://www.jianshu.com/p/0aae7d4d9bc1)

[精度React组件](https://github.com/dt-fe/weekly/blob/master/12.%E7%B2%BE%E8%AF%BB%20React%20%E9%AB%98%E9%98%B6%E7%BB%84%E4%BB%B6.md)
