---
title: CSS 代码示例
date: 2018-11-29 20:36:46
updated: 2018-11-29 20:36:46
tags:
- CSS
- CSS3
- 代码示例
---

# 设置元素readonly和disabled样式
```css
#endDate:read-only{
    cursor:pointer;
}
#endDate:disabled{
    cursor:not-allowed;
}
```

# placeholder样式修改

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

# 选择被用户选取的元素部分

```css
::selection {
    background:lightblue;
}
```

# css选择器，选择除了最后一个以外的元素
场景：每个li都加右边框，除了最后一个
需要写个demo试一下，如果li里嵌套其他元素是否生效
```css
.ab-character-con .l3:not(:last-child){
    border-right:1px solid red;
}
```














