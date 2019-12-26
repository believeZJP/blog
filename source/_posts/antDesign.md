---
title: antDesign
date: 2018-11-07 19:33:28
updated: 2018-11-07 19:33:28
tags:
- React
- antDesign
---

## 记录踩过的坑

数组必须要key的解决办法

由于有些数据没有唯一key值。需要自行添加

```js
var localCounter = 1;
this.data.forEach(el=>{
    el.id = localCounter++;
});


//向数组中动态添加元素时，
function createUser(user) {
    return {
        ...user,
        id: localCounter++
    }
}
```

## 动态路由，传参获取参数

定义路由

```js
'/coupons/relateProducts/:couponBatchId': {
    component: dynamicWrapper(app, ['coupons'], () => import('../routes/Coupons/RelateProducts'))
},
```

在组件中获取

```js
this.props.match.params.couponBatchId
```

## 路由跳转

## 多级对象setState

可以单独取出来，修改后再整体放进去

## 一个组件是modal，打开就查询一次，在哪执行查询

在componentWillReceiveProps里

```js
componentWillReceiveProps(nextProps){
    // 这里的nextProps为修改后的状态值

    用this.props可以获取到修改之前的props

    通过this.props和nextProps两者对比可以看是否需要更新和操作
}
```

componentwillreceiveprops会自动接收参数，导致页面不断渲染
需要配合this.props使用
componentDidMount不会触发

lodash.has

## select 用setFieldsValue赋值，类型要一样，数字就是数字，字符串就是字符串，才能正常显示

## form表单重置按钮

```js
handleReset = () => {
    this.props.form.resetFields();
}
```

## Select 组件使用

Select 赋值，用this.props.form.setFieldsValues();

select动态赋值给select。，只显示value，没显示label，显示label无法提交
类型要匹配，数字就是数字，字符串就是字符串

## a元素绑定事件

给a绑定事件，一定要这样绑

```js
 <a onClick={e => this.showDetail(record.key)}>详情</a>
handleMouseOver = (key) => (e) => {
    this.setState({ display: key })
}
```

写了models一定要在common的router.js中getRouterData
的dynamicWrapper
中引入文件夹名字，才能自动引入到app._models中

service 中的api要添加request.

models中要添加reducer，

在页面中要用redux定义好的state，需要在connect中引入
@connect(({loading, coupons}) => ({
    data: coupons,
}))

action调用成功后，在reducer里改了状态， 打印出来发生变化了，但页面没变化。

在div中写的可以变化，在input或textarea中不会发生变化。

加了mapPropsToFields后，修改的值回响应到textarea上，

但所有输入框输入的值被清空了

不想用redux，直接用组件里的state，怎么搞？

在dispatch后添加callback.直接用

this.props.form.setFieldsValue({
    uids: payload.data.join()
});

 一个页面多个form，点击每个form的提交，其他form的字段会跟着提交

Form的FormItem如果是rangePicker，则设置style={{width:100%}}，可以让输入框响应容器

Form的label和input输入框的宽度通过调节labelCol，wrapperCol
来设置，总长度为24

啊啊啊啊大经验啊！！！！

nginx的proxy配置一定要前后路径一致
    'POST /coupon/v1/(.*)': '<http://10.64.38.89:8081/coupon/v1/',>

前面是coupon/v1后面也一定是coupon/v1,
不能前面是coupon 后面是coupon/v1
项目一定要放在www目录下
