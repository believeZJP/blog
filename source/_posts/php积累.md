---
title: php积累
date: 2019-12-05 16:39:16
updated: 2019-12-05 16:39:16
tags:
---


boolean值传到前端的时候转成了1

PHP 脚本可放置于文档中的任何位置。
PHP 脚本以 <?php 开头，以 `?>` 结尾：

```php
<?php
// 此处是 PHP 代码
?>
<?php
  //这里是代码，哈哈
?>
```

PHP 文件的默认文件扩展名是 ".php"。
PHP 文件通常包含 HTML 标签以及一些 PHP 脚本代码

```php
<?php
echo " Hello World!";
?>
<?php
 //这是单行注释
 #这也是 单行注释
 /*
  这是多行注释
 */
?>
```

变量大小写分明

```php
<?php
 $color = "red";
 echo "My car is" .$color."<br>";
 echo "My car is" .$COLOR."<br>";
 echo "My car is" .$coLOR."<br>";

?>
```

PHP 变量规则：
变量以 `$` 符号开头，其后是变量的名称
变量名称必须以字母或下划线开头
变量名称不能以数字开头
变量名称只能包含字母数字字符和下划线（A-z、0-9 以及 _）
变量名称对大小写敏感（`$y` 与 `$Y` 是两个不同的变量）
==注释：PHP 变量名称对大小写敏感！==

PHP 有三种不同的变量作用域：
local（局部）
global（全局）
static（静态）
PHP 同时在名为 $GLOBALS[index] 的数组中存储了所有的全局变量。下标存有变量名。这个数组在函数内也可以访问，并能够用于直接更新全局变量。

```php
function myTest() {
  $GLOBALS['y']=$GLOBALS['x']+$GLOBALS['y'];
}
function myTest() {
  static $x=0;
  echo $x;
  $x++;
}
```

- echo 和 print 语句

echo 和 print 之间的差异：
echo - 能够输出一个以上的字符串
print - 只能输出一个字符串，并始终返回 1

- 并置运算符（Concatenation Operator）
在 PHP 中，只有一个字符串运算符。
并置运算符 `.` 用于把两个字符串值连接起来。
要把两个变量连接在一起，请使用这个点运算符 `.`
严格区别于其他语言的`+`

- `strlen()`和`strpos()`
`strlen()` 函数用于计算字符串的长度。
`strpos()` 函数用于在字符串内检索一段字符串或一个字符。

PHP 的真正威力源自于它的函数。
在 PHP 中，提供了超过 700 个内建的函数。

创建 PHP 函数：
所有的函数都使用关键词 `function()` 来开始
命名函数 - 函数的名称应该提示出它的功能。函数名称以字母或下划线开头。

`$_REQUEST` 变量
PHP 的 `$_REQUEST` 变量包含了 `$_GET`, `$_POST` 以及 `$_COOKIE` 的内容。
PHP 的 `$_REQUEST` 变量可用来取得通过 GET 和 POST 方法发送的表单数据的结果。

`mktime()` 函数
返回一个日期的 UNIX 时间戳
`mktime(hour,minute,second,month,day,year,is_dst)`

- 服务器端引用（Server Side Includes）
通过 `include()` 或 `require()` 函数，您可以在服务器执行 PHP 文件之前在该文件中插入一个文件的内容。

除了它们处理错误的方式不同之外，这两个函数在其他方面都是相同的。include() 函数会生成一个警告（但是脚本会继续执行），而 require() 函数会生成一个致命错误（fatal error）（在错误发生后脚本会停止执行）。

- `PHP Session`
在您把用户信息存储到 `PHP session` 中之前，首先必须启动会话。
注释：`session_start()` 函数必须位于 html 标签之前：

```php
<?php session_start(); ?>

<html>
<body>

</body>
</html>
```

上面的代码会向服务器注册用户的会话，以便您可以开始保存用户信息，同时会为用户会话分配一个 UID。
