---
title: java基础
date: 2018-11-30 20:42:44
updated: 2018-11-30 20:42:44
tags:
- java
- 基础知识
- 笔记
---

- String是复合类型，int ,float 是基本类型
    复合类型是对象类型，对象自己提供了比较方法
```java
String a = "A"; String b = a+"";
System.out.println(a==b);-----------false;
```

- 串与子串
substring(begin,end)  包含begin，不含end，半开区间[begin,end);

<!--more-->

- 进制转换
    Integer.parseInt(串,进制)
    Integer.toString(整数,进制)
    Integer.toBinaryString(数值)
    Integer.toHexString(数值)

- 时间计算
long a = 365L*24*60*60*1000  ----------转为long型，自动向long型转换
long a = (long)……
long a = 1L*……-------------非侵入式


- 类型转换
    自动向高级别转换
    byte->short->int->long->float->double
    无需特殊需要，尽量使用int

- 构造
    初始化一个对象的时候对他进行一次初生的洗礼，设置一些初始值。

```java
class Age{
    public Age(){//没有返回值。没有void比有void更牛。构造方法也可以有多个。
    多种出生方式，
    只选择一种
    没有提供构造方法，默认提供一种，当提供了以后，需要提供一个默认的。
    重载 overload 名字相同，但参数不同，（个数，类型）
    //成员数据(字段)的初始化
    x=1;
}

public Age(int type) {
    if(type==1) x==1;
        else if(type==2) x==18;
        else x =1;
}
}

Class B {
    public B(int x ){}
    public B(){}
}
```

- 堆栈，一般指栈。

- 定义数组

```java
int[] a = [3,7,9,5];
int[] a = new int[4];//默认为0
int[] a = null;
a =new int[][2,6,8];
```

- 斐波那契数列 1，1，2，3，5，8，18，21

```java
int a = 1;int b =1;
for(int i=3;i<=30;i++){
    int c =  a+b;
    System.out.println(c);
    a= b;
    b= c;
}
int[] a = new int[30];
a[0] = 1;a[1] = 1;
for(int i=2;i<a.length;i++){
    a[i] = a[i-1]+a[i-2];
    System.out.println(a[i]);
}

int[][] a = {{2,9,4},{7,5,3},{6,1,8}};
```

传递的参数最大为8字节，实际上java不可能传递对象，至多，java传递对象的引用。

- 数组的应用

```java
String s = "1234567";
char[] cc = s.toCharArray();
```

- 数组弱点
    1.大小固定，不能扩展
    2.在数组中插入、删除元素操作复杂
动态数组--Vector  ArrayList.
    任意位置插入，删除容易
    可以动态增长
    随机访问比数组慢
    


- this
    this是隐藏的形参变量，是一个地址值(对象内存中地址)，是栈变量
    形式参数的值从实参拷贝过来

- static
    构造方法不适合
        构造方法在每次创建对象的时候，自动执行
        不创建对象，构造方法就没有机会执行
    static块在类加载入内存时执行一次
        仅仅执行一次，不会反复执行
        与类同时存在



- 继承
    封装是基础，继承是桥梁，多态是华彩乐章
    继承的目的，重用代码，为多态铺平代码
    java采用接口代替多继承
    java类只能继承一个类，但可以实现多个接口

- 方法覆盖
    子类与父类中同名的方法

- 重载
    重载是编译时可以区分的
    覆盖是在运行时决定调用哪个方法
    覆盖是多态的基础


- 泛化
    对象不发生变化，只是指针发生变化
    是指针引用的泛化，并不是对象的泛化，并不是类的泛化

- 多态
    意义  很牛！！！  多态，泛化

- final  惯用法
    静态常量
    用来定义若干个选项，增加可读性

- 异常控制
    把异常的发现和处理分离

- 分工  专门的人做专门的事    生产不断社会化的过程。
    设计与编码分离
    功能和实现分离
    错误的发现和控制分离

- 异常处理

```java
// 1
try{
//   2
//出异常  
}catch{
// 3
}finally{
// 4
}
```
执行顺序: 1243

- 重定向
 >>追加
 >输出到
<导入

- 抽象方法，有一个抽象方法就是抽象类abstract
松耦合的秘诀

- 内部类对象
    外部类对象不存在无法创建内部类对象
    外部类对象.new 内部类()

- 匿名对象类
    匿名对象 ：对象只用了一次
- 匿名类
    想临时创建实现某个接口类，只用一次，不值得命名
    继承类是临时的
    对象，继承类所创建的对象是临时的；继承类所创建对象需要多次使用，注意泛化。

- 编译
javac -classpath d:\abc\xyz  A.java
命令行选项，编译选项
可以简写成-cp
寻找class文件
    javac.exe所在位置的相对位置
    -classpath参数所指定的位置
    classpath环境变量所声称的位置

- 打包
jar.exe 能处理打包和解包的工作
    jar -cvf A.java

- 文档自动化
    javadoc -d 文档位置 xx.java
    javadoc -d 文档位置 -encoding utf-8  制定编码方式
```java
@param x 参数的描述
@return 返回值的描述
@exception 可能抛出的异常
@see 参见其他模块
@version 版本号
@author 作者

/**
*我的文档自动化示例类<br>
*第二行  x<sup>2</sup>+Y<sup>2</sup>
*/
public class A{
    /**
    *在数组中处理查找整数，返回位置
    */
    public init search(int[] x,int a ){
        
    }
}
```









# android 开发环境搭建经验积累

- Android Studio中显示：
HAX is not working and emulator runs in emulation mode
时，去
Tools->Android->SDK Manager
然后选中
Extras->Intel X86 Emulator Accelerator (HAXM installer)
并安装即可。
记得如果HAX效果没生效，则试试重启Android Studio试试，或许就可以了。
相对来说：和之前的Eclipse+ADT时代，要先后自己手动下载HAX相关工具并安装和配置，的做法相比，Android Studio中只需要选中并安装即可搞定，要方便多了。
