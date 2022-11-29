---
title: React中API使用的正确姿势
date: 2020-08-20 16:18:50
updated: 2020-08-20 16:18:50
tags:
---
## 惰性初始化state

defaultValue 参数只会在组件的初始渲染中起作⽤，后续渲染时会被忽略。如果初始 state 需要通过复杂计算获
得，则可以传⼊⼀个函数，在函数中计算并返回初始的 state，此函数只在初始渲染时被调⽤：

**这种写法可以避免定义多个state时，每次渲染都要执行初始化操作，而用惰性初始化state，可以解决重复初始化的问题。**

```js

// 每次setInputValue引起的重新渲染进⼊函数组件内defaultValue都会被忽略。
const TestInput= (props) => {
    const defaultValue = props.value || '请输⼊'
    const [inputValue,setInputValue] = useState(defaultValue)
    return (
        <div>
            <input value={inputValue} onChange={(e)=>setInputValue(e.target.value)} /> {in
        </div>
    )
}
export default TestInput

//使⽤函数来解决每次渲染 state 需要通过复杂计算获得的问题
const TestInput= (props) => {
    const [inputValue,setInputValue] = useState(()=>{
        return props.value || '请输⼊'
    })
    return (
        <div>
            <input value={inputValue} onChange={(e)=>setInputValue(e.target.value)} /> {in
        </div>
    )
}
export default TestInput
```

## 一个项目配置多个basename

需求是域名后面可以加`/iot`或`/spp`，不能跳转，浏览器的链接不能变。

`<BrowserRouter basename={base}>` 这里的base可以根据不同情况设置不同值
