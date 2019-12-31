---
title: TODO.md
date: 2019-01-11 20:22:57
updated: 2019-01-11 20:22:57
tags:
---

## TODO

JS 精度问题

```js
2599.7 * 100

1.1 * 100

0.1 + 0.2 = 0.3？
[从标准原理出发理解 JavaScript 数值精度](https://juejin.im/post/5c3db8b7e51d45515817bdeb)


```

<!-- more -->

[1](https://www.cnblogs.com/xinggood/p/6639022.html)
[math.js]

[解决办法](https://blog.csdn.net/qq_39712029/article/details/81031458)

## 无法实现的需求

## 1. 数字输入框只唤起数字键盘，不能输入汉字

`<input type='number'>`

在有的手机装了搜狗输入法或其他输入法后，唤起键盘输入法可以切换成其他输入法

有的机型没有装其他输入法，唤醒的不是数字键盘

## 2. 数字输入框获取不是数字的值

需求:

- 输入`.`时, 在`.`前加0, 显示`0.`

- 输入两个`..`时，去掉后一个

在input为number类型时，输入 . ，但onchange 取不到 . ，取到的是空字符串

- 相关知识点
`input ime-mode: disabled`
[[CSS]浏览器IME输入法控制禁止输入中文](https://blog.csdn.net/yctccg/article/details/52217988)
[关于表单input type="number"非法值时的一些探究及拓展](https://www.qcyoung.com/2015/09/01/type-number%E9%9D%9E%E6%B3%95%E5%80%BC%E7%9A%84%E4%B8%80%E4%BA%9B%E6%8E%A2%E7%A9%B6%E5%8F%8A%E6%8B%93%E5%B1%95/)
[input type=number驗證問題Script](https://www.itread01.com/p/1000919.html)

React高阶

<https://github.com/dt-fe/weekly/blob/master/12.%E7%B2%BE%E8%AF%BB%20React%20%E9%AB%98%E9%98%B6%E7%BB%84%E4%BB%B6.md>

很好的vue源码解析
<https://juejin.im/post/5abe5822f265da2373149276>

面试大全！！！！
<https://www.tuicool.com/articles/bInqieZ>

腾讯一面
<https://juejin.im/post/5ab8d9e06fb9a028c22ac36c>

浏览器的缓存(1)
<https://segmentfault.com/a/1190000004486640>

前端思维导图
<https://github.com/qiu-deqing/FE-interview/blob/master/javascript%E6%80%9D%E7%BB%B4%E5%AF%BC%E5%9B%BE.md?1520994177199>

排序
<https://juejin.im/post/57dcd394a22b9d00610c5ec8>

  面试链接 还挺好的
<https://github.com/geekape/good-article/issues/2>
React中文官方文档
<https://doc.react-china.org/>

React博客
React构建
<https://segmentfault.com/a/1190000007891318>
<https://taikongfeizhu.github.io/webpack3-in-action/index.html#16>
<https://github.com/hujiulong/blog>

CSS
<http://caibaojian.com/30-seconds-of-css/>
es6常见新特性
<https://segmentfault.com/a/1190000010230939>

<https://segmentfault.com/a/1190000010204791>

闭包
<http://www.cnblogs.com/xxcanghai/p/4991870.html>

let和var的区别
<https://zhuanlan.zhihu.com/p/28140450>

React生命周期
<https://www.cnblogs.com/lijie33402/p/6384080.html>
HTTP协议
<https://zouhangwithsweet.github.io/>

简历制作网站
<http://www.500d.me/>

会动的简历模板
<https://github.com/jirengu-inc/animating-resume>

<https://segmentfault.com/a/1190000010868439>

<https://segmentfault.com/a/1190000010871559>  webpack3

DOM操作成本到底高在哪儿？
<https://segmentfault.com/a/1190000014070240#articleHeader5>

js 内存泄漏分析

<https://www.tuicool.com/articles/ErIR7rE?>

不错的面试题

<https://github.com/WangXiZhu/frontend-interview-question>

大漠的学习笔记

<https://www.w3cplus.com/blogs/airen>

万物皆空之 JavaScript 原型
<https://www.tuicool.com/articles/BN7bi2F>

<https://www.tuicool.com/articles/aEr22ue>

Vue.js最佳实践（五招让你成为Vue.js大师）
<https://segmentfault.com/a/1190000014085613>

<https://segmentfault.com/a/1190000013331105>

<https://github.com/qiu-deqing/FE-interview>

<https://github.com/fouber/blog>

BFC 经典讲解
<https://www.cnblogs.com/lhb25/p/inside-block-formatting-ontext.html>
<https://segmentfault.com/a/1190000013372963>

实践是最好的学习方式
js 最全
<https://github.com/mqyqingfeng/Blog>

爬虫专用网站：<http://books.toscrape.com/>

在服务器放打包好的文件的话，

先了解发起请求的本质：
在一个服务器（注意必须是服务器，有端口可以访问的）中，访问到一个页面

这个页面由 axios 之类的http请求服务接口

在没有配置ProxyTable时，直接请求会有跨域问题存在。

开发环境

但配置proxyTable后，可以解决跨域问题，请求得到服务返回的结果。

配置了proxyTable后，请求的路径 前面的<http://域名端口都可以不用写，直接在proxyTable的target里配置好，在axios里请求的url只需根据需要写后面的路径即可。>

生产环境
在开发环境打包好的文件请求后端接口时是不带http和域名端口的，所以请求的是相对路径。
这个时候在后端起一个服务(比如node),

在这个node服务里发起请求的话，是要写全路径的，否则会找不到地址。

解决办法

在这个node服务中，封装一个axios的方法，在这个方法里写全路径，
这样之前打包好的文件是相对路径，放到这个node服务的目录下，就成了全路径访问服务。

还有一种方法是在打包文件中通过配置写请求路径，然后将请求后端的全路径，打包到生成的文件中。--这个还没试过

Docker说了这么多 最全的一篇在这里

<https://mp.weixin.qq.com/s/r6Zj9Umlc9v_rqplq8207A>

前端书籍

<https://github.com/wxyyxc1992/Web-Development-And-Engineering-Practices>

android，
微信开发
angular.js
springmvc--上硅谷视频
rollup.js
Vue.js
React
ES6
node.js
sql
java
php
linux 命令行
nginx
ansible 自动化运维工具
fetch.js
pm2.js
bluebird.js

面试考察点：

1. 思路是否清晰；
2. 基本语法是否有错；
3. 手写代码的能力
4. 算法

<http://www.materialscss.com/grid>

electron    <https://github.com/electron/electron>   跨平台的GUI软件构建工具

<https://www.html5rocks.com/en/tutorials/file/filesystem/> H5文件接口

Express   <http://www.expressjs.com.cn/>   基于node。js的web框架
lodash <http://lodashjs.com/docs/#_now>   js库

write  a blog

<http://ssh.today/blog/something-about-js-timer>

js 正则表达式
<https://segmentfault.com/a/1190000008812676#articleHeader1>
<https://juejin.im/post/5965943ff265da6c30653879>

js 排序
<https://segmentfault.com/a/1190000008796659>

微信小程序
<https://github.com/lin-xin/wxapp-mall>

前端面试题：
<https://juejin.im/post/59be99a0f265da0644289dde>
前端程序员经常忽视的一个JavaScript面试题

<https://segmentfault.com/p/1210000008946418/read#top>

小菜鸟前端面试大作战
<https://huruji.github.io/FE-Interview/#/>

妨碍进步的因素
<https://juejin.im/post/59bf2a1d51882531b730b718>

异步递归回调
<https://zhuanlan.zhihu.com/p/29534555>
你不知道的 CSS

<https://mp.weixin.qq.com/s/GxtJTIbMbFteCEFnFB7waw>

<https://smohan.net/blog/6gr77h>

css 加载动画效果源码
<http://loading.awesomes.cn/>

使用递归遍历并转换树形数据（以 TypeScript 为例）
<https://segmentfault.com/a/1190000011819279>

React:
一篇包含了react所有基本点的文章

<https://segmentfault.com/a/1190000011205580>
揭秘react全家桶(redux,react-redux,react-router)
<https://github.com/shen1992/blog/issues/2>
Node
饿了么Node.js教程
<https://github.com/ElemeFE/node-interview/tree/master/sections/zh-cn>

<https://github.com/ElemeFE/node-practice>

React 免费教程
<https://react-course.magicfun.ai/>

mac读取移动硬盘
<http://vip.zgyjzf.com/nfm/>

GitHub软件
<https://osxfuse.github.io/>

<http://www.cnblogs.com/macsoft/p/6835753.html>

<http://www.orsoon.com/Mac/150550.html>

<http://wm.makeding.com/redirect/url?segment=axEJmc-ik43ina5LG-TZD5_vApJ8vMxEnzLuVBELJ7z1iJBTC25zxyiSookdjOflPQ-BBKfzOu8S0TT3T6H3sDYVMbITp52pODsN82VD8jrLwXt9uhTQFq_XOsbWm65NgbxaG6R8Mk6-AfLaZNWB9aeCYPbr_mq2VQMeCsKne_U-sXLaxRW9KmP7UG0SKEAwKUWVD2m8pkHSRF5N-2o1i79iLyUwl2pjDCB93P64q753lx_QCO28E9nH_8r7BI0hD9-dXEJp9dEZkU2NL__inFM1LFFdI_6h0GOU3fWoPescmS_HrDNHlvytmT4qrypAaB5Y0_-YzFIcq1TWs79zj-nJwyETD8zaEMC43M1rThHEPYncCvFLvP7F9S140X10&utm_medium=wm&utm_source=http%3A%2F%2Fwww.cnblogs.com%2Fmacsoft%2Fp%2F6835753.html&utm_content=Tuxera+NTFS--&utm_campaign=LM_echo>

js事件绑定问题，
    对接高德导航服务，起点终点确定坐标。
   起点：输入内容，有下拉框，选择了下拉框的就有可确定坐标，没选下拉框，就要搜索，
   终点： 同上
  点击搜索路线。如果起点终点都确定坐标，直接搜索路线，
                            不确定起点终点，则先搜索结果。
    怎么判定这两个状态？
     我的思路，在下拉框中选择一个结果，则给输入框赋一个坐标的属性，
                        点击搜索路线，判断输入框是否有坐标属性，有直接搜路线，没有，查询结果。
                       onchange或onkeyup清除坐标属性

node 作为中间件搭建前段代理，中转请求到后端。
<https://segmentfault.com/a/1190000007992200>

1. git book中文教程
<https://chenyitian.gitbooks.io/react-docs>
2.官网

3. 不错的教程
<http://www.runoob.com/w3cnote/getting-started-with-react.html>
4. 极客学院教程
<http://wiki.jikexueyuan.com/project/react-tutorial/>
5. React启蒙（译）
<https://www.gitbook.com/book/zhangwang1990/reactenlightenment/details>
React中国
<https://tianxiangbing.github.io/react-cn/index.html>
React 入门教程
<https://hulufei.gitbooks.io/react-tutorial/content/component.html>

完美使用 React, Redux, and React-Router！最好用的脚手架
<https://github.com/bodyno/react-starter-kit>

react 中文网
<http://www.react-cn.com/>
<https://segmentfault.com/blog/jasonnote>

<https://github.com/theJian/build-a-hn-front-page>
React技术栈+Express+Mongodb实现个人博客
<https://github.com/Nealyang/React-Express-Blog-Demo>

Vue
router文档：
<http://router.vuejs.org/zh-cn/>

demo示例：
<https://github.com/cwsjoker/webpack-vue-spa-demo/tree/master>

中文文档；
<https://vuefe.cn/v2/guide/>

vue学习教程
<http://www.cnblogs.com/keepfool/p/5619070.html>

vue  vue-material框架
<https://vuematerial.github.io>

很全的vue资料 赞赞赞~~~~~~~~~~~~~
<https://github.com/opendigg/awesome-github-vue>

<https://github.com/vuejs/awesome-vue>

简单的后台管理系统
<https://github.com/monster1935/vue-element>

很棒的后台管理系统
<http://panjiachen.github.io/vue-element-admin/#/introduction/index>

这个也不错
<https://github.com/vue-bulma/vue-admin>

Vue项目中引用知乎API获取图片报403解决方案

1. 在html设置meta

<meta name="referrer" content="never">
链接
http://www.cnblogs.com/dongcanliang/archive/2017/04/01/6655061.html

2. 通过获取img src，用iframe去请求
链接：
<https://segmentfault.com/q/1010000002581983/a-1020000002592757>

<https://www.xiabingbao.com/vue/2017/07/10/vue-curd.html>

<https://www.xiabingbao.com>

Vue 组件编写
<https://segmentfault.com/a/1190000011796898>
React
React 服务端渲染如此轻松 从零开始构建前后端应用
<https://segmentfault.com/a/1190000010260036>

Vue2.0—仿知乎日报总结

<https://segmentfault.com/a/1190000009305496>

VUE-WAS：一个基于Vue的Web App收集向项目

<https://segmentfault.com/a/1190000010330905>

 Vue 与 iOS 的组件化.md
<https://github.com/halfrost/Halfrost-Field/blob/master/contents/Vue/%E5%A4%A7%E8%AF%9D%E5%A4%A7%E5%89%8D%E7%AB%AF%E6%97%B6%E4%BB%A3(%E4%B8%80)%20%E2%80%94%E2%80%94%20Vue%20%E4%B8%8E%20iOS%20%E7%9A%84%E7%BB%84%E4%BB%B6%E5%8C%96.md>

好的js博客
<https://zhuanlan.zhihu.com/dreawer?author=qiangdada520>

天猫前端
<http://tmallfe.github.io/>

js 核心概念
<https://mp.weixin.qq.com/s/I7A1iC8Et6uOGZ234DsTlA>

Vue mock
<http://www.jianshu.com/p/284590b5b717>
<https://github.com/yanm1ng/vue-starter-kit>

很好的面试题
<https://zhoukekestar.github.io/notes/2017/06/07/interview-answers.html>

vue 很好的后台管理系统
<https://github.com/PanJiaChen/vue-element-admin>
<https://github.com/PanJiaChen/vueAdmin-template>

Vue源码解析~~非常棒
<https://zhuanlan.zhihu.com/p/25869382>

<https://zhuanlan.zhihu.com/p/28835709>  高阶函数

easy-mock
<https://easy-mock.com/>    believezjp zhao110120

前端每周盘点半年清单系列

<https://segmentfault.com/a/1190000010769946>

<https://segmentfault.com/a/1190000010716195>

MVVM实现原理。
<https://segmentfault.com/a/1190000010744960>

React 学习教程
<https://segmentfault.com/a/1190000005136764>

Vue 脱坑记 - 查漏补缺(汇总下群里高频询问的xxx及给出不靠谱的解决方案)
<https://juejin.im/post/59fa9257f265da43062a1b0e>

使用vscode 自动修复eslint的格式错误(空格多少，tab之类的)
vscode左下角，设置配置如下：
"eslint.validate": [
        "javascript",
        "javascriptreact",
        {
            "language": "vu             e",
            "autoFix": true
        }
    ]

把vue文件设为true,
想修复的时候，在vscode用ctrl+shift+p打开命令行，输入Fix  all  auto-fixable problems
即可自动修复所有的格式错误

<http://www.gbtags.com/>

所有软件的书籍：

<https://github.com/vhf/free-programming-books/blob/master/free-programming-books-zh.md>

react 教程：
<https://fakefish.github.io/react-webpack-cookbook/>

FLEX
照着改造自己的flex 页面。
<https://zhuanlan.zhihu.com/p/25303493>

<http://www.fgm.cc/learn/>  各种实例
各种视频课程 <http://www.stuq.org/>

<http://www.chengxuyuans.com/web_technology/ajax-jsonp.html> jsonp的讲解
<http://kb.cnblogs.com/page/159704/web前端开发十日谈>
<http://www.cnblogs.com/dowinning/archive/2012/04/19/json-jsonp-jquery.html>

<https://github.com/FreeCodeCamp/FreeCodeCamp/blob/staging/CONTRIBUTING.md>

线下课 <<前端工程师与测试工程师>>
<http://www.tudou.com/programs/view/NRpKuBbeZEg>
密码 ydxt2016

<<EcmaScript6编程风格上>>
链接: <http://pan.baidu.com/s/1c1TfnUC> 密码: 945t

<<第一周考题>>你可以测验一下自己的水平。
<http://pan.baidu.com/s/1gf7BsUf> 密码ceuh
讲解 <http://www.tudou.com/programs/view/epsKmGW-Nwg/>
密码YDXTpass2016

Vue.js资源分享
<https://github.com/maidishike/FrontEnd-Wikis/blob/master/vuejs.md>

JavaScript 全栈工程师培训教程
<http://www.ruanyifeng.com/blog/2016/11/javascript.html>

简书很棒的文章：
<http://www.jianshu.com/p/cc1cb9a5650c>

<http://blog.phpfamily.org>

<http://ued.party/#序为什么前端没有前途>

<https://www.shiyanlou.com/paths/web实验楼>

JavaScript设计模式之结构型设计模式
<https://segmentfault.com/a/1190000012585364>

JavaScript数据类型的存储
<http://axuebin.com/blog/2017/08/24/javascript-data-storage/>

jQuery 对应原生js怎么写~~~
<http://youmightnotneedjquery.com/>

<https://github.com/oneuijs/You-Dont-Need-jQuery/blob/master/README.zh-CN.md>

JavaScript深入教程--必学！！
<https://github.com/mqyqingfeng/Blog>

# js专题

    https://segmentfault.com/blog/yayu-blog?tag=javascript%E4%B8%93%E9%A2%98%E7%B3%BB%E5%88%97

vitual-dom原理与简单实现

<https://segmentfault.com/a/1190000012230659#articleHeader2>

【JavaScript从入门到精通】
<http://www.igeekbar.com/igeekbar/mypost/113.htm>

前端PDF下载
<http://www.menvscode.com/list/ziyuan/webpdf/1>

javascript组件化
<http://caibaojian.com/javascript-module-2.html>

## [从 for of 聊到 Generator](https://juejin.im/post/5c40484bf265da61171cfb4d)

## [深入理解 TypeScript](https://jkchao.github.io/typescript-book-chinese/project/modules.html)

## [MDN javascript中高级教程](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript)

## 「中高级前端」高性能渲染十万条数据

[「中高级前端」高性能渲染十万条数据](https://juejin.im/post/5d76f469f265da039a28aff7)

## 校园编程和职场编程的区别

学校的程序解决的设计问题很少是险恶的，基本能从头到尾直线前进而设计。
基本完成作业就可以，很少会对程序改动。

而专业编程中代码的修改是每日可见的真实情景。

## 读代码大全2笔记

软件开发的隐喻，到底什么词合适

先想到的是庖丁解牛，不过是相反的过程，缺少任何一个骨头肌肉都不能完整拼成。

但播种耕种更形象，播种直到丰收，每个细节都不能马虎，最终才能有秋后的果实。

大型的房屋建筑需要超出常规的规划和建设

组合各种隐喻

### 软件开发金字塔

1. 问题定义
   只定义问题是什么，不涉及任何可能的解决方案。
2. 需求
   需求像水，冻结了才能在上面开展建设。

管理复杂度的重要性

作为软件开发人员，不应该试着在同一时间把整个程序都塞进自己的大脑，而应该试着以某种方式去组织程序，以便能够在一个时刻可以专注于一个特定的部分。
这么做的目的是尽量减少在任意时间索要考虑的程序量。

在软件架构层次上，可以通过把整个系统分解为多个子系统来降低问题的复杂度。
2019-11-29 16:49:41 97页

代码整洁之道读完

[event loop](https://github.com/koala-coding/goodBlog/blob/master/docs/node/eventLoop.md)
