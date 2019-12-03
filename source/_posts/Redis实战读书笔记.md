---
title: Redis实战读书笔记
date: 2018-12-06 11:32:08
updated: 2018-12-06 11:32:08
tags:
- redis
- 数据库
- 读书笔记
---

## 相关文档

- [redis官网](https://redis.io/)
- [redis中文下载安装](http://www.redis.cn/download.html)
- [redis中文文档](http://www.redis.cn/documentation.html)

当你需要以接近实时的速度访问快速变动的数据流时，Redis这样的键值数据库就是你的最佳选择。

## 安装

下载、解压、编译Redis

```bash
wget http://download.redis.io/releases/redis-5.0.2.tar.gz
tar xzf redis-5.0.2.tar.gz
cd redis-5.0.2
make
```

提示错误

```bash
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
```

解决, 输入以下命令:

```bash
xcode-select --install
```

回车后，系统弹出下载xcode，点击确认，下载完成后即可。（实际上不是下载xcode，可能下载xcode有关插件，下载时长约1分钟）

> 在这里发生个有趣的现象，直接拷贝到终端里执行会报错无法识别参数，手动敲了一遍可以执行😶😳😳

## 启动

在redis安装目录下，进入src，执行`./redis-server`可以看到启动画面

另开一个终端，在同样目录下，执行`./redis-cli`, 连接成功。

## 客户端常用命令

| 命令           | 版本             |
|---------------|------------------|
|set key value  |设置 key 的值      |
|get key        |获取 key 的值      |
|exists key     |查看此 key 是否存在 |
|del key        |删除存储在给定键中的值|
|keys *         |查看所有的 key     |
|flushall       |消除所有的 key     |

Redis与其他软件的相同与不同

Redis是一个远程内存数据库，具有复制特性及未解决问题而升高的独一无二的数据模型。

Redis提供了5种不同类型的数据结构，各种问题都可映射到这些数据结构。

## redis简介

## redis是什么

Redis 是一个速度非常快的非关系数据库(non-relational database), 可以存储键(key)与5种不同类型的值之间的映射(mapping), 可以将存储在内存的键值对数据持久化到硬盘，还可以通过复制，持久化和客户端分片等特性，可以将redis扩展成一个能够包含数百GB数据、每秒处理上百万请求的系统。

## redis能做什么

## redis数据结构

5种结构
|结构类型|存储的值|读写能力|
|-------|-------|------|
|string(字符串)|可以是字符串、整数或浮点数|对整个字符串或者字符串的其中一部分执行操作；对整数和浮点数执行自增或自减操作|
|list(列表)  |一个链表，每个节点都包含一个字符串|从链表两端推入或弹出元素；根据偏移量对链表进行trim;读取单个或多个元素；根据值查找或移除元素|
|set(集合)   |包含字符串的无序收集器(unordered collection), 并且被包含的每个字符串都是独一无二、各不相同的|添加、获取、移除单个元素；检查一个元素是否存在；计算交集，并集，差集；从集合里随机获取元素|
|hash(散列)  |包含键值对的无序散列表|添加、获取移除单个键值对；获取所有键值对|
|zset(有序集合)|字符串成员(member)与浮点数分值(score)之间的有序映射，元素的排列书序有分值大小决定|添加、获取、移除单个元素；根据分值范围(range)或成员来获取元素|

## string

形如: `hello: world`

set, get, del 使用示例

```bash
set hello world
get hello
del hello
get hello
```

> 命令返回1表示成功执行， 0表示执行失败

## list 列表

一个列表结构可以有序的存储多个字符串，**列表可以包含相同的元素**
形如: `list-key: [item, item2, item]`

列表命令
|命令|行为|
|---|----|
|lpush  |将元素推入列表左端(left end)|
|rpush  |            ...右端(right end)|
|lpop   |从列表左端弹出元素|
|rpop   |从右端弹出元素  |
|lrange key start stop |获取列表给定范围所有值, 支持负索引, -1表示最右边第一个元素|
|llen key| 获取列表中元素的个数,时间复杂度为O(1)|
|lrem key count value| 删除列表中前count个值为value的元素,返回值是实际删除的个数|
|lindex |获取列表在给定位置的单个元素|
|lset key index value| 将索引为index的元素赋值为value|
|ltrim key start end| 删除指定索引范围之外的所有元素|
|linsert key BEFORE|AFTER pivot value| 从左往右查找值为pivot的元素，根据第二个参数是before还是after来决定将value插入到该元素前面还是后面|
|rpoplpush source destination| 将元素从一个列表转到另一个列表|

说明:

> count > 0, lrem从列表左边开始删除前count个值为value的元素
> count < 0, lrem从列表右边开始删除前count个值为value的元素
> count = 0, lrem删除所有值为value的元素
> ltrim和lpush一起使用来限制列表中元素的数量，比如记录日志只保留最近100条，每次加入元素时调用一次ltrim

```bash
lpush logs $newLogs
ltrim logs 0 99
```

```bash
lpush numbers 1
# 支持同时增加多个元素
lpush numbers 2 3
# 此时数据为[3, 2, 1]
rpush numbers 0 -1
# 此时数据为[3, 2, 1, 0, -1]

lpop numbers # 3

rpop numbers # -1

llen numbers # 3

lrange numbers 0 -1 # 获取所有元素

lrem
lindex list-key 1


```

想把列表当栈使用, 用 `lpush` 和 `lpop` 或 `rpush`和 `rpop`
想当队列使用, 用 `lpush` 和 `rpop` 或 `rpush` 和 `lpop`

## set 集合

集合通过散列表保证自己**存储的每个字符串是各不相同的**(这些散列表只有键，没有与键相关联的值)

集合与列表对比
|对比项|集合|散列|
|--|----|---|
|存储内容|至多2(32)-1个字符串|至多2(32)-1个字符串|
|有序性|否|是|
|唯一性|是|否|

集合使用无序(unordered)方式存储元素.
形如: `setkey: [item, item2, item3]`

集合类型在Redis内部是使用值为空的散列表(hash table)实现的

常用操作是加入或删除元素，判断某个元素是否存在等，时间复杂度都是O(1)

多个集合类型键之间还可以进行并集，交集和差集运算

集合命令
|命令|行为|
|---|----|
|sadd       |将给定元素添加到集合|
|smembers   |返回集合所有元素(慢，慎用)|
|sismember  |检查给定元素是否存在|
|srem       |如果给定元素存在，移除|

```bash
sadd setkey item
sadd setkey item2
sadd setkey item3
sadd setkey item // 失败
smembers setkey
sismember setkey item4
sismember setkey item
srem setkey item2
srem setkey item2

```

## hash 散列

散列可以存储多个键值对之间的映射，和字符串一样，既可以是字符串也可以是数字值，并且可以对散列存储的数字值执行自增自减操作。

散列很多当面像一个微缩版的redis，不少字符串命令都有相应的散列版本。

形如：`hashset: [{subkey1: value1},{subkey2: value2},{subkey3: value3},]`

散列命令
|命令|  行为|
|---|------|
|hset   |在散列里关联给定的键值对|
|hget   |获取给定散列键的值|
|hgetall|获取散列所有键值对|
|hdel   |如果键存在，移除|

```bash
hset hashkey subkey1 value1
hset hashkey subkey2 value2
hset hashkey subkey3 value3
hgetall hashkey
hdel hashkey subkey2
hdel hashkey subkey2
hdel hashkey subkey1
hgetall hashkey
```

## zset 有序集合

有序集合和散列一样，都用于存储键值对，有序集合的键值被称为成员(member)，每个成员都是各不相同的；
而有序集合的值被称为分值(score)，分值必须为浮点数。
有序集合是Redis里唯一一个既可以根据成员访问元素，又可以根据分值及分值的排序顺序来访问元素的结构

有序集合和列表类型区别

相同点:

1. 都是有序的
2. 都可以获得某一范围的元素

不同点:

1. 列表通过链表实现，获取靠近两端的数据速度极快，当元素增多，访问会变慢，所以更适合实现如'新鲜事'或'日志'这样很少访问中间元素的应用
2. 有序集合类型是使用散列表和跳跃表(Skip list)实现的，及时读取中间部分的数据速度也很快(时间复杂度O(log(N)))
3. 列表中不能简单的调整某个元素的位置，但有序集合可以(通过更改这个元素的分数)
4. 有序集合比列表类型更耗内存

### 有序集合命令

|命令|行为|
|---|----|
|zadd   |将带有给定分值的成员添加到有序集合里|
|zrange |根据元素在有序排列中所处的位置，从有序集合李获取多少个元素|
|zrangebyscore|获取有序集合在给定分值范围内的所有元素|
|zrem   |如果给定成员存在，移除|

```bash
zadd zsetkey 728 member1
zadd zsetkey 928 member0
zadd zsetkey 928 member0

zrange zsetkey 0 -1 withscores
zrangebyscore zsetkey 0 800 withscores

zrem zsetkey member1
zrem zsetkey member1

zrange zsetkey 0 -1 withscores
```
