---
title: CSS 知识点
date: 2018-11-29 20:36:21
updated: 2018-11-29 20:36:21
tags:
- CSS
- CSS3
- 理论知识
- 前端
---

参考链接
- [写好CSS代码的70个专业建议](http://caibaojian.com/70-expert-ideas-for-better-css-coding.html)

# 项目统一样式

为了解决浏览器默认样式不统一的问题。

一般有两个库
- [Normalize.css](http://necolas.github.io/normalize.css/)
- [Reset CSS](https://meyerweb.com/eric/tools/css/reset/)

还可以根据自己需求定制初始化样式.

好处：
- **保护有用的浏览器默认样式**而不是完全去掉它们
- **一般化的样式**：为大部分HTML元素提供
- **修复浏览器自身的bug**并保证各浏览器的一致性
- **优化CSS可用性**：用一些小技巧
- **解释代码**：用注释和详细的文档来

<!--more-->

# 页面首次加载动画展示
- [WOW中文文档](https://github.com/matthieua/WOW)

- 进入和离开屏幕时动画[scrollreveal]( https://github.com/jlmakes/scrollreveal.js)

- [Animate.css](https://daneden.github.io/animate.css/)


# 常见布局方案整理

- [CSS布局方案](https://segmentfault.com/a/1190000010989110)
- [经典布局](https://juejin.im/entry/591dc015da2f60005d25e6b0)
- [使用 flex 实现 5 种常用布局](https://segmentfault.com/a/1190000012275086)
- [flex布局详解](http://caibaojian.com/flexbox-guide.html)

- [css负margin运用](http://www.admin10000.com/document/9351.html)


# CSS3实现动画功能主要通过两个属性
1.transition
2.animation

transition:<过渡属性名称> <过渡时间>
```css
transition: color 1s;
transition: height 3s;
transition-property: color; 
transition-duration: 1s;
```
多个属性的过渡效果
`-webkit-transition:<属性1> <时间1>,<属性2> <时间2>,<属性3> <时间3>;`

第三个属性值：
transition:<过渡属性名称> <过渡时间> <过渡模式>   
transition-timing-function
值:  ease   缓慢开始，缓慢结束
    liner        匀速
    ease-in    缓慢开始
    ease-out    缓慢结束
    ease-in-out    缓慢开始，缓慢结束（和ease稍有区别）

# CSS3创建3D场景

1. 属性介绍
perspective:800    平面距离三维中方框的距离
perspective-origin:50% 50%

2. transform属性
--translete :位移操作
translateX(X px)
translateY(Y px)
translateZ(Z px)

--rotate：旋转操作
rotateX(X deg)
rotateY(Y deg)
rotateZ(Z deg)

3. 设置3D
transform-style:preserve-3d;

# 如何通过css使div 实现全屏效果
--全屏要素：
    1.全屏的元素及其父元素都要设置为height:100%,
    2.将html,body标签设置为height100%,
注：height:100%是跟随其父元素高度变化而变化的

# css中 link 和 @import 区别

@import 指令 会阻止浏览并行下载。
link 加载外部样式表不会阻止并行下载。

# px,  em,  rem的区别

- PX特点
1. IE无法调整那些使用px作为单位的字体大小;
2. 国外的大部分网站能够调整的原因在于其使用了em或rem作为字体单位;
3. Firefox能够调整px和em，rem，但是96%以上的中国网民使用IE浏览器(或内核)。
px像素(Pixel)。相对长度单位。像素px是相对于显示器屏幕分辨率而言的。(引自CSS2.0手册)
em是相对长度单位。
相对于当前对象内文本的字体尺寸。如当前对行内文本的字体尺寸未被人为设置，则相对于浏览器的默认字体尺寸。(引自CSS2.0手册)
任意浏览器的默认字体高都是16px。所有未经调整的浏览器都符合: 1em=16px。那么12px=0.75em,10px=0.625em。为了简化font-size的换算，需要在css中的body选择器中声明Font-size=62.5%，这就使em值变为 16px*62.5%=10px, 这样12px=1.2em, 10px=1em, 也就是说只需要将你的原来的px数值除以10，然后换上em作为单位就行了。
- EM特点
1. em的值并不是固定的;
2. em会继承父级元素的字体大小。
所以我们在写CSS的时候，需要注意两点：
1. body选择器中声明Font-size=62.5%;
2. 将你的原来的px数值除以10，然后换上em作为单位;
3. 重新计算那些被放大的字体的em数值。避免字体大小的重复声明。
也就是避免1.2 * 1.2= 1.44的现象。比如说你在#content中声明了字体大小为1.2em，那么在声明p的字体大小时就只能是1em，而不是1.2em, 因为此em非彼em，它因继承#content的字体高而变为了1em=12px。

- rem特点		
rem是CSS3新增的一个相对单位(root em，根em)，这个单位引起了广泛关注。这个单位与em有什么区别呢?区别在于使用rem为元素设定字体大小时，仍然是相对大小，但相对的只是HTML根元素。这个单位可谓集相对大小和绝对大小的优点于一身，通过它既可以做到只修改根元素就成比例地调整所有字体大小，又可以避免字体大小逐层复合的连锁反应。
一个例子：
p {font-size:14px; font-size:.875rem;}

# CSS3 动画性能问题
https://www.cnblogs.com/shytong/p/5419565.html
a、是否导致layout
如果是，尽可能将动画元素absolute或者fixed化以避免影响文档树，以减少重排.
b、是否启用硬件加速
“用到了CSS3动画”和“开启了硬件加速”是两件事情，虽然前者有可能导致后者。
开启硬件加速在webkit中有神奇的万金油：opacity: 1;或者-webkit-backface-visibility: hidden;。
c、是否是有高消耗的属性（css shadow、gradients、background-attachment: fixed等）
有的话，图片也是一种选择。这算得上是用空间换时间的优化了。
d、repaint的面积
如果是，只好缩小动画面积了。这一步的优化有限;
e、尽量使用 transform 生成动画，避免使用 height,width,margin,padding 等；
transform 动画由GPU控制，支持硬件加速，并不需要软件方面的渲染
为动画DOM元素添加 CSS3 样式
 -webkit-transform:transition3d(0,0,0) 或 -webkit-transform:translateZ(0); ，
这两个属性都会开启 GPU硬件加速 模式，从而让浏览器在渲染动画时从CPU转向GPU，

# 字体加粗用哪个

`<b></b>`标签的加粗只是为了加粗
`<strong></strong>`标签加粗是为了突出重点
在网页中使用`<strong></strong>`突出的内容更容易被网页搜索蜘蛛搜索到。
盲人朋友使用阅读设备阅读网络时：`<strong>`会重读，`<b>`不会

# CSS优先级算法如何计算

- 元素选择符： 1
- class选择符： 10
- id选择符：100
- 元素标签：1000
- !important声明的样式优先级最高，如果冲突再进行计算。

如果优先级相同，则选择最后出现的样式。
继承得到的样式的优先级最低。

# box-sizing属性
用来控制元素的盒子模型的解析模式，默认为content-box
context-box：W3C的标准盒子模型，设置元素的 height/width 属性指的是content部分的高/宽
border-box：IE传统盒子模型。设置元素的height/width属性指的是border + padding + content部分的高/宽
inherit:   应从父元素继承 box-sizing 属性的值

# 介绍一下标准的CSS的盒子模型？与低版本IE的盒子模型有什么不同的？
标准盒子模型：宽度=内容的宽度（content）+ border + padding + margin
低版本IE盒子模型：宽度=内容宽度（content+border+padding）+ margin


