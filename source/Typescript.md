## 概述

有类型的JavaScript,可以编译成JavaScript,同时拥有类型检查,语言扩展,工具属性。

## Typescript基础数据类型

ES6数据类型：

Object, undefined,null,Number,Boolean,String,Symbol,Array,Function---9个

TS基础数据类型：

Void,Any,Never,元祖,枚举、高级类型

## 接口与类型别名的异同

1.相同点:

都可以描述属性或方法
都允许拓展
2.不同点:

type可以声明基本数据类型,联合类型,数组等; interface只能声明变量
当出现使用type和interface声明同名的数据时;type会直接报错;interface会进行组合
type不会自动合并；interface会

```js
export default {}

// 相同点:
// 1.都可以描述属性或方法
type womenStar = {
  name: string
  age: number
  perform(): any
}
interface IWStar {
  name: string
  age: number
  perform(): any
}

let star1 = {
  name: "邱淑贞",
  age: 18,
  perform() {
    return "倚天屠龙记"
  }
}
let star2 = {
  name: "李一桐",
  age: 18,
  perform() {
    return "射雕英雄传"
  }
}

// 2.都允许拓展
type money  = {
  y1: number
}
type money2 = money & {
  y2: number
}

let salary:money2 = {
  y1: 10,
  y2: 20
}

interface Istar1 {
  name: string
}
interface Istar2 extends Istar1 {
  age: number
}

let starInfo:Istar2 = {
  name: "邱淑贞",
  age: 18
}


// 不同点：
// 1.type可以声明基本数据类型,联合类型,数组等
//   interface只能声明变量
type age = number;
type info = string | number | boolean;
type beautyList = [string | number];
// interface Iage = number; // 报错


// 2.当出现使用type和interface声明同名的数据时
//   type会直接报错
//   interface会进行组合
// type mygoddassName = {
//   name: string
// }

// type mygoddassName = {
//   name: number
// }

interface mygoddassName {
  name: string
} 
interface mygoddassName {
  name: string
  age: number
} 

let goddass:mygoddassName = {
  name: "赵丽颖",
  age: 20
}
```

## 类中的修饰符

public(默认)：公有，可以在任何地方被访问
protected: 受保护，可以被其自身以及其子类访问
private: 私有，只能被其定义所在的类访问。
readonly: 可以使用 readonly关键字将属性设置为只读的。 只读属性必须在声明时或构造函数里被初始化。

```js
export default {}

class Person {
  public name: string;
  protected age: number;
  private sex: string;

  constructor(name: string, age: number, sex: string) {
    this.name = name;
    this.age = age;
    this.sex = sex;
  }

  say():void {
    console.log(`我的名字是${this.name},性别为${this.sex}, 今年${this.age}岁了,`);
  }
}

class Student extends Person {
  score: string
  constructor(name: string, age: number, sex: string, score: string) {
    super(name, age, sex);
    this.score = score;
  }
  show():void {
    console.log(this.name);
    console.log(this.age);
    // console.log(this.sex);
    console.log(this.score);

  }
}

let p = new Person("邱淑贞", 18, "女");
p.say();

let s = new Student("王心凌", 18, "女", "A");
s.show();

// 思考题: 如果我们给 constructor 加上 protected 会出现什么情况？

// readonly: 字段的前缀可以是 readonly 修饰符。这可以防止在构造函数之外对该字段进行赋值。
class PrintConsole {
  readonly str1: string = "HTML, CSS, JS, VUE REACT, NODE"
  readonly str2: string;
  readonly str3: string;
  readonly str4: string;

  constructor(str2: string, str3:string, str4:string) {
    this.str2 = str2;
    this.str3 = str3;
    this.str4 = str4;
  }
  // show():void {
  //   this.str2 = "123"
  // }
}

let pc = new PrintConsole("我的头发去哪了, 颈椎康复指南",
                          "35岁失业该怎么办, 外卖月入一万也挺好",
                          "活着")
```
