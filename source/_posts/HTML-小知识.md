---
title: HTML 小知识
date: 2019-12-05 16:36:25
updated: 2019-12-05 16:36:25
tags:
---

1.设置input 语法检查
`spellcheck="false/true"`
2.设置input是否自动补全
`autocomplete="off/on"`
3.页面加载时，自动获取焦点
`autofocus="autofocus"`

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

```

上面代码的意思是，让布局视口的宽度等于理想视口的宽度，页面的初始缩放比例以及最大缩放比例都为1，且不允许用户对页面进行缩放操作。

### input标签只能输入数字js实现(且不能输入e或者其他各种符号)

<span style="font-family: Arial, Helvetica, sans-serif;"><input id="xxx" type="number" onKeypress="return (/[\d]/.test(String.fromCharCode(event.keyCode)))" style="width:475px;ime-mode: Disabled" ></span>

ime-mode的语法解释如下：

ime-mode : auto | active | inactive | disabled

取值：

auto  : 默认值。不影响IME的状态。与不指定 ime-mode 属性时相同

active  : 指定所有使用IME输入的字符。即激活本地语言输入法。用户仍可以撤销激活IME

inactive  : 指定所有不使用IME输入的字符。即激活非本地语言。用户仍可以撤销激活IME

disabled  : 完全禁用IME。对于有焦点的控件(如输入框)，用户不可以激活IME

IME 是指 Input Method Editors 输入法编辑器

慕课网学习
  1.html基础
  em标签：强调，斜体；strong:强调
 <address>斜体，用于显示地址
<q>标签的真正关键点不是它的默认样式双引号，而是它的语义：引用别人的话。

<blockquote>的作用也是引用别人的文本。但它是对长文本的引用，如在文章中引入大段某知名作家的文字，这时需要这个标签。

html4.01版本 <hr>    <br>
xhtml1.0版本 <hr />  <br/>

显示代码段
   一行---<code></code>
   多行----<pre></pre>
select 多选
        <select multiple="multiple">
Label中的for事件
label标签不会向用户呈现任何特殊效果，它的作用是为鼠标用户改进了可用性。如果你在 label 标签内点击文本，就会触发此控件。就是说，当用户单击选中该label标签时，浏览器就会自动将焦点转到和标签相关的表单控件上（就自动选中和该 label标签相关连的表单控件上）。
placeholder属性
<input type="email" id="email" placeholder="Enter email">

css样式

三种样式是有优先级的，记住他们的优先级：内联式 > 嵌入式 > 外部式

类选择器和id选择器的相同、不同点
相同点和不同点：
相同点：可以应用于任何元素
不同点：
1、ID选择器只能在文档中使用一次。与类选择器不同，在一个HTML文档中，ID选择器只能使用一次，而且仅一次。而类选择器可以使用多次。
2、可以使用类选择器词列表方法为一个元素同时设置多个样式。我们可以为一个元素同时设多个样式，但只可以用类选择器的方法实现，ID选择器是不可以的（不能使用 ID 词列表）。
子选择器
还有一个比较有用的选择器子选择器，即大于符号(>),用于选择指定标签元素的第一代子元素。如右侧代码编辑器中的代码：
.food>li{border:1px solid red;}
包含(后代)选择器
包含选择器，即加入空格,用于选择指定标签元素下的后辈元素。如右侧代码编辑器中的代码：
.first  span{color:red;}
请注意这个选择器与子选择器的区别，子选择器（child selector）仅是指它的直接后代，或者你可以理解为作用于子元素的第一代后代。而后代选择器是作用于所有子后代元素。后代选择器通过空格来进行选择，而子选择器是通过“>”进行选择。
总结：>作用于元素的第一代后代，空格作用于元素的所有后代。
通用选择器  *
伪类选择符
更有趣的是伪类选择符，为什么叫做伪类选择符，它允许给html不存在的标签（标签的某种状态）设置样式，比如说我们给html中一个标签元素的鼠标滑过的状态来设置字体颜色：
a:hover{color:red;}
分组选择符
当你想为html中多个标签元素设置同一个样式时，可以使用分组选择符（，），如下代码为右侧代码编辑器中的h1、span标签同时设置字体颜色为红色：
h1,span{color:red;}
继承
CSS的某些样式是具有继承性的，那么什么是继承呢？继承是一种规则，它允许样式不仅应用于某个特定html标签元素，而且应用于其后代。比如下面代码：如某种颜色应用于p标签，这个颜色设置不仅应用p标签，还应用于p标签中的所有子元素文本，这里子元素为span标签。
p{color:red;}

<p>三年级时，我还是一个<span>胆小如鼠</span>的小女孩。</p>
可见右侧结果窗口中p中的文本与span中的文本都设置为了红色。但注意有一些css样式是不具有继承性的。如border:1px solid red;
p{border:1px solid red;}

<p>三年级时，我还是一个<span>胆小如鼠</span>的小女孩。</p>
特殊性
根据权值来判断使用哪种css样式的，权值高的就使用哪种css样式。
下面是权值的规则：
标签的权值为1，类选择符的权值为10，ID选择符的权值最高为100。例如下面的代码：
p{color:red;} /*权值为1*/
p span{color:green;} /*权值为1+1=2*/
.warning{color:white;} /*权值为10*/
p span.warning{color:purple;} /*权值为1+1+10=12*/
# footer .note p{color:yellow;} /*权值为100+10+1=111*/
注意：还有一个权值比较特殊--继承也有权值但很低，有的文献提出它只有0.1，所以可以理解为继承的权值最低。
层叠
内联样式表（标签内部）> 嵌入样式表（当前文件中）> 外部样式表（外部文件中）。

重要性
样式优先级为：浏览器默认的样式 < 网页制作者样式 < 用户自己设置的样式，但记住!important优先级样式是个例外，权值高于用户自己设置的样式。
  现在一般网页喜欢设置“微软雅黑”，如下代码：
body{font-family:"Microsoft Yahei";}
文字排版--斜体
以下代码可以实现文字以斜体样式在浏览器中显示：
p a{font-style:italic;}
文字排版--下划线
有些情况下想为文字设置为下划线样式，这样可以在视觉上强调文字，可以使用下面代码来实现：
p a{text-decoration:underline;}
删除线使用下面代码就可以实现：
 .oldPrice{text-decoration:line-through;}
段落排版--缩进
中文文字中的段前习惯空两个文字的空白，这个特殊的样式可以用下面代码来实现：
p{text-indent:2em;}
注意：2em的意思就是文字的2倍大小
段落排版--行间距
这一小节我们来学习一下另一个在段落排版中起重要作用的行间距属性（line-height），如下代码实现设置段落行间距为1.5倍。
p{line-height:1.5em;}
段落排版--字间距、字母间距
文字间隔、字母间隔设置：
如果想在网页排版中设置文字间隔或者字母间隔就可以使用    letter-spacing来实现，如下面代码：
h1{
    letter-spacing:50px;
}
注意：这个样式使用在英文单词时，是设置字母与字母之间的间距。
单词间距设置：
如果我想设置英文单词之间的间距呢？可以使用word-spacing来实现。如下代码：
h1{
    word-spacing:50px;
}
段落排版--对齐
想为块状元素中的文本、图片设置居中样式吗？可以使用text-align样式代码，如下代码可实现文本居中显示。(那么什么是块状元素呢？在后面的11-1、11-2小节中会讲到。)
h1{
    text-align:center;
}
元素分类
在讲解CSS布局之前，我们需要提前知道一些知识，在CSS中，html中的标签元素大体被分为三种不同的类型：块状元素、内联元素(又叫行内元素)和内联块状元素。
常用的块状元素有：
<div>、<p>、<h1>...<h6>、<ol>、<ul>、<dl>、<table>、<address>、<blockquote>
 、<form>
常用的内联元素有：
<a>、<span>、<br>、<i>、<em>、<strong>、<label>、<q>、<var>、<cite>、<code>
常用的内联块状元素有：
<img>、<input>
元素分类--块级元素
什么是块级元素？在html中<div>、 <p>、<h1>、<form>、<ul> 和 <li>就是块级元素。设置display:block就是将元素显示为块级元素。如下代码就是将内联元素a转换为块状元素，从而使a元素具有块状元素特点。
a{display:block;}
块级元素特点：
1、每个块级元素都从新的一行开始，并且其后的元素也另起一行。（真霸道，一个块级元素独占一行）
2、元素的高度、宽度、行高以及顶和底边距都可设置。
3、元素宽度在不设置的情况下，是它本身父容器的100%（和父元素的宽度一致），除非设定一个宽度。
元素分类--内联元素
在html中，<span>、<a>、<label>、<input>、 <img>、 <strong> 和<em>就是典型的内联元素（行内元素）（inline）元素。当然块状元素也可以通过代码display:inline将元素设置为内联元素。如下代码就是将块状元素div转换为内联元素，从页使用div元素具有内联元素特点。
内联元素特点：
1、和其他元素都在一行上；
2、元素的高度、宽度、行高及顶部和底部边距不可设置；
3、元素的宽度就是它包含的文字或图片的宽度，不可改变。
小伙伴们你们观查一下右侧代码段，有没有发现一个问题，内联元素之间有一个间距问题，这个问题在本小节的wiki中有介绍，感兴趣的小伙伴可以去查看。
解决行内元素间隙bug问题
行内元素之间会产生间隙bug问题的场景：
1、当行内元素之间有“回车”、“tab”、“空格”时就会出现间隙。
如下代码：
<div>

   <a>1</a>

   <a>2</a>

   <span>33333</span>

   <span>44444</span>

   <em>555555</em>

</div>
解决方法：
1、写在一行，之间不要有空格之类的符号。
<div>

<a>1</a><a>2</a><span>33333</span><span>44444</span><em>555555</em>

</div>
2、使用font-size:0
div{font-size:0;}

a,span,em{font-size:16px;}

元素分类--内联块状元素
内联块状元素（inline-block）就是同时具备内联元素、块状元素的特点，代码display:inline-block就是将元素设置为内联块状元素。(css2.1新增)，<img>、<input>标签就是这种内联块状标签。
inline-block元素特点：
1、和其他元素都在一行上；
2、元素的高度、宽度、行高以及顶和底边距都可设置。
<!DOCTYPE HTML>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<title>内联块状元素</title>

<style type="text/css">

a{

    display:inline-block;

 width:20px;/*在默认情况下宽度不起作用*/

 height:20px;/*在默认情况下高度不起作用*/

 background:pink;/*设置背景颜色为粉色*/

 text-align:center; /*设置文本居中显示*/

}

</style>

</head>

<body>

<a>1</a>

<a>2</a>

<a>3</a>

<a>4</a>

</body>

</html>
内填充，外边距，边框，
盒模型--边框（一）
盒子模型的边框就是围绕着内容及补白的线，这条线你可以设置它的粗细、样式和颜色(边框三个属性)。
div{
    border:2px  solid  red;
}
上面是border代码的缩写形式，可以分开写：
div{
    border-width:2px;
    border-style:solid;
    border-color:red;
}
注意：
1、border-style（边框样式）常见样式有：
dashed（虚线）| dotted（点线）| solid（实线）。
2、border-color（边框颜色）中的颜色可设置为十六进制颜色，如:
border-color:#888;//前面的井号不要忘掉。
3、border-width（边框宽度）中的宽度也可以设置为：
thin | medium | thick（但不是很常用），最常还是用象素（px）。
盒模型--宽度和高度
盒模型宽度和高度和我们平常所说的物体的宽度和高度理解是不一样的，css内定义的宽（width）和高（height），指的是填充以里的内容范围。

因此一个元素实际宽度（盒子的宽度）=左边界+左边框+左填充+内容宽度+右填充+右边框+右边界。

元素的高度也是同理。
盒模型--填充
元素内容与边框之间是可以设置距离的，称之为“填充”。填充也可分为上、右、下、左(顺时针)。如下代码：
div{padding:20px 10px 15px 30px;}
顺序一定不要搞混。可以分开写上面代码：
div{
   padding-top:20px;
   padding-right:10px;
   padding-bottom:15px;
   padding-left:30px;
}
如果上、右、下、左的填充都为10px;可以这么写
div{padding:10px;}
如果上下填充一样为10px，左右一样为20px，可以这么写：
div{padding:10px 20px;}
盒模型--边界
元素与其它元素之间的距离可以使用边界（margin）来设置。边界也是可分为上、右、下、左。如下代码：
div{margin:20px 10px 15px 30px;}
也可以分开写：
div{
   margin-top:20px;
   margin-right:10px;
   margin-bottom:15px;
   margin-left:30px;
}

如果上右下左的边界都为10px;可以这么写：
div{ margin:10px;}
如果上下边界一样为10px，左右一样为20px，可以这么写：
div{ margin:10px 20px;}
总结一下：padding和margin的区别，padding在边框里，margin在边框外。
12-1 CSS布局模型
css布局模型
清楚了CSS 盒模型的基本概念、 盒模型类型，
我们就可以深入探讨网页布局的基本模型了。布局模型与盒模型一样都是 CSS 最基本、 最核心的概念。
但布局模型是建立在盒模型基础之上，又不同于我们常说的 CSS 布局样式或 CSS 布局模板。如果说布局模型是本，那么 CSS
布局模板就是末了，是外在的表现形式。
CSS包含3种基本的布局模型，用英文概括为：Flow、Layer 和 Float。
在网页中，元素有三种布局模型：
1、流动模型（Flow）
2、浮动模型 (Float)
3、层模型（Layer）
s流动模型（一）
先来说一说流动模型，流动（Flow）是默认的网页布局模式。也就是说网页在默认状态下的 HTML 网页元素都是根据流动模型来分布网页内容的。
流动布局模型具有2个比较典型的特征：
第一点，块状元素都会在所处的包含元素内自上而下按顺序垂直延伸分布，因为在默认状态下，块状元素的宽度都为100%。实际上，块状元素都会以行的形式占据位置。如右侧代码编辑器中三个块状元素标签(div，h1，p)宽度显示为100%。
块状元素的特点：“在默认状态下，块状元素的宽度都为100%”。
12-3  流动模型二

流动模型（二）

第二点，在流动模型下，内联元素都会在所处的包含元素内从左到右水平分布显示。（内联元素可不像块状元素这么霸道独占一行）

右侧代码编辑器中内联元素标签a、span、em、strong都是内联元素。
内联元素的特点：“包含元素内从左到右水平分布显示”

12-4  浮动模型

浮动模型

块状元素这么霸道都是独占一行，如果现在我们想让两个块状元素并排显示，怎么办呢？不要着急，设置元素浮动就可以实现这一愿望。任何元素在默认情况下是不能浮动的，但可以用CSS定义为浮动，如div、p、table、img等元素都可以被定义为浮动。
float  浮动

12-5
什么是层模型？

什么是层布局模型？层布局模型就像是图像软件PhotoShop中非常流行的图层编辑功能
一样，每个图层能够精确定位操作，但在网页设计领域，由于网页大小的活动性，层布局没能受到热捧。但是在网页上局部使用层布局还是有其方便之处的。下面我
们来学习一下html中的层布局。

如何让html元素在网页中精确定位，就像图像软件PhotoShop中的图层一样可以对每个图层能够精确定位操作。CSS定义了一组定位（positioning）属性来支持层布局模型。

层模型有三种形式：

1、绝对定位(position: absolute)

2、相对定位(position: relative)

3、固定定位(position: fixed)

            12-6
层模型--绝对定位
如果想为元素设置层模型中的绝对定位，需要设置position:absolute(表示绝对定位)，这条语句的作用将元素从文档流中拖出来，然后使用left、right、top、bottom属性相对于其最接近的一个具有定位属性的父包含块进行绝对定位。如果不存在这样的包含块，则相对于body元素，即相对于浏览器窗口。
12-7
层元素相对定位
层模型--相对定位

如果想为元素设置层模型中的相对定位，需要设置position:relative（表示相对定位），它通过left、right、top、bottom属性确定元素在正常文档流中的偏移位置。相对定位完成的过程是首先按static(float)方式生成一个元素(并且元素像层一样浮动了起来)，然后相对于以前的位置移动，移动的方向和幅度由left、right、top、bottom属性确定，偏移前的位置保留不动。

如下代码实现相对于以前位置向下移动50px，向右移动100px;

# div1{

    width:200px;
    height:200px;
    border:2px red solid;
    position:relative;
    left:100px;
    top:50px;
}

<div id="div1"></div>

什么叫做“偏移前的位置保留不动”呢？

大家可以做一个实验，在右侧代码编辑器的19行div标签的后面加入一个span标签，在标并在span标签中写入一些文字。如下代码：

<body>
    <div id="div1"></div><span>偏移前的位置还保留不动，覆盖不了前面的div没有偏移前的位置</span>
</body>

效果图：

从效果图中可以明显的看出，虽然div元素相对于以前的位置产生了偏移，但是div元素以前的位置还是保留着，所以后面的span元素是显示在了div元素以前位置的后面。

12-8
层模型--固定定位

fixed：表示固定定位，与absolute定位类型类似，但它的相对移动的坐标是视图（屏幕内的网页窗口）
本身。由于视图本身是固定的，它不会随浏览器窗口的滚动条滚动而变化，除非你在屏幕中移动浏览器窗口的屏幕位置，或改变浏览器窗口的显示大小，因此固定定
位的元素会始终位于浏览器窗口内视图的某个位置，不会受文档流动影响，这与background-attachment:fixed;属性功能相同。以下
代码可以实现相对于浏览器视图向右移动100px，向下移动50px。并且拖动滚动条时位置固定不变。

12-9
Relative与Absolute组合使用

小伙伴们学习了12-6小节的绝对定位的方法：使用position:absolute可以实现被设置元素相对于浏览器（body）设置定位以后，大家有没有想过可不可以相对于其它元素进行定位呢？答案是肯定的，当然可以。使用position:relative来帮忙，但是必须遵守下面规范：

1、参照定位的元素必须是相对定位元素的前辈元素：

<div id="box1"><!--参照定位的元素-->
    <div id="box2">相对参照元素进行定位</div><!--相对定位元素-->
</div>

从上面代码可以看出box1是box2的父元素（父元素当然也是前辈元素了）。

2、参照定位的元素必须加入position:relative;

# box1{

    width:200px;
    height:200px;
    position:relative;
}

3、定位元素加入position:absolute，便可以使用top、bottom、left、right来进行偏移定位了。

# box2{

    position:absolute;
    top:20px;
    left:30px;
}

这样box2就可以相对于父元素box1定位了（这里注意参照物就可以不是浏览器了，而可以自由设置了）。

13.1
盒模型代码简写

还记得在讲盒模型时外边距(margin)、内边距(padding)和边框(border)设置上下左右四个方向的边距是按照顺时针方向设置的：上右下左。具体应用在margin和padding的例子如下：

margin:10px 15px 12px 14px;/*上设置为10px、右设置为15px、下设置为12px、左设置为14px*/

通常有下面三种缩写方法:

1、如果top、right、bottom、left的值相同，如下面代码：

margin:10px 10px 10px 10px;

可缩写为：

margin:10px;

2、如果top和bottom值相同、left和 right的值相同，如下面代码：

margin:10px 20px 10px 20px;

可缩写为：

margin:10px 20px;

3、如果left和right的值相同，如下面代码：

margin:10px 20px 30px 20px;

可缩写为：

margin:10px 20px 30px;

注意：padding、border的缩写方法和margin是一致的。

13-2
颜色值缩写

关于颜色的css样式也是可以缩写的，当你设置的颜色是16进制的色彩值时，如果每两位的值相同，可以缩写一半。

例子1：

p{color:#000000;}

可以缩写为：

p{color: #000;}

例子2：

p{color: #336699;}

可以缩写为：

p{color: #369;}

13-3
字体缩写

网页中的字体css样式代码也有他自己的缩写方式，下面是给网页设置字体的代码：

body{
    font-style:italic;
    font-variant:small-caps;
    font-weight:bold;
    font-size:12px;
    line-height:1.5em;
    font-family:"宋体",sans-serif;
}

这么多行的代码其实可以缩写为一句：

body{
    font:italic  small-caps  bold  12px/1.5em  "宋体",sans-serif;
}

注意：

1、使用这一简写方式你至少要指定 font-size 和 font-family 属性，其他的属性(如 font-weight、font-style、font-varient、line-height)如未指定将自动使用默认值。

2、在缩写时 font-size 与 line-height 中间要加入“/”斜扛。

一般情况下因为对于中文网站，英文还是比较少的，所以下面缩写代码比较常用：

body{
    font:12px/1.5em  "宋体",sans-serif;
}

只是有字号、行间距、中文字体、英文字体设置。

第二阶段

网页设计特点，
宽度可以自适应，长度无限制

2-1一列布局
.main{width:800px;height:300px;margin:0 auto;background:#ccc;}
<div class="main"></div>

三列布局
.left{ width:200px; height:600px; background:#ccc; position:absolute; left:0; top:0}

.main{ height:600px; margin:0 200px 0 200px; background:#9CF}

.right{ height:600px; width:200px; position:absolute; top:0; position:absolute;right:0; background:#FCC;}

w3c倡导
倡导结构、样式、行为分离

css中，存在3中定位机制
标准文档流(Normal flow)
浮动 (Floats)
绝对定位(Absolute positioning)

标准文档流
特点：从上到下、从左到右、输出文档内容
由块级标签和行级标签组成

块级 特点
从左到右撑满页面，独占一行；触碰到页面边缘时，会自动换行
div,ul,li,dl,dt,p...

行级元素
特点：能在同一行内显示，不会改变html文档结构
span,strong,img,input

块级元素和行级元素都是盒子模型

如果想让页面自动居中，当设置margin属性为auto时，不能再设置浮动或绝对定位属性

float属性：left,right,none;
当元素没有设置宽度值，而设置了浮动属性，元素的宽度随内容的变化而变化。

清除浮动的常用方法
clear:both;或clear:left;或clear:right;

同时设置width:100%(或固定高度)+overflow:hidden;
清除浮动时，只设置宽度不行，必须设置overflow:hidden;才能实现清除浮动的效果

横向两列布局
主要应用技能
    float:使纵向排列的块级元素，横向排列
    margin属性，设置两列之间的间距
当父块包含块2缩成一条时，用clear:both清除浮动无效，它一般用于紧邻后面的元素的清除浮动

position属性

拥有3种定位方式 1.静态定位 2.相对定位  3.绝对定位
可以设置4个属性值
 static （静态定位）
    relative （相对定位）
    absolute（绝对定位）
    fixed（固定定位）

相对定位  特点：相对于自身原有位置进行定位，仍处于标准文档流中，随即拥有偏移属性和z-index属性

  相对于自己本来应该在的位置进行偏移，设置top,left,right,bottom属性。

绝对定位： 特点：建立了以包含块为基准的定位，完全脱离了标准文档流，随即拥有偏移属性和z-inde属性

未设置偏移量
特点 无论是否存在已定位祖先元素，都保持在原始位置  脱离了标准文档流

设置偏移量
 偏移参照基准
        无定位祖先元素，yi<html>为偏移参照标准
        有已定位祖先元素，以距其最近的已定位祖先元素为偏移参照基准

使用absolute实现横向两列布局
        --常用于一列固定长度，另一列宽度自适应的情况
  主要技能
        relative  氟元素相对定位
        absolute  自适应元素绝对定位

   注意 ：固定宽度列的高度>自适应宽度的列

 不设置长宽，用absolute 绝对定位本身就是自适应宽度
  
网页简单布局之结构与表现

html  css  javascript
结构  表现  行为

先按照结构和语义编写代码，然后进行css样式设置，减少html和css的契合度

1/1. 在网页制作中，面对设计图，网页制作人员一般要遵循的原则是什么？
C先考虑设计图中的文字内容和内容模块之间的关系，重点放在编写html结构和语义化，然后考虑布局和表现形式。

第二步  案例实现

按钮特效
1.1幽灵按钮 透明按钮
  css3关键技术点
    transform
    transition
    box-sizing
    border-radius

transfrom属性向元素应用2D或3D转换。该元素允许我们对元素进行旋转、缩放、移动或倾斜。

css 雪碧效果

1.原则：
        1.静态图片，不随用户信息变化而变化

        2.小图片，图片容量比较小

        一些大图不建议拼成雪碧图

2.目的
        1.减少 http请求数量

        2.加速内容显示

实现原理  background-position

        控制一个层，可显示的区域范围大小，

        通过一个窗口，进行背景图的滑动

实现方式  1.ps手动拼图，
           2.使用sprite工具自动生成

工具  ：cssgaga

css圆角设计
    使用css2.0+html标签模拟圆角优缺点分析
    1.代码量少，不需要增加http请求
    2.后期维护性好，但是圆角像素的增加
    3.无意义代码将成倍增加
    4.实现的圆角局限性
    5.只能实现纯色圆角

css3.0圆角属性
border-radius
    属性值：表示圆角半径，可使用长度单位px,或百分比
    简写属性:border-radius
    分量属性：border-top-left-radius(上左)、border-top-right-radius(上右)
        border-bottom-right-radius(下右)、border-bottom-left-radius(下左)

属性值设置,与margin相同。
    1个，四个角半径相同。2个，互为对角。

浏览器私有前缀

    解决浏览器显示差异，针对浏览器写私有前缀
       IE内核：-ms-
        Firefox内核：-moz-
        谷歌浏览器、safari内核:-webkit-

使用dl,dt,dd的原因
    语义化，使一些内容在一个dl内，而ul，li做不到un

响应式设计优缺点:
    优点：解决了设备之间的差异化展示
    缺点:兼容性代码多，工作量大，加载速度受影响
        对原有网站布局产生影响，用户判断未必精确
设计原则：

    移动优先：在设计的初期就要考虑页面如何在多终端展示
    渐进增强:充分发挥硬件设备的最大功能
如何实现:响应式布局
    css3-Media query 最简单的方式
    原生javascript  成本高，不推荐使用
    第三方开源框架  可以很好的支持浏览器响应式布局

css3-Media Query
        常见的属性：
            device-width,deivce-height---屏幕宽高
            width,height ---渲染窗口，展示页面的宽高
            orientation ---设备方向
            resolution---设备分辨率

## Yahoo军规

1.尽可能减少http请求数量
2.使用CDN 内容分发网络
    在离你最近的地方，放置一台性能好链接顺畅
    的副本服务器，让你能够以最近的距离，最快的速度
    获取内容。
靠money解决问题
3.添加expire/Cache-Control头
    expire头的内容是一个时间值，
    值就是资源在本地的过期时间、存在本地。
    在本地缓存阶段，找到一个对应的资源值，
    当前时间还没超过资源的过期时间，就直接使用这一个资源，不会发送http请求。
    cache-control
    是http协议中常用的头部之一，
    负责控制页面的缓存机制
4.启用Gzip压缩
    把文件先放在服务器压缩再传输
    html,php,js,css,xml,css
5.将css放在页面最上面
    放在head中，先进行加载和渲染
6.将script放在页面最下面
    首先将页面呈现出来，这样页面不会等太久
7.避免在css中使用Expressions
    css Expressions:css表达式--javascript
    页面显示缩放，页面滚动，移动鼠标都会重新计算
8.把js和css放到外部文件中
        单独提取：
            提高了js和css的复用性
            减小页面体积
            提高了js和css的可维护性
    写在页面里
            减少页面请求
            提升页面渲染速度
    写在页面内的情况：
        样式只应用于一个页面
        不经常被访问到
        脚本和样式很少（不多于20行）
9.减少dns查询
    当缓存时间长时：减少dns的重复查找，节省时间
    当缓存时间短时：及时检测网站服务器的变化，保证正确性。
    多域，单域
10.压缩javascript和css
     去除不必要的空白符，格式符，注释符
        简写方法名，参数名压缩js脚本
11.避免重定向
    原始请求被重新转向到了其他请求
    301 被移动到了另外的位置(永久重定向)
    302 用户所请求的页面找到了，但不在原始位置（临时重定向）
  301更智能
 12.移除重复脚本
  13.配置实体标签(ETag)??
14.使用ajax缓存
    post每次都执行，不被缓存
    get同一地址不重复执行，可以被缓存

14.yslow工具简介
    对网站进行分析，给一些建议，规则，
    一步步优化网站
使用：
    按f12会出现在console之后
    runtest
      v2,22;v1,13;small,14
    grade A-F
