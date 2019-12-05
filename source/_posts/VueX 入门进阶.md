---
title: VueX入门进阶
date: 2017-12-28 15:57:18
updated: 2017-12-28 15:57:18
tags:
---

# Vuex简介

>Vuex 是一个专为 Vue.js应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态，并以相应的规则保证状态以一种可预测的方式发生变化。
>状态管理？ data中的属性 需要共享给其他vue组件使用的部分，就叫做状态。简单的说就是data中需要共用的属性。
>比如，用户的登录状态，用户名称等相关信息。如果不把这些属性设置为状态，每个页面遇到后，都会发送请求，从服务器端获取，再返回前端。在大型项目中会有很多共用的数据。所以提供了vuex.

# 第一节 初出茅庐，来个demo

这个教程是基于vue-cli的项目做的开发。所以确保vue-cli，vue开发环境是ok的。

### 1. 安装vuex

```
npm install vuex --save
```

因为生产环境要用，所以是--save

### 2. 新建一个store文件夹，并在文件夹下新建index.js，文件中引入vue和vuex

src/store/index.js

```
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
```

这样就算引用成功了，接下来就可以使用了。

## 入门Demo

通过做一个计数器的demo来练习vuex的基本操作，并实现数据共享。

### 1. 在store/index.js中增加一个常量对象。--==state==

store/index.js

```
const state = {
    count: 1
}
```

### 2. 用export default封装代码，让外部可以引用

```
export default new Vuex.Store({
    state
})
```

### 3. 新建一个vue模板，在components文件夹下，Count.vue.在模板中引入刚建的index.js, 并在模板中用{{$store.state.count}}输出count的值

components/Count.vue

```
<template>
  <div>
      <h2>{{msg}}</h2>
      <hr/>
      <h3>{{$store.state.count}}</h3>
      <button @click="$store.commit('add')"> 加分 </button>
      <button @click="$store.commit('reduce')"> 减分 </button>
  </div>
</template>

<script>
    import store from '@/store'
    export default{
        data () {
            return {
                msg: 'Hello Vuex'
            }
        },
        store
    }
</script>
```

### 4. 在store/index.js中加入两个改变state的方法--==mutation==

store/index.js

```
import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const state = {
    count: 1
}
// 新增
const mutations = {
    add (state) {
        state.count ++
    },
    reduce (state) {
        state.count --
    }
}

export default new Vuex.Store({
    state,
    // 新增
    mutations
})

```

这里的mutations是固定的写法，稍后会细讲。只需要知道改变state数值的方法，必须写在mutations里。

### 5. 在Count.vue模板中加入两个按钮，并调用mutations中的方法

```
<button @click="$store.commit('add')"> 加分 </button>
<button @click="$store.commit('reduce')"> 减分 </button>
```

需要在路由中加入count，并可以跳转到count，这里不再赘述。

现在就可以对vuex中的count进行加减了。

# 第二节 state访问状态对象

在第一节已经写了一个const state,这个就是我们说的访问状态对象，它就是我们SPA(单页应用程序)中共享值。

今天学习状态对象赋值给内部对象，也就是把store的值赋值给模板里的data中的值。

==**（读取state的值）**==

## 问题

上一节中，在Count.vue组件中获取vuex的值是通过{{$store.state.count}}这种方式获取的，但这种方式并不优雅。这里用3种方式改写。

有3种赋值方式。

### 1. 通过computed计算属性直接赋值

[computed属性](https://cn.vuejs.org/v2/guide/computed.html#基础例子)可以在属性输出前，对data中的值进行改变，现在就利用这种特性把store.js中的state值赋给模板中的data值

注意： computed的属性是在组件中的，不是在store中。

Count.vue

```
import store from '@/store'
export default{
    data () {
        return {
            msg: 'Hello Vuex'
        }
    },
    computed: {
        count () {
            return this.$store.state.count
        }
    },
    store
}
```

需要注意，一定要写this,

在页面显示的地方替换为count

```
<!-- <h3>{{$store.state.count}}</h3> -->
      <h3>{{count}}</h3>
```

### 2. 通过mapState的对象来赋值

1. 引入mapState

```
    import {mapState} from 'vuex'
```

2. 在computed计算属性里写如下代码

```
computed: mapState({
    count: state => state.count
}),
```

这里我们用ES6的箭头函数来给count赋值。

### 3. 通过mapState的数组来赋值

```
computed: mapState(['count'])
```

下面这种写法是错误的

```
computed: mapState['count'],
```

这个算是最简单的写法，在实际项目开发中也经常这样用。

## 总结

这就是三种赋值方式，虽然简单，但实际项目中经常使用。一定要多练习。

# 第三节 mutations修改状态

mutations修改state的数据

上节学习了怎么读取state，这节学习 ==**如何修改状态**==。这个在第一节课已经碰到过，并进行了加减操作，这节具体学习如何操作mutations。

### $store.commit()

vuex提供了commit方法来修改状态

回顾一下之前修改状态的方法

Count.vue

```
<button @click="$store.commit('add')"> 加分 </button>
<button @click="$store.commit('reduce')"> 减分 </button>
```

store/index.js

```
const mutations = {
    add (state) {
        state.count ++
    },
    reduce (state) {
        state.count --
    }
}
```

### 传值

上面只是一个简单的修改状态操作。实际项目中常常需要在修改状态时传值。比如上边的例子每次只加1，现在要通过所传的值相加。

其实只需要在mutations里再加一个参数，并在commit的时候传递就可以了。如下

store/index.js

```
const mutations = {
    // 新增
    add (state, n) {
        state.count += n
    },
    reduce (state) {
        state.count --
    }
}
```

在Count.vue里修改按钮的commit()方法的参数，传10，即每次加10

```
<button @click="$store.commit('add', 10)"> 加分 </button>
<button @click="$store.commit('reduce')"> 减分 </button>
```

这样传值就可以看到效果了。

### 模板获取mutations方法

实际开发中也不喜欢看到$store.commit()这样的方法出现，希望跟调用组件里的方法一样调用。

例如： @click="reduce", 就和没引用vuex插件一样。

要达到这种写法，只需要简单的两步

1. 在组件Count.vue里用import引入mapMutations

```
    import { mapState, mapMutations } from 'vuex'
```

2. 在组件的script标签里添加methods属性，并加入mapMutations

```
import store from '@/store'
import { mapState, mapMutations } from 'vuex'
export default{
    data () {
        return {
            msg: 'Hello Vuex'
        }
    },
    computed: mapState(['count']),
    // 新增
    methods: mapMutations(['add', 'reduce']),
    store
}
```

3. 在调用的地方改成直接用add和reduce.

```
<button @click="add(10)"> 加分 </button>
<button @click="reduce"> 减分 </button>
```

### 这个是从别的地方看到的,怎么调用

第二种方式：对象风格的传参方式

提交 mutation 的另一种方式是直接使用包含 type 属性的对象：

```
store.commit({
  type: 'increment', // 事件名
  amount: 10
})
```

## 在 Vuex 中，mutation 都是同步函数

# 第四节 getters计算过滤操作

getters从字面上是获得的意思，获取state的数据。

可以把它看作在获取数据之前进行的一种再编辑，相当于对数据的一个加工和过滤。可以看作store的计算属性

Getters 也可以理解为 Vue 中的计算属性 (computed)。

### getters基本用法

现在要对store的count进行一个计算属性的操作，在输出之前，加上100

首先在store/index.js里用const声明getters属性

```
const getters = {
    count: function (state) {
        state.count += 100
        return state.count
    }
}
```

写好getters后，还需要在Vuex.store()里引入，由于之前已经引入state和mutations，所以这里有三个引入属性。如下

```
export default new Vuex.Store({
    state,
    mutations,
    getters
})
```

在store里的配置完成了，需要到组件页对computed进行配置，在vue的构造器里只能有一个computed属性，如果写多个，只有最后一个computed属性可用，所以要对上节课的computed属性进行改造。改造时，使用ES6中的展开运算符'...'

```
computed: {
    ...mapState(['count']),
    count () {
        return this.$store.getters.count
    }
},
```

注意： 写了这个配置后，每次count的值发生变化，都会进行加100操作。

### 用mapGetters简化模板写法

state和mutations都有map的引用方法把我们的模板中的编码进行简化，getters也是，看下代码：

用import引入mapGetters

```
    import { mapState, mapMutations, mapGetters } from 'vuex'
```

在computed属性中加入mapGetters

```
computed: {
    ...mapState(['count']),
    ...mapGetters(['count'])
},
```

## 总结

到这里getters就学完了，还是要熟悉熟悉。
注意mapGetters是写在computed中的。
getter写的是函数，但我们应该把它当成计算属性来用。

# 第5节 actions异步修改状态

actions 和 mutations的功能基本一样，不同点是actions是异步的改变state的状态，而mutations是同步改变状态。

不同模块的 actions 均可以通过 store.dispatch 直接触发。

### 在store里声明actions

actions可以调用mutations里的方法。

继续上节的代码，在actions里调用mutation里的add和reduce方法

```
const actions = {
    addAction (context) {
        context.commit('add', 10)
    },
    reduceAction ({commit}) {
        commit('reduce')
    }
}

// 导出里添加
export default new Vuex.Store({
    state,
    mutations,
    //  新增
    actions,
    getters
})

```

#### 注意这里的传参方式！！！！！ addAction中的10

在actions里写了两个方法addAction和reduceAction，在方法体里都用commit调用了mutations里的方法。这两个方法的传的参数不一样。

- context： 上下文对象，这里可理解为store本身
- {commit}: 直接把commit对象传过来，可以让方法体逻辑和代码更清晰明了

### 模板中的使用

我们需要在Count.vue中调用，让actions生效。

复制之前的两个按钮，调用addAction和reduceAction

```
<button @click="addAction(10)"> 异步加分 </button>
<button @click="reduceAction"> 异步减分 </button>
```

改造methods，用扩展运算符把mapMutations和mapActions引入

```
methods: {
    ...mapActions(['addAction', 'reduceAction']),
    ...mapMutations(['add', 'reduce'])
},
```

### 用dispatch调用action

```
store.dispatch('asyncAdd');

store.dispatch('addAction', {
    n: 10 // 传参
})

store.dispatch({ type: 'addAction', n: 10 });
```

这个是jspang没讲的

### 增加异步校验

现在看到的效果和mutations效果是一样的，怎样区别与mutations里的方法呢，现在演示actions里的异步功能。

这里增加一个计时器延迟执行。

在addAction里使用setTimeout就行延迟执行。
处理逻辑，先加10，隔500毫秒，减一

```
const actions = {
    addAction (context) {
        setTimeout(() => {
            context.commit('reduce')
            console.log('我是异步执行的')
        }, 500)
        context.commit('add', 10)
        console.log('我先执行')
    },
    reduceAction ({commit}) {
        commit('reduce')
    }
}
```

## 总结

mutation和action都可以对store进行操作

mutation必须是同步操作，action可以是任何异步操作。

action不直接更改状态，而是提交mutation

# 第6节 module模块组

随着项目复杂度的增加，共享的状态越来越多，这时候，需要把我们状态的操作进行分组，分组后，再按组编写。

今天学习module: 状态管理器的模块组操作。

每个module拥有自己的state、mutation，action，getter，甚至嵌套子模块。具体结构如下:(来自官网)

```
const moduleA = {
  state: { ... },
  mutations: { ... },
  actions: { ... },
  getters: { ... }
}

const moduleB = {
  state: { ... },
  mutations: { ... },
  actions: { ... }
}

const store = new Vuex.Store({
  modules: {
    a: moduleA,
    b: moduleB
  }
})

store.state.a // -> moduleA 的状态
store.state.b // -> moduleB 的状态
```

### 声明模块组

在store/index.js中，将之前定义好的state,getters，mutations，actions都提取到一个变量中，命名ModuleA。

```
之前导出是将这些都导出的
export default new Vuex.Store({
    state,
    mutations,
    actions,
    getters
})
```

现在都装到moduleA中，导出moduleA

```
const moduleA = {
    state, mutations, getters, actions
}

export default new Vuex.Store({
    modules: {
        a: moduleA
    }
})
```

### 在模板中使用

在计算属性中引入

```
computed: {
    count () {
        return this.$store.state.a.count
    }
},
```

再看效果，和之前是一样的。

这样就算创建了一个module,

### TODO 后续需要将module单独抽离成一个文件

# 总结

可以看到， 一个vuex里包含

* 1. state
    用来定义通用的数据，类似于组件中的data

    mapState是获取state的辅助函数。获取state都是通过computed来获取的，如果获取多个会显得冗余，用mapState辅助函数可以帮助我们生成计算属性。
* 2. getter
    可以认为是store的计算属性，类似于组件中的computed属性，getter 的返回值会根据它的依赖被缓存起来，且只有当它的依赖值发生了改变才会被重新计算。

    mapGetters是getter的辅助函数 将 store 中的 getter 映射到局部计算属性：
* 3. mutation
    更改 Vuex 的 store 中的状态的唯一方法是提交 mutation。

    Mutation 必须是同步函数

> Vuex 中的 mutation 也需要与使用 Vue 一样遵守一些注意事项：

    1. 最好提前在你的 store 中初始化好所有所需属性。

    2. 当需要在对象上添加新属性时，你应该

    使用 Vue.set(obj, 'newProp', 123), 或者

    以新对象替换老对象。例如，利用 stage-3 的对象展开运算符我们可以这样写：

state.obj = { ...state.obj, newProp: 123 }

* 4. action

    类似于mutation
    区别:
    - Action 提交的是 mutation，而不是直接变更状态。
    - Action 可以包含任意异步操作。
* 5. module (这个不一定)
    将一个大的store拆分成一个个子模块，即module

# mutation 只管存，你给我（dispatch）我就存

# action只管中间处理，处理完我就给你，你怎么存我不管

# Getter 我只管取，我不改的

[vuex不错的讲解](https://zhuanlan.zhihu.com/p/24357762)

# Vuex 应用场景

## Vuex应用场景有什么？什么时候适合使用Vuex，什么时候不适合

### 一般回答

1. 涉及到非父子关系的组件，例如兄弟关系、祖孙关系、甚至更远关系。
2. 他们之间有数据交互，应该使用Vuex实现。
3. 如果页面复杂度较低，可以考虑使用global-event-bus 实现
4. 如果只是父子关系的组件数据交互，使用props进行单向传递
5. 涉及到子组件向父组件的数据传递，考虑使用$emit 和 $on

### 更针对性的回答

 <https://www.tuicool.com/articles/EvYJRfv>

在以下场景，我们应当使用Vuex：

#### 1. 组件会被销毁

解决办法

1. 将值存在父组件中，实际是修改的父组件中的值
2. 存在sessionStorage、cookie之类的东西中，在created时读取，destroyed时写入
3. 存到global-event-bus里

4. 存在vuex中
    1. 通过$store.state来调用，通过commit来修改值
    2. 在created时读取state里的值，在destroyed时写入state

优点： 解耦，不跟其他组件打交道

#### 2. 组件基于数据而创建

假设一个场景：

1. 用户将登录后，读取权限配置表，这是个异步操作
2. 这个配置表会影响很多页面。

这些组件不一定是父子关系，其他组件读取权限配置表不太方便

解决办法：

1. 写在global-event-bus里
2. 放在Vuex里

#### 3. 多对多事件 -- 多处触发，影响多处

假设一个场景

1. 切换页面显示风格，改变一个变量的值
2. 在多个地方可以切换
3. 这个变量将影响多个地方的样式
4. 这就是多对多场景

那么：

    1. 无论这个变量放在哪个组件里，其他组件调用都很麻烦
    2. 即使存在于根组件，用this.$root.xx来获取这个变量，也是很麻烦的

解决办法：

1. 用global-event-bus来存储这个变量 ，会比较麻烦
2. 使用Vuex
    1. 通过$store.state.xxx来获取这个变量
    2. 通过$store.commit()来提交修改(在某些条件下可禁止修改)
    3. 可以通过$store.dispatch()获取其他风格样式，并通过$store.state和$store.getters来返回新风格样式

## 总结

    如果需要数据和组件分离，分别处理，那么使用Vuex非常合适。
    相反，如果不需要分离处理，不使用Vuex也没关系。
    比如某个数据只跟某组件交互，是强耦合的，其他组件用不到，那么这个组件就可以防止该组件的data属性中。
