---
title: axios积累
date: 2018-11-22 20:27:01
updated: 2018-11-22 20:27:01
tags:
---

## 使用axios在url后统一加参数遇到的问题

如果是get请求，直接加在url后面

`https://www.baidu.com?a=1&b=2`

如果要get, post, put都加呢？

```javascript
const data = {
    ...params,
    a: 1,
    b: 2
}
axios.get(url, {
    params: data,
})
axios.post(url, {
    params: data,
})
axios.put(url, {
    params: data,
})

```

**注意:** 如果在url和post的data中都加同样参数的话，有的后端服务会报错，无法正常解析。

axios在data中添加参数后，会根据get，post不同请求方法，选择不同的参数拼接方式.

>get: 加到url后，
>post, put加到post的data中。

综上: 添加url参数可以根据具体需求选择直接加在url后还是加到data中。
