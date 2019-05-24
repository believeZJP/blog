---
title: CSS 代码示例
date: 2018-11-29 20:36:46
updated: 2018-11-29 20:36:46
tags:
- CSS
- CSS3
- 代码示例
---

## 设置元素readonly和disabled样式

```css
#endDate:read-only{
    cursor:pointer;
}
#endDate:disabled{
    cursor:not-allowed;
}
```

<!---more--->

## placeholder样式修改

```css
.input::-webkit-input-placeholder {
    color: red;
}
.input:-moz-placeholder {
    color: red;
}
.input:-ms-input-placeholder {
    color: red;
}
```

## 选择被用户选取的元素部分

```css
::selection {
    background:lightblue;
}
```

## css选择器，选择除了最后一个以外的元素

场景：每个li都加右边框，除了最后一个
需要写个demo试一下，如果li里嵌套其他元素是否生效

```css
.ab-character-con .l3:not(:last-child){
    border-right:1px solid red;
}
```

## css两端对齐

效果：

```word
姓       名
手  机   号
电 话 号 码
```

```html
// html
<div>姓名</div>
<div>手机号码</div>
<div>账号</div>
<div>密码</div>

// css
div {
    margin: 10px 0;
    width: 100px;
    border: 1px solid red;
    text-align: justify;
    text-align-last:justify
}
div:after{
    content: '';
    display: inline-block;
    width: 100%;
}

```