---
title: Linux学习
date: 2018-10-08 20:31:07
updated: 2019-03-22 20:31:07
tags:
- Linux
- Nginx
---
window远程连接工具：
secure CRT
配置：
选项-会话选项-仿真
    终端：x-term  ansi颜色
    外观：颜色方案：黄黑
        光标 竖线
    编码：回话选项-外观-字符编码-UTF-8

## git 定时任务crontab

[链接](https://www.cnblogs.com/peida/archive/2013/01/08/2850483.html)

## 在centos执行git pull报错

Peer reports incompatible or unsupported protocol version.

解决办法：

yum update -y nss curl libcurl

执行后，可以正常运行。

## ==++文件与目录管理++==

### 新建文件夹

mkdir

eg:mkdir test

mkdir -p test/123/abc

-p 递归创建目录，即使上级目录不存在。
还有一种情况就是如果你想要创建的目录存在的话，会提示报错，然后你加上-p参数后，就不会报错了。

### 命令详情

 man rm,
 man ls

### 复制文件

cp

eg: cp a b

cp copy的简写，即拷贝。格式为 cp [选项] [ 来源文件 ] [目的文件] ，例如我想把test1 拷贝成test2 ，这样即可 cp test1 test2，

-d 这里涉及到一个“连接”的概念。连接分为软连接和硬连接

如果不加这个-d 则拷贝软连接时会把软连接的目标文件拷贝过去，而加上后，其实只是拷贝了一个连接文件（即快捷方式）。

- -r 如果你要拷贝一个目录，必须要加-r选项，否则你是拷贝不了目录的。 omitting directory ‘d’

- -i 如果遇到一个存在的文件，会问是否覆盖。

- -u 该选项仅当目标文件存在时才会生效，如果源文件比目标文件新才会拷贝，否则不做任何动作

### 移动文件

mv 移动的意思，是move的简写。格式为 mv [ 选项 ] [源文件] [目标文件]。

- -i 和cp的-i 一样，当目标文件存在时会问用户是否要覆盖。

- -u 和上边cp 命令的-u选项一个作用，当目标文件存在时才会生效，如果源文件比目标文件新才会移动，否则不做任何动作。

-

windows下的重命名，在linux下用mv就可以搞定。

### 删除文件夹

 rm -rf

 eg:rm -rf testCLI

rmdir 只能删除目录但不能删除文件，要想删除一个文件，则要用rm命令了。

-f 强制的意思，如果不加这个选项，当删除一个不存在的文件时会报错。

-i 这个选项的作用是，当用户删除一个文件时会提示用户是否真的删除。

-r 当删除目录时，加该选项，如果不加这个选项会报错。rm是可以删除不为空的目录的。

### 新建文件

touch a

> a.txt 可以创建一个文件
> a也是一个文件
vi a

vi a /vim a 可以查看文件内容

输入i，进入编辑模式

按esc，退出编辑模式

输入:wq退出查看文件

## **进入linux的主目录**

cd /home

pwd 这个命令打印出当前所在目录
./ 指的是当前目录

../ 指的是当前目录的上一级目录。
cd wwwroot/
ls

> 绝对路径：路径的写法一定由根目录”/”写起，例如/usr/local/mysql 这就是绝对路径。

相对路径：路径的写法不是由根目录”/”写起，例如，首先用户进入到/ 然后再进入到 home ，命令为 cd /home 然后 cd test 此时用户所在的路径为 /home/test 。第一个cd命令后跟 /home 第二个 cd 命令后跟 test ，并没有斜杠，这个test是相对于/home 目录来讲的，所以叫做相对路径。

## 输出

echo 变量
echo 'abc'>111 将字符输出到一个文件中
大于号”>” 在linux中这叫做重定向，即把前面产生的输出写入到后面的文件中。
”>>”是追加的意思，而用”>”，如果文件中有内容则会删除文件中内容，而”>>”则不会。

## 查看文件

- cat 比较常用的一个命令，即查看一个文件的内容并显示在屏幕上
    -n 查看文件时，把行号也显示到屏幕上。
    -A 显示所有东西出来，包括特殊字符

- tac 其实是cat的反写，同样的功能也是反向打印文件的内容到屏幕上。

- more也是用来查看一个文件的内容。当文件内容太多，一屏幕不能占下，而你用cat肯定是看不前面的内容的，那么使用more就可以解决这个问题了。当看完一屏后按**空格键**继续看下一屏。但看完所有内容后就会退出。如果你想提前退出，只需按q键即可。

- less作用跟more一样，但比more好在可以上翻，下翻。空格键同样可以翻页，而**按”j”键可以向下移动**（按一下就向下移动一行）**，按”k”键向上移动**。在使用more和less查看某个文件时，你可以按一下”/” 键，然后输入一个word回车，这样就可以查找这个word了。如果是多个该word可以按”n”键显示下一个。另外你也可以不按”/”而是按”?”后边同样跟word来搜索这个word，唯一不同的是，**”/”是在当前行向下搜索，而”?”是在当前行向上搜索**。

    **按n向上，按N向下显示**--老罗

- vim

- head head后直接跟文件名，则显示文件的前十行。如果加 –n 选项则显示文件前n行。
- tail 和head一样，后面直接跟文件名，则显示文件最后十行。如果加-n 选项则显示文件最后n行。

- -f **动态显示文件的最后十行**，如果文件是不断增加的，则用-f 选项。如：tail -f /var/log/messages

-

### 实时查看文件内容

- tail -f catalina.out  ！！！！！！！！

## 文件的所属主以及所属组

所属组”就派上用场了。即，创建一个群组users，让user0和user1同属于users组，然后建立一个文件test2，且其所属组为users，那么user0和user1都可以访问test2文件。

## 查看文件列表list

ls
ls -l
-a 全部的档案都列出，包括隐藏的。

-l 详细列出文件的属性信息，包括大小、创建日期、所属主所属组等等。ll 这个命令等同于ls –l 。

-d 后边跟目录，如果不加这个选项则列出目录下的文件，加上后只列车目录本身。

## linux 文件属性

用ls –l 查看当前目录下的文件时，共显示了9列内容（用空格划分列），都代表了什么含义呢？

第1列，包含的东西有该文件类型和所属主、所属组以及其他用户对该文件的权限。第一列共10位。其中第一位用来描述该文件的类型。上例中，我们看到的类型有”d”, “-“ ，其实除了这两种外还有”l”, “b”, “c”,”s”等。

d 表示该文件为目录；

- 表示该文件为普通文件；

l 表示该文件为连接文件（linux file），上边提到的软连接即为该类型；

b 表示该文件为块设备文件，比如磁盘分区

c 表示该文件为串行端口设备，例如键盘、鼠标。

s 表示该文件为套接字文件（socket），用于进程间通信。

后边的9位，每三个为一组。均为rwx 三个参数的组合。其中r 代表可读，w代表可写，x代表可执行。前三位为所属主（user）的权限，中间三位为所属组（group）的权限，最后三位为其他非本群组（others）的权限。下面拿一个具体的例子来述说一下。

一个文件的属性为-rwxr-xr-- ，它代表的意思是，该文件为普通文件，文件拥有者可读可写可执行，文件所属组对其可读不可写可执行，其他用户对其只可读。

对于一个目录来讲，打开这个目录即为执行这个目录，所以任何一个目录必须要有x权限才能打开并查看该目录。例如一个目录的属性为 drwxr--r-- 其所属主为root，那么除了root外的其他用户是不能打开这个目录的。

第2列，表示为连接占用的节点（inode），若为目录时，通常与该目录地下还有多少目录有关系，关于连接（link）在以后章节详细介绍。

第3列，表示该文件的所属主。

第4列，表示该文件的所属组。

第5列，表示该文件的大小。

第6列、第7列和第8列为该文件的创建日期或者最近的修改日期，分别为月份日期以及时间。

第9列，文件名。如果前面有一个. 则表示该文件为隐藏文件。

## 更改文件的权限

==？？？太多了？？？以后再学==

## 在 linux 下搜索一个文件

- which 用来查找可执行文件的绝对路径

    which只能用来查找PATH环境变量中出现的路径下的可执行文件。不知道某个命令的绝对路径，which一下就知道了。

- whereis 通过预先生成的一个文件列表库去查找跟给出的文件名相关的文件。

    语法： whereis [-bmsu] [文件名称]

    -b：只找binary 文件

    -m：只找在说明文件manual路径下的文件

    -s：只找source来源文件

    -u：没有说明档的文件
- locate 类似于whereis，也是通过查找预先生成的文件列表库来告诉用户要查找的文件在哪里。后边直接跟文件名。

- **find** 用的最多，务必要熟悉。
    语法： find [路径] [参数] 下面介绍几个笔者经常用的参数

    -atime +n ：访问或执行时间大于n天的文件

    -ctime +n ：写入、更改inode属性（例如更改所有者、权限或者连接）时间大于n天的文件

    -mtime +n ：写入时间大于n天的文件

    -name filename **直接查找该文件名的文件，这个使用最多了。**

    -type type ：通过文件类型查找。type 包含了 f, b, c, d, l, s 等等。后续的内容还会介绍文件类型的。

你对这三个time是不是有些晕了，那笔者就先给你介绍一下这三个time属性。

文件的 Access time，atime 是在读取文件或者执行文件时更改的。文件的 Modified time，mtime 是在写入文件时随文件内容的更改而更改的。
文件的 Create time，ctime 是在写入文件、更改所有者、权限或链接设置时随 Inode 的内容更改而更改的。
因此，更改文件的内容即会更改 mtime 和 ctime，但是文件的 ctime 可能会在 mtime 未发生任何变化时更改，例如，更改了文件的权限，但是文件内容没有变化。 如何获得一个文件的atime mtime 以及ctime ？

ls -l 命令可用来列出文件的 atime、ctime 和 mtime。

ls -lc filename         列出文件的 ctime

ls -lu filename         列出文件的 atime

ls -l filename          列出文件的 mtime

atime不一定在访问文件之后被修改，因为：
使用ext3文件系统的时候，如果在mount的时候使用了noatime参数那么就不会更新atime的信息。而这是加了 noatime 取消了, 不代表真实情況。
反正, 這三個 time stamp 都放在 inode 中。若 mtime, atime 修改inode 就一定會改, 既然 inode 改了, 那 ctime 也就跟著要改了。

## linux 文件类型

1）正规文件（regular file）：就是一般类型的文件，当用ls –l 查看某个目录时，第一个属性为”-“的文件就是正规文件，或者叫普通文件。正规文件又可分成纯文字文件（ascii）和二进制文件（binary）。纯文本文件是可以通过cat, more, less等工具直接查看内容的，而二进制文件并不能。例如我们用的命令/bin/ls 这就是一个二进制文件。

2）目录（directory）即文件夹,ls –l 查看第一个属性为”d”。

3）连接档（link）：ls –l 查看第一个属性为 “l”，类似windows下的快捷方式。

4）设备档（device）：与系统周边相关的一些档案，通常都集中在 /dev 这个目录之下！通常又分为两种：
    区块 (block) 设备档：说就是硬盘啦！例如你的一号硬盘的代码是 /dev/hda1 等等的档案啦！第一个属性为 “ b “；
    字符 (character) 设备档：亦即是一些串行端口的接口设备，例如键盘、鼠标等等！第一个属性为 “ c “。

### linux 文件后缀名

1.sh代表它是一个shell script
2.tar.gz 代表它是一个压缩包，
3.my.cnf 代表它是一个配置文件，
4.test.zip 代表它是一个压缩文件。
早期Unix系统文件名最多允许14个字符，而新的Unix或者linux系统中，文件名最长可以到达 256 个字符！

## 压缩 解压缩

tar

  解包：tar zxvf filename.tar
  
  打包：tar czvf filename.tar dirname

zip命令

解压：unzip filename.zip

压缩：zip filename.zip dirname

## ln 建立连接档

ln 语法： ln [-s] [来源文件] [目的文件]
ln 常用的选项就一个-s ，如果不加就是建立硬连接，加上就建立软连接。

Hard Link 的限制太多了，包括无法做目录的 link ，所以在用途上面是比较受限的！反而是 Symbolic Link 的使用方向较广！
在建立硬连接前后，空间大小不改变。
不能创建目录的硬连接。
目录是可以软连接的。
删除软连接对源文件没有任何影响。

## 环境变量 PATH

有两个方法。

一种方法是直接将 /root 的路径加入 PATH 当中！如何增加？可以使用： 　

PATH=”$PATH”:/root

另一种方式则是使用完整档名，亦即直接使用相对或绝对路径来执行，例如：

/root/ls

./ls

====

### vim查看版本

vim

#### 设置vim编码

vim ~/.vimrc

## vim

### vim 编辑

 按i ,进入编辑模式，

 编辑完成后，按esc退出编辑模式

#### 退出保存

 :wq

#### 退出不保存

 :q
会提示: No write since last change (add ! to override)  
再输入一次

:q!
即可

将以下复制到其中

syntax on
set nu!
set encoding=utf-8
set fenc=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb2312,gb18030

#### 查看系统的编码

echo $LANG

## 乱码解决方案

1. 系统编码
2. vim的编码
3. 连接服务器的终端。
   1. SecureCRT设置字条编码
Option--Session Option--Appearance
  设置字符编码

## 命令行远程登录服务器

ssh root@192.168.1.25
    用户名@ip

## 服务器上安装公钥

键入以下命令，在服务器上安装公钥：

[root@host ~]$ cd .ssh

[root@host .ssh]$ cat id_rsa.pub >> authorized_keys

将本地的key复制到authorized_keys文件中

### 从gitbash中获ssh key

  clip < ~/.ssh/id_rsa.pub
  
 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDOmNk1rDPVPv+DTpe/ynM9dLDj/FjG/3xkAvjz8EoxSM/QBXNLj69m0SXA4jI6LOIwuS3Pdn011qWGa14zHPDI0wY9cGzlC+AvcuAZ0s+ndppAVk5PktYM0zCfBhlpLyHCgCVNxDxv1shd1A+gG3Lbi+tJ75oOnvJ5uSWC6x6wJgwJy/zUdQHTA3od4Mfkbz/6hr1sWqnCJE3r4H9Na6XtYMbjyl+O+JnePxH4PDwT/0MVxPpojyEqAv/FE9Gb7WjqmLsT5TWEoRhb4V0pm75moh6QObgqQ+RfJLS6Cz+NIvep980qVrYaRQGQG+7bEwy3fNDZlSGXRUALgELceVP/ HP@HP-PC

## 查看版本号

 uname -r

## 查看系统

uname

## 查看当前正在进行的进程

 jobs

## 启一个服务，在后台执行，并将日志输出到log

 node . >log 2>&1 &

 tail -f log

## 查找某个进程(eg:node)

 ps -ef|grep node

## 在历史命令中查找某个命令

 history|grep cd

## 写了脚本以后执行一个脚本

./control.sh

## linux 查找文件

find / -name nginx.conf

find / -name php.ini

find / -name my.cnf

find / -name httpd.conf

## php 相关

 查看php运行目录命令：
which php

which 用来查找一个命令的绝对路径

/usr/bin/php
查看php-fpm进程数：

ps aux | grep -c php-fpm

查看运行内存
/usr/bin/php  -i|grep mem

关闭PHP

killall php-fpm

php重启

/usr/local/php/sbin/php-fpm &

## php 配置

1. 端口 httpd.conf listen 80

2.

## 查看linux IP

### 公网IP

curl members.3322.org/dyndns/getip

47.94.93.83

### 内网IP

ifconfig

inet addr:192.168.42.128

## NGINX

启动：/usr/local/nginx/sbin/nginx

service nginx start
关闭：/usr/local/nginx/sbin/nginx  -s stop

service nginx stop

重启：/usr/local/nginx/sbin/nginx -s  reload

查看nginx状态
 service nginx status

查看当前nginx目录
ps -ef | grep nginx
可以在conf目录下的nginx.conf中找到对应的配置。

查看一个服务是否已经启动：

ps -A | grep nginx

如果返回结果的话，说明有nginx在运行，服务已经启动

nginx -V 查看nginx安装目录

cd /usr/local/etc/nginx 里有nginx.conf

sudo nginx -s reload
Sudo nginx -s stop

openresty/nginx/coupon

./sbin/nginx -s reload

Nginx 命令
service nginx stop/start/status/reload

2、查看nginx.conf配置文件目录

输入命令

### nginx -t

返回结果包含配置文件目录
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok

nginx: configuration file /etc/nginx/nginx.conf test is successful

检查下80端口是否被其他进程占用了。
lsof -i:80

### Nginx 配置实现CORS

```conf
location ^~ /api/v1 {

 add_header 'Access-Control-Allow-Origin' "$http_origin";
 add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS';
 add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type    ';
 add_header 'Access-Control-Allow-Credentials' 'true';
 if ($request_method = 'OPTIONS') {
  add_header 'Access-Control-Allow-Origin' "$http_origin";
  add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS';
  add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type    ';
  add_header 'Access-Control-Allow-Credentials' 'true';
  add_header 'Access-Control-Max-Age' 1728000; # 20 天
  add_header 'Content-Type' 'text/html charset=UTF-8';
  add_header 'Content-Length' 0;
  return 200;
 }
    # 这下面是要被代理的后端服务器，它们就不需要修改代码来支持跨域了
 proxy_pass http://127.0.0.1:8085;
 proxy_set_header Host $host;
 proxy_redirect off;
 proxy_set_header X-Real-IP $remote_addr;
 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
 proxy_connect_timeout 60;
 proxy_read_timeout 60;
 proxy_send_timeout 60;

}
```

## telnet 80 d端口ping不通

```bash
curl <http://127.0.0.1>
curl http:oriht.com
```

查看实例安全组规则  端口范围是否有80端口

允许自定义 TCP

```conf
80/80 地址段访问
0.0.0.0/0
-

1 2017-09-25 11:03:54
---
```

如果新配置nginx一直403 禁止访问的话

修改/etc/selinux/config
将SELINUX=enforcing 改为
SELINUX=disabled

## 跟着吴博学linux

ls -lh

sudo sh updata_www.sh

less update_www.sh

ls -l

sudo su root

git branch -r

## !/bin/bash

rm www-old
mv ./www ./www-old
ln -s ./ac-www-releases/ac-www-2016-10-17/ www
sh git.pull.sh

exit

sudo sh update_www.sh

---

## 找不到httpd.conf

httpd.conf的位置一般位于
/etc/httpd/conf/httpd.conf

如果没
执行命令
yum install httpd
重新安装一下，

## 根据nginx配置，查找文件目录

原本nginx配置好后，目录应该在

```conf
root /data/www/hosts;
```

但如果有

```conf
location ^~ / {
    proxy_buffering off;
    proxy_pass http://127.0.0.1:3001/;
    proxy_set_header Host $host;
}
```

则应根据3001端口来找具体进程对应的进程

执行 如下命令找到对应进程的pid

```bash
sudo netstat -nplt | grep 3001
```

根据pid来找到目录，执行以下命令

```bash
ps -aux | grep 37098
```

出现如下结果，则为对应的目录

```bash
501      37098  0.0  0.2 1209696 42828 ?       Ssl  Aug08   8:37 node /home/nodeProjects/express/dist/index.js
```

## 跟着立斌学命令行

dash
zsh
/oh-my-zsh
oh-my-zsh

sh -c "$(curl -fsSL <https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)">
需要提前装zsh，
 yum install zsh

## 切换到zsh

chsh -s /usr/local/bin/zsh

修改主题，目录
/root/.oh-my-zsh/templates/zshrc.zsh-template

zsh-autosuggestions

安装方法：
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

看一下自己目前使用的终端是什么：

echo $SHELL

查看当前主题

echo $ZSH_THEME

我用的主题
robbyrussell

 主题修改文件路径:sudo vim ~/.zshrc

## linux 用命令启动服务不掉线

创建control.sh
  运行./control.sh

```bash
  #!/bin/bash
  
  nohup npm start ./ 1>>log 2>&1 &

```
  
---
cat access.log | cut -d' ' -f7 | sort | uniq -c | sort -nr | head -n30

---
