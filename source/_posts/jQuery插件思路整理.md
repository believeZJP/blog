---
title: jQuery插件思路整理
date: 2018-11-29 21:42:02
updated: 2018-11-29 21:42:02
tags:
- jQuery
- 插件
- 封装
---

## jQuery插件的封装

```JavaScript
(function($){
    // do something
})(jQuery);
```

闭包的作用
--避免全局依赖
--避免第三方破坏
--兼容jQuery操作符‘$’和jQuery

<!---more--->

## 开发方式

- 类级别组件开发
-即给jQuery命名空间下添加新的全局函数，也称静态方法。

```JavaScript
jQuery.myPlugin = function(){
    // do something
};
```

例如：`$.ajax,$.extend()`

- 对象级别组件开发
-即挂在jQuery原型下的方法，这样通过选择器获取的jQuery对象实例也能共享该方法, 也称动态方法。

```JavaScript
$.fn.myPlugin = function(){
    // do something
};
```

这里 `$.fn === $.prototype`
例如：`addClass()、attr()` 等，需要创建实例来调用

- 链式调用
eg: `$("div").next().addClass()`

```JavaScript
$.fn.myPlugin = function(){
    return this.each(function(){
        // do something
    });
};
```

代码说明：

- return this 返回当前对象，来维护插件的链式调用
- each 循环实现每个元素的访问

- 单例模式

```JavaScript
$.fn.myPlugin  = function(){
    var me = $(this),
        instance = me.data("myPlugin");
    if (!instance) {
        me.data("myPlugin",(instance= new Plugin()));
    }
};
```

代码说明：
-如果实例存在则不再重新创建实例
-利用data()来存放插件对象的实例
