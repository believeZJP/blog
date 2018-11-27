---
title: React条件渲染
date: 2018-11-23 17:01:36
updated: 2018-11-23 17:01:36
tags:
- React
- 代码优化
---

[参考链接](https://github.com/dt-fe/weekly/blob/master/61.%E7%B2%BE%E8%AF%BB%E3%80%8AReact%20%E5%85%AB%E7%A7%8D%E6%9D%A1%E4%BB%B6%E6%B8%B2%E6%9F%93%E3%80%8B.md)
模板条件渲染在开发中常用，什么时候用什么方式？怎么写较好？

先罗列常见方式:

# IF/ELSE
```javascript
function render() {
  if (flag) {
    return <Component1 />;
  } else {
    return <div />;
  }
}

```

<!--- more --->

# return null
不需要返回可以返回null, 代替空div, 提升效率
```javascript
function render() {
  if (flag) {
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

  if (flag) {
    component = <Component1 />;
  }

  return component;
}

```

# 三元操作符
逻辑不复杂可以避免if else
```javascript
function render() {
  return flag ? <Component1 /> : null;
}
```

# &&
最方便!!!
```javascript
function render() {
  return flag && <Component1 />;
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
        if (flag) {
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
  if (flag) {
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
    if (flag) {
      return <AnotherComponent {...props} />;
    }

    return <Component {...props} />;
  };
}

```

# 理解

要不要封装，怎么封装，取决于应用复杂度。

对于任何代码封装，都会增加这段代码连接逻辑的复杂度。

假定无论如何代码的复杂度都是恒定不变的，下面这段代码，连接复杂度为0，而对于render函数而言，
逻辑复杂度是100.
```javascript
function render() {
  if (flag) {
    return isOk ? <Component1 /> : <Component2 />;
  } else {
    return <div />;
  }
}
```

拆分成两个函数，逻辑复杂度对render, SubComponent来说都是50，但连接复杂度是50:
```javascript
function render() {
    if (flag) {
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

> 假设一个程序员可以一次性轻松记忆10个函数。如果再多，函数之间的调用关系会让人头大。

## 应用较小时

应用较小时，假设共有10个函数，如果做了逻辑抽象，拆分出了10个子函数，那么总逻辑复杂度不变，函数变成20个。

此时，要修改项目，需要找到关键代码的位置。

如果没有做逻辑抽象， 小明可以一下记住10个函数，很快完成需求。

做了逻辑抽象，需要理解的逻辑复杂度是不变的。但要读20个函数，小明需要在线索中不断跳转，还是只找了10个关键函数，但一共就20个函数，逻辑并不复杂，这值得吗？

这时，会觉得，简单的逻辑，却花了较长的时间找代码。

## 应用较大时

应用较大时，假设有500个函数，不考虑抽象后带来的复用好处，假设都无法复用，那么做逻辑抽象后，总逻辑复杂度不变，函数变成了1000个。

小明接到需求开始维护项目。
从一开始没能理解项目的全貌，所以开始一步步探索。

现在有两种选择：一是在未做逻辑抽象时的探索，一是在做过逻辑抽象后的探索。

假设没有做逻辑抽象，小明需面对500个这种函数：

```JavaScript
function render() {
  if (renderComponent) {
    return isOk ? <Component1 /> : <Component2 />;
  } else {
    return isReady ? <Component3 /> : <Component4 />;
  }
}
```

如果做了逻辑抽象，需面对1000个这种函数
```javascript
function render() {
  if (renderComponent) {
    return <Component1And2 />;
  } else {
    return <Component3And4 />;
  }
}
```

**项目庞大后，总函数数量并不会影响对线索的查找，而总线索深度也几乎总是固定的，一般在5层左右。**

小明理解5个或10个函数成本差不多，但没有做逻辑抽象时，这5个函数各自掺杂了其他逻辑，这5个函数各自掺杂了其他逻辑，反而影响对函数的理解。

这时做逻辑抽象是合适的。

# 总结
总的来说，推荐使用子函数，子组件，IF组件，高阶组件做条件渲染，因为这四种方式都能提高程序的抽象能力。

往往抽象后的代码会更具有复用性，单个函数逻辑更清晰，在切面编程时更利于理解。

当项目很简单时，整个项目的理解成本都很低，抽象带来的复杂度反而让项目变成了需要切面编程时就得不偿失了。

总结：
- 当项目很简单，或条件渲染的逻辑确认无法复用时，推荐在代码中用 && 或三元运算符、IIFE等直接实现条件渲染。
- 当项目复杂时，尽量使用子函数，子组件，IF组件，高阶组件等方式做更有抽象度的条件渲染。
- 在做逻辑抽象时，考虑下项目的复杂度, 避免因为抽象带来的成本增加，让本可以整体理解的项目变得支离破碎。

