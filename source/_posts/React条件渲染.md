---
title: React条件渲染
date: 2018-11-23 17:01:36
updated: 2018-11-23 17:01:36
tags:
- React
- 代码优化
---

[参考链接](https://github.com/dt-fe/weekly/blob/master/61.%E7%B2%BE%E8%AF%BB%E3%80%8AReact%20%E5%85%AB%E7%A7%8D%E6%9D%A1%E4%BB%B6%E6%B8%B2%E6%9F%93%E3%80%8B.md)
模板条件渲染开发中常用，什么时候用什么方式？怎么写较好？
先罗列常见方式

# IF/ELSE
```javascript
function render() {
  if (renderComponent1) {
    return <Component1 />;
  } else {
    return <div />;
  }
}

```

# return null
不需要返回可以返回null, 代替空div, 提升效率
```javascript
function render() {
  if (renderComponent1) {
    return <Component1 />;
  } else {
    return null;
  }
}

```

# 组件变量
将组件赋值给变量，可以在return前任意修改
```javascript
function render() {
  let component = null;

  if (renderComponent1) {
    component = <Component1 />;
  }

  return component;
}

```

# 三元操作符
逻辑不复杂可以避免if else
```javascript
function render() {
  return renderComponent1 ? <Component1 /> : null;
}
```

# &&
最方便了
```javascript
function render() {
  return renderComponent1 && <Component1 />;
}

```
# IIFE
立即执行函数
```javascript
(function myFunction(/* arguments */) {
  // ...
})(/* arguments */);

<!-- ？？？什么情况用？？？ -->
function render() {
  return (
    <div>
      {(() => {
        if (renderComponent1) {
          return <Component1 />;
        } else {
          return <div />;
        }
      })()}
    </div>
  );
}

```
# 子组件
将一大块的逻辑拆分成子组件
```javascript
function render() {
  return (
    <div>
      <SubRender />
    </div>
  );
}

function SubRender() {
  if (renderComponent1) {
    return <Component1 />;
  } else {
    return <div />;
  }
}

```
# IF 组件--什么时候用？？？
做一个条件渲染组件 IF 代替 js 函数的 if：
```javascript
<If condition={true}>
  <span>Hi!</span>
</If>

```
这个组件实现也很简单

```javascript
const If = props => {
  const condition = props.condition || false;
  const positive = props.then || null;
  const negative = props.else || null;

  return condition ? positive : negative;
};

```

# 高阶组件
返回一个新组件的函数，并且接收一个组件作为参数
在高阶组件里写条件语句，返回不同的组件即可：
```javascript
function higherOrderComponent(Component) {
  return function EnhancedComponent(props) {
    if (condition) {
      return <AnotherComponent {...props} />;
    }

    return <Component {...props} />;
  };
}

```

# 理解

要不要封装，怎么封装，取决于应用复杂度。

对于任何代码封装，都会增加这段连接逻辑的复杂度

假定无论如何代码的复杂度都是恒定不变的，下面这段代码，连接复杂度为0，而对于render函数而言，
逻辑复杂度是100.
```javascript
function render() {
  if (renderComponent) {
    return isOk ? <Component1 /> : <Component2 />;
  } else {
    return <div />;
  }
}
```

拆分成两个函数，逻辑复杂度对render SubComponent来说都是50，但链接复杂度是50:
```javascript
function render() {
    if (renderComponent) {
        return <SubComponent/>;
    } else {
        return <div/>;
    }
}

function SubComponent() {
    return isOk ? <Component1 /> : <Component2 />
}
```
可以看到，通过函数拆分，降低了每个函数的逻辑复杂度，却提高了连接复杂度。

如果

