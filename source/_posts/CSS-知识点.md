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

## 项目统一样式

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

用`overflow: auto` 必须给容器指定高度`height: 固定值`

## 页面首次加载动画展示

- [WOW中文文档](https://github.com/matthieua/WOW)

- 进入和离开屏幕时动画[scrollreveal]( https://github.com/jlmakes/scrollreveal.js)

- [Animate.css](https://daneden.github.io/animate.css/)

## 常见布局方案整理

- [CSS布局方案](https://segmentfault.com/a/1190000010989110)
- [经典布局](https://juejin.im/entry/591dc015da2f60005d25e6b0)
- [使用 flex 实现 5 种常用布局](https://segmentfault.com/a/1190000012275086)
- [flex布局详解](http://caibaojian.com/flexbox-guide.html)

- [css负margin运用](http://www.admin10000.com/document/9351.html)

## CSS3实现动画功能主要通过两个属性

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

## CSS3创建3D场景

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

## 如何通过css使div 实现全屏效果

--全屏要素：
    1.全屏的元素及其父元素都要设置为height:100%,
    2.将html,body标签设置为height100%,
注：height:100%是跟随其父元素高度变化而变化的

## css中 link 和 @import 区别

@import 指令 会阻止浏览并行下载。
link 加载外部样式表不会阻止并行下载。

## px,em,rem的区别

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

## CSS3 动画性能问题

<https://www.cnblogs.com/shytong/p/5419565.html>
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

## 字体加粗用哪个

`<b></b>`标签的加粗只是为了加粗
`<strong></strong>`标签加粗是为了突出重点
在网页中使用`<strong></strong>`突出的内容更容易被网页搜索蜘蛛搜索到。
盲人朋友使用阅读设备阅读网络时：`<strong>`会重读，`<b>`不会

## CSS优先级算法如何计算

- 元素选择符： 1
- class选择符： 10
- id选择符：100
- 元素标签：1000
- !important声明的样式优先级最高，如果冲突再进行计算。

如果优先级相同，则选择最后出现的样式。
继承得到的样式的优先级最低。

## box-sizing属性

用来控制元素的盒子模型的解析模式，默认为content-box
context-box：W3C的标准盒子模型，设置元素的 height/width 属性指的是content部分的高/宽
border-box：IE传统盒子模型。设置元素的height/width属性指的是border + padding + content部分的高/宽
inherit:   应从父元素继承 box-sizing 属性的值

## 介绍一下标准的CSS的盒子模型？与低版本IE的盒子模型有什么不同的

标准盒子模型：宽度=内容的宽度（content）+ border + padding + margin
低版本IE盒子模型：宽度=内容宽度（content+border+padding）+ margin

## nth-child与nth-of-type区别

```css
.product-list .item:nth-child(2n) {
    margin-left: 6px;
}
.product-list .item:nth-child(2n+1) {
    margin-right: 6px;
}
.product-list .item:nth-of-type(2n) {
    margin-left: 6px;
}
.product-list .item:nth-of-type(2n+1) {
    margin-right: 6px;
}
```

> :nth-child(n) 选择器匹配属于其父元素的第 N 个子元素，**不论元素的类型**。
> :nth-of-type(n) 选择器匹配属于父元素的特定类型的第 N 个子元素的每个元素.

## justify-content设置居左

CSS语法:
`justify-content: flex-start|flex-end|center|space-between|space-around|initial|inherit;`

默认值为flex-start, 如果要居左可以设置这个值，
> 注意：设置left不生效，因为没有left这个值。

## css换行

```css
word-break: break-all;
word-break: break-word;
```

## max-width 和 !important

max-width在比width小时，即使width使用!important来加权，仍会max-width生效；

以下代码宽度为300px

```html
<img src="1.jpg" style="width:480px!important; max-width: 300px">
<img src="1.jpg" style="width:480px!important; transform: scale(0.625, 1);" >
```

overflow 基本属性：
    visible （默认）
    hidden  超出的部分被隐藏
    scroll  两边都会出现
    auto  智能路线
    inherit(IE8+才支持)

兼容性：
    1.燕环肥瘦，各有春秋
    2.宽度设定机制
ie7中莫名出现滚动条，可能是设置了100%，做法是删除width:100%;  

作用的前提
1.非display:inline 水平~     display不能设置为inline
2.对应方位的尺寸限制。width/height/max-width/max-height/absolute拉伸
3.对于单元格td等，还需要设置table为table-layout:fixed;

overflow:visible妙用
    ie7下文字越多，按钮两侧padding留白就越大
给所有按钮添加css样式   overflow:visible

滚动条出现的条件
    1.overflow:auto,overflow:scroll   ---自带html，textarea
    2.草窝藏不住凤凰，潜水困不住蛟龙    内容过多

body/html 与滚动条

无论什么浏览器，默认滚动条均来自`<html>`，而不是`<body>`

ie7- html{overflow-y:scroll;}
ie8+  html{overflow:auto;}

想要去掉页面默认的滚动条
        html {overflow:hidden;}
html,body{overflow:hidden;} ------×

js与滚动高度
    chrome document.body.scrollTop
    其他：document.documentElement.scrollTop
标准写法：
    var st = document.body.scrollTop || document.documentElement.scrollTop;

overflow的padding-bottom缺失现象
    导致不一样的scrollHeight (元素内容高度)
滚动条的宽度机制
    滚动条会占用容器的可用高度或高度  宽度均为17px

1.怪异模式问题：漏写DTD声明，Firefox仍然会按照标准模式来解析网页，但在IE中会触发怪异模式。为避免怪异模式给我们带来不必要的麻烦，最好养成书写DTD声明的好习惯。
2.IE6双边距问题：在IE6下，如果对元素设置了浮动，同时又设置了margin-left或margin-right，margin值会加倍。例如：
HTML：

```html
< span>div class="myDiv"<div<
```

CSS：

.myDiv{
    width:100px;
    height:100px;
    border:1px solid #000;
    float:left;
    margin-left:30px;
}

IE6预览结果：
很明显的，在IE6中，margin-left:30px的边距翻倍成60px了。
解决问题：
设置display:inline：

.myDiv{
    width:100px;
    height:100px;
    border:1px solid #000;
    float:left;
    display:inline;
    margin-left:30px;
}

IE6预览结果：
3.上下margin重合：margin是个有点特殊的样式，相邻的margin-left和margin-right是不会重合的，但相邻的margin-top和margin-bottom会产生重合。不管IE还是Firefox都存在这问题。例如：
HTML：

```html
< span>div class="topDiv"<div<
< span>div class="bottomDiv"<div<
```

CSS：

.topDiv{
    width:100px;
    height:100px;
    border:1px solid #000;
    margin-bottom:25px;
}
.bottomDiv{
    width:100px;
    height:100px;
    border:1px solid #000;
    margin-top:50px;
}

我们对上面的div设置了25px的下边距，对下方的div设置了50px的上边距。为了便于观察，这里将div的高度都设为100px。
浏览器预览结果：
可见，结果不是预期的上下div拉开75px的距离，而是拉开了半个div高度(50px)的距离。
解决问题：
统一使用margin-top或者margin-bottom，不要混合使用。这并不是技术上的必需，但却是个良好的习惯。
4.超链接访问后hover样式不出现：有时候我们同时设置了a:visited和a:hover样式，但一旦超链接访问后，hover的样式就不再出现，这是怎么回事呢？是因为将样式顺序放错了，调整为先a:visited再a:hover。关于a标签的四种状态的排序问题，有个简单好记的原则，叫做love hate原则，即i(link)ov(visited)e h(hover)a(active)e。
5.IE6、IE7的hasLayout问题：很多时候，CSS在IE下的解析十分奇怪，明明在Firefox中显示得非常正确，但到了IE下却出现了问题，有的时候，这些问题甚至表现得非常诡异。
例如一个比较经典的Bug就是设置border的时候，有时候border会断开，刷新页面或者拖下滚动条的时候，断掉的部分又会连接起来。
再比如在IE6&IE7中对元素设置浮动后，其后的元素并未占据这部分空间，造成了IE6&IE7中浮动元素未脱离文档流的假象。也就是说，实际上IE6&IE7浮动元素也脱离了文档流，只是由于其后元素的hasLayout被自动触发而导致的。这里说的hasLayout被触发，即指元素的hasLayout属性为true。
下列元素默认hasLayout="true"：
下列 CSS 属性和取值将会自动让一个元素的hasLayout="true"：
position: absolute
绝对定位元素的包含区块(containing block)就会经常在这一方面出问题。
float: left|right
由于 layout 元素的特性，浮动模型会有很多怪异的表现。
display: inline-block
当一个内联级别的元素需要 layout 的时候往往就要用到它，这也可能也是这个 CSS 属性的唯一效果–让某个元素拥有 layout。"inline-block行为"在IE中是可以实现的，但是需要注意的是： IE/Win: inline-block and hasLayout 。
width: 除 “auto" 外的任意值
很多人遇到 layout 相关问题发生时，一般都会先尝试用这个来修复。
height: 除 “auto" 外的任意值
height: 1% 就在 Holly Hack 中用到。
zoom: 除 “normal" 外的任意值
IE专有属性。不过 zoom: 1 可以临时用做调试。
writing-mode: tb-rl
MS专有属性。
overflow: hidden|scroll|auto
在 IE7 中，overflow 也变成了一个 layout 触发器，这个属性在之前版本 IE 中没有触发 layout 的功能。
overflow-x|-y: hidden|scroll|auto
overflow-x 和 overflow-y 是 CSS3 盒模型中的属性，尚未得到浏览器的广泛支持。他们在之前版本IE中没有触发 layout 的功能。
另外 IE7 的荧幕上又新添了几个 haslayout 的演员，如果只从 hasLayout 这个方面考虑，min/max 和 width/height 的表现类似，position 的 fixed 和 absolute 也是一模一样。
position: fixed
min-width: 任意值
就算设为0也可以让该元素获得 layout。
max-width: 除 “none" 之外的任意值
min-height: 任意值。即使设为0也可以让该元素的 haslayout=true
max-height: 除 “none" 之外的任意值
如果BUG是由于hasLayout未触发所引起的，则可采用手动触发hasLayout来解决：办法是使用一个生僻的CSS属性zoom来触发，引用样式.zoom{zoom:1}。
如果BUG是hasLayout被自动触发而引起的，则要看触发是什么引起的，若这元素本身就会自动触发hasLayout，可以考虑换一个元素。若是对于这元素设置的某个CSS属性引起的，则可以考虑删除这属性，倘若这属性又是必要的，则就需要自己根据具体情况去编写CSS Hack，因为hasLayout是只读的，一旦hasLayout="true"后，便不可逆转。
6.行内元素上下margin及padding不拉开元素间距的问题：行内元素的margin和padding属性很奇怪，水平方向的padding-left、padding-right、margin-left、margin-right都产生边距效果，但竖直方向的padding-top、padding-bottom、margin-top、margin-bottom却不会产生边距效果。例如：
HTML：

CSS:
div{background:gray;padding:20px;}
span{background:green;padding:20px;margin:20px;}
各浏览器预览结果：
可见竖直方向的padding、margin虽然增大了行内元素的面积，但并没有和相邻元素拉开距离，导致了元素重叠。
解决问题：
将行内元素display设置为block即可解决
修改后CSS：
span{background:green;padding:20px;margin:20px;display:block;}
各浏览器预览结果：
但由于块级元素与行内元素的默认样式不同，可能会因此书写额外的样式代码。比如width样式，因为块级元素默认占据整行。
7.IE6下select元素显示问题：浏览器解析页面时，会先判断元素的类型，如果是窗口类型的，会优先于非窗口类型的元素，显示在页面最顶端，如果同属于非窗口类型的，才会去判断z-index的大小。select元素在IE6下是以窗口形式显示的，这是IE6的一个Bug。导致的情况是往往想要弹出一个层，结果select元素出现在层上方。例如：
HTML：

CSS：

```css
div{
    position:absolute;
    background:#CCDCEE;
    top:0px;
    left:0px;
    width:300px;
    height:300px;
    border:1px solid #000;
    margin:5px;
}
```

IE6预览结果：
解决问题：
我们可以用一个和弹出层同样大小的iframe放在层下面，select上面，用iframe遮住select。比如设置弹出层的样式z-index:2，iframe的样式z-index:1，使iframe位于层下方。
修改后HTML：

修改后CSS：

div{
    position:absolute;
    background:#CCDCEE;
    top:0px;
    left:0px;
    width:300px;
    height:300px;
    border:1px solid #000;
    margin:5px;
    z-index:2;
}
iframe{
    position:absolute;
    top:0px;
    left:0px;
    width:300px;
    height:300px;
    margin:5px;
    z-index:1;
}

我们让iframe位于div下方，大小以及与浏览器的距离调整成与div一致。
IE6预览结果：
8.IE6对png的透明度支持问题：png格式因为其优秀的压缩算法和对透明度的完美支持，成为Web中最流行的图片格式之一。但它存在一个众所周知的头疼问题---IE6下对png的透明度支持并不好。本该是透明的地方，在IE6下会显示为浅蓝色。可以使用IE下私有的滤镜功能来解决问题，格式如下：filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='png图片路径',sizingMethod='crop')。
9.ul的不同表现：ul列表也是在IE与Firefox中容易发生问题的对象，主要源自浏览器对ul对象的默认值设置。在IE与Firefox中，一部分对象有默认的属性（比如h1~h6），他们本身就带有大字号、加粗样式以及一些边距效果。ul也是如此，默认情况下ul是有边距的。例如：
HTML：

CSS：

```css
# layout{border:1px solid #333;}
```

ul{list-style:none;}
代码非常简单，仅去除了ul的列表圆点。看下在IE和Firefox的预览效果：
IE预览结果：
Firefox预览结果：
显示都很正常，关键在于我们对ul接下来的设置：
修改后的CSS：

```css
# layout{border:1px solid #333;}

ul{
    list-style:none;
    margin-left:0px;
}
```

设置ul左外边距为0后。
IE预览结果：

Firefox预览结果：

预览后发现问题出现了。IE中的ul已与div靠齐，而Firefox中的ul却丝毫不动。这是为什么？不妨把样式修改下再看看。
修改后的CSS：

```css
#layout{border:1px solid #333;}

ul{
    list-style:none;
    padding-left:0px;
}
```

这次我们把margin-left换成padding-left。再来看看预览结果。
IE预览结果：

Firefox预览结果：

可见效果正好相反，Firefox中实现了靠齐，而IE中丝毫未动。
通过以上例子我们发现：在IE中，ul的默认边距是margin，在Firefox中，ul的默认边距是padding。我们单独定义margin或padding时，自然不能在两个浏览器达到一致效果。这就是ul在不同浏览器下表现不同的问题所在。
解决问题：
可以用hack方法分别针对IE和Firefox单独写样式，但更好的做法是样式开头先统一ul边距，ul{padding:0px;margin:0px;}。
10.IE3px问题：3px问题不是经常被人发现，因为它的影响只产生3px的位移。如果是精确到像素级的设计，3px的影响可谓不小。先来看下例子：
HTML：

```html
<div id="left">左浮动div</div>
<div id="mydiv">段落div</div>
```

CSS：

```css
#left{

    float:left;
    border:1px solid #333;
    width:100px;
    height:100px;
}

#mydiv{

    border:1px solid #f66;
    margin-left:130px;
}
```

## left是引发Bug的一个浮动div，同时设置了边框便于观察

IE预览结果：

Firefox预览结果：

从理论上讲，我们还没有设置#mydiv的padding，它们理所当然是紧贴边框的。但在IE中，“段落”文字并未紧紧贴住#left。在实际中可能会因此导致内部元素宽度超出外部div固定宽度而引发布局问题。
解决问题：
是把#mydiv设置为display:inline-block。
修改后CSS：

```css
#left{

    float:left;
    border:1px solid #333;
    width:100px;
    height:100px;
}

#mydiv{

    border:1px solid #f66;
    margin-left:130px;
    +display:inline-block;
}
```

用hack方法为IE单独设置display:inline-block后。
IE各版本预览结果：

结果与Firefox一致。
11.高度不适应问题：高度不适应指的是，当内层对象的高度发生变化时，外层对象的高度不能自动扩展，特别是当内层对象使用padding或margin之后。高度不适应问题不是IE的专利，Firefox也出现这种问题。先来看看例子：
HTML：
CSS：

```css
#box{

    background-color:#eee;
}

#box p{

    margin-top:20px;
    margin-bottom:20px;
    text-align:center;
}
```

看看代码做了什么，除了背景之外，#box仅是一个没有任何样式的div，而p加了2个关键属性margin-top:20px，margin-bottom:20px;，即上下外边距都是20px，p对象的高度应当是20+20+文字高度，即应当在40px以上。理论上#box这个div的高度会被挤开，至少达到40px以上。我们看看预览效果。
浏览器预览结果：

似乎并非预想的结果，看上去带背景的#box还是和文字一样高，并没有超过40px，这是为什么呢？为了验证一些事情，我们在html前后加上一个带背景的div。
修改后的HTML：
修改后的CSS：

```css
#box{

    background-color:#eee;
}

#box p{

    margin-top:20px;
    margin-bottom:20px;
    text-align:center;
}
.box2{
    background-color:#aaa;
}
```

再来看下预览结果：
浏览器预览结果：

可以看到上下两个div并没有紧贴#box对象，而是有一定的间距。测量下会发现，这个间距刚好是p对象的margin上下各20px。这个测验证明了一个问题，就是#box对象并没有因其中的p对象的margin变化而改变自身的高度。而p对象的margin高度的确在整个页面中占据了一定的空间。相当于#box不动，而p把自己撑到了#box外面去了。
无论是IE还是Firefox，测试中都会发现这个问题。
解决问题：
经过一些测试，我们发现对#box定义padding或者border，就会迫使#box重新计算自己的高度，从而使自身能够适应内容的高度变化。但如果强制给对象设置了边距又会带来位移。我们需要找到一个新方法，不再从对象本身的属性入手，而是在对象的内部进行修复。我们可以在对象上下增加2个高度为0的空div，并强制内容不显示。
修改后的HTML：

这2个div只充当了占位符的角色，而不发生实际的占位。而对它的外层对象而言，由于其中多了一些逻辑占位对象使得它会重新计算高度，从而实现高度的自适应。
预览效果：

12.IE6断头台问题：断头台问题是国外的CSS设计者给这个问题起的一个非常形象的名字，与之相反的，被切断的不是对象的头部，而是对象的底部。先来看下例子：
HTML：

XHTML代码有三部分组成，一个是主对象#layout，主框架中有#left为左浮动对象，右侧为普通的4个链接，类似于左右分栏的布局。
CSS：

```css
# layout{

    border:5px solid #35BB0C;
    width:400px;
    background-color:#F2F2F2;
}

# left{

    border:5px solid #D4CA25;
    width:200px;
    float:left;
    background-color:#fff;
}
a:hover{
    background-color:#fff;
}
```

在CSS代码部分，主要设置了链接的背景色，#left的左浮动，以便于我们观察的粗边框效果。先通过浏览器看看问题是如何发生的，见下图：
IE6预览效果：

这里列出了IE6网页效果的2个状态，当网页被打开时，页面正常显示，与CSS编码指定样式一致。当鼠标右侧的“链接4”时，问题出现了，主对象#layout下面被切掉了，而剩下的高度正好是4个链接的高度。而当鼠标移到“链接1”或“链接2”时，#layout对象的高度又恢复正常。这便是IE6断头台问题。
这个问题的主要原因在于链接上，去除链接的a:hover{background-color:#fff}样式后，一切正常。经测试发现，不仅仅是background-color的变化，如果改变hover状态下链接的其他属性，也会引发同样的问题。例如设置padding、border、加粗、斜体等，都会引发断头台问题。
值得注意的是，在#layout中，#left是个浮动对象，而右测是若干链接对象。对于未指定高度的对象而言，IE6会根据其中的内容（不管浮动与否）来计算高度的大小，而当例子中的链接对象是个非浮动对象，并具有hover改变border,background及padding属性时，IE6会认为这些属性同时会改变#layout的高度，因此它重新计算对象高度。而令人失望的是，IE6的这种自以为是的行为并没有达到预期目的，它会把非浮动对象的总高度作为高度给了#layout，从而切断了#left的内容。基于这类问题的产生原因，解决方案可以有多种。
解决问题：
根据问题产生的原因，我们可以做出多套解决方案。我们知道因为非浮动对象与浮动对象都在#layout中，所以我们可以从浮动方式入手，把非浮动对象改为浮动对象，这样便可以解决问题。例如对XHTML修改如下：

对链接加上个div，并设置浮动#right{float:left}。这样使得两个对象都成为浮动对象，不会引发问题。
也可以在#layout底部增加一个div来强制IE浏览器重新计算高度
，这个清除浮动内容的div会帮助浏览器重新找到合适的高度，从而解决断头台问题。
13.容器不扩展问题：容器不扩展问题是我们经常遇到的。比如我们创建了一个div嵌套结构:
HTML：

CSS：

```css
# divGroup{

    border:2px solid #333;
}

# a,#b{

    border:2px solid #333;
    float:left;
    margin:5px;
}
```

IE预览结果：

Firefox预览结果：

可见外层的高度并没有随着子容器的高度自动扩展，却是形成了一条线。这是因为当子容器成为浮动元素后，并脱离了文档流。因此父容器认为自己内容为空，从而造成了这样的结果。
解决问题：
解决方案是在容器的末尾加入个清理浮动的div。
修改后的HTML：


如果还想防止这个元素占据父元素的高度，可以进一步优化成

，这样这个清除浮动的容器被认为是个不占任何高度的空格字符。在网页中的任何地方，当遇到容器不扩展时，只需加入此段便能修复问题。
14.IE8和FireFox父子元素上下margin叠加问题：
先看下效果：
< span>div class="gray"<
< span>div class="blue"<div<< span>div class="black"<div<div<

.gray{    background:gray;    width:200px;    margin:20px;}.blue{    background:blue;    width:100px;    height:100px;    margin:20px;}.black{    background:black;    width:100px;    height:100px;    margin:20px;}

上图中，蓝色div和黑色div是灰色div的子元素，三个div的margin都是20，但是我们看到蓝色div与其父元素的上边界并没有20px的间隙，黑色div与其父元素的下边界也没有20px的间隙，也就是说蓝色div的上外边距与其父元素的上外边距叠加在了一起，就好像是蓝色div的上外边距跑出去了一样。黑色div也是同理。这就是父元素与子元素的边距叠加效果，叠加后的取值取的是两者中较大的那个。经测试，只要父元素有border或padding，就不会触发这个问题。然而刻意给父元素设置border或padding又会带来位移。可采用如下方法来根本解决问题：
解决问题：给父元素设置overflow:hidden;即可解决。
再来预览下：
IE8：

解决了。
FireFox：

也解决了。
15.IE6高度不固定问题：
典型BUG1：IE6下，即使给父元素设了固定高度，子元素还是会将其撑开。
典型BUG2：如果一个元素没有子元素，而这个元素设置的length又小于div默认高度，则这个元素在IE6里显示的高度仍然是div的默认高度。
引发以上2个BUG的原因在于length属性在IE6里被当作min-length（最小高度）解析了，（换句话说，你压根在IE6中就没设置过固定高度，因为你设置的是最小高度）
解决办法是再给父元素设置overflow:hidden;
16.IE6设置了最小高度并撑满父元素高度：
默认情况下如果对IE6设置了最小高度200px，那么如果实际内容有250px，则只会显示250px的高度。也就是高度会跟随着内容显示。如果此时希望无论里面内容有多少，都让其填充满父元素高度，则要这么设置：
height:auto!important;
height:200px;
min-height:200px;
17.IE6、IE7下浮动元素未脱离文档流假象的问题：
对元素设置浮动后，在IE6&IE7下预览，会产生元素未脱离文档流的假象的现象。其实元素脱离文档流了，这问题其实是其后的元素引起的。由于其后的元素因某些原因造成hasLayout被触发而导致的它未去占据浮动元素的空间（这问题说起来话长，你就这么理解好了：这个大概追朔到表格布局的年代，由于单元格都是有hasLayout的，而后面单元格里的元素肯定不会跑前面的单元格里去的）。关于hasLayout，在第5条里有详细说明，这里单独提出来作为一条来说明，仅因为这个浮动未脱离文档流假象的问题比较典型。
18.全屏遮罩后居中显示一个对话层：
下面是遮罩层：绝对定位，宽高都100%，并且半透明

.over{    position:absolute;    width:100%;    height:100%;    top:0px;    left:0px;    background-color:#7E9898;    filter:alpha(opacity=50);    -moz-opacity:0.5;    -khtml-opacity:0.5;    opacity:0.5;}

下面是对话层：也是绝对定位：

.confirm{    position:absolute;    width:400px;     height:300px;      background:#FFFFFF;    top:300px;    left:0px;}

这里的提示层不要嵌套在遮罩层里面，否则也会受影响，变成半透明的了。要让提示层跟遮罩层并列。
这里还有2个问题：
1.单单对遮罩层使用height:100%，只有IE6会达到效果，而其他浏览器一旦只会是当前可见区域遮上了，如果拖动纵向滚动条，发现下方还有没遮盖上。
2.用户电脑分辨率不同，而绝对定位的提示层使用margin:300px auto也无效。
为了达到各浏览器网页可见区域全部遮盖的效果，这里用了下jquery脚本，解决以上2个问题：
$(document).ready(function(){     $("div[class='cover']").height($(document).height());//将可见区域都遮罩起来      $("div[class='confirm']").css("left",($(document).width()-($("div[class='confirm']").width()))/2+"px");//提示层居中});
最佳实践：
1.写DTD声明：
`<!DOCTYPE html>`
2.引入base.css重置各浏览器默认属性值：

html,body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,form,fieldset,input,textarea,p,blockquote,th,td{margin:0px;padding:0px;}table{border-collapse:collapse;border-spacing:0px;}fieldset,img,abbr,acronym{border:0px;}address,caption,cite,code,dfn,em,strong,th,var{font-style:normal;font-weight:normal;}ol,ul{list-style:none;}caption,th{text-align:left;}h1,h2,h3,h4,h5,h6{font-size:100%;font-weight:normal;}q:before,q:after{content:'';}

3.同时为一个元素写float和margin-left（margin-right）的时候，习惯性地想到IE6会双倍边距，用display:inline解决。
4.为子元素写margin-top或margin-bottom的时候，习惯性的去思考父元素是否有padding或border属性，从而断定是否会在IE6&IE7上产生上下外边距重合问题。如果有问题用overflow:hidden;解决。
5.给元素设了固定高度后，习惯性地再设个overflow:hidden;从而避免IE6上高度继续扩展的问题。
6.必要时候要clear，
。
7.对于文本，在使用margin-left、padding-left、margin-top、padding-top之前优先考虑是否可用text-indent和line-height代替。因为计算尺寸的代价相对来说要大些。
如能做到以上几点，就已经避免了90%的浏览器兼容性问题。
