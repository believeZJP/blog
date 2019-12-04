---
title: Linux
date: 2019-03-22 20:31:07
updated: 2019-03-22 20:31:07
tags:
- Linux
- Nginx
---

参考:[链接](https://segmentfault.com/a/1190000011048277)

## 一、命令基本格式

<http://www.cnblogs.com/ShaYeBlog/p/5576601.html>

git 打tag

>命令 [选项][参数]

注意：
    1. 个别命令不遵循此格式
    2. 有多个选项，可以写在一起
    3. 简写：-a == -all, ll == ls -l

### 1.1 ls

* ls -a 显示所有文件，包括隐藏文件
* ls -l 显示详细信息
* ls -d 查看目录属性
* ls -h 人性化显示文件大小 ，K/M
* ls -i 显示inode

### 1.2 文件权限(10位)

>第一位是文件类型，后面每3位一组

-rw-r-r--

* -文件类型(-文件 d目录 l软链接)
* rw- u所有者
* r-- g所属组
* r-- o其他人
* r 读 w 写 x 执行

<!-- more -->

## 二、文件处理命令

linux中一切皆文件。目录为目录文件。普通文件用来保存数据，目录文件用来保存目录。

### 2.1 常用目录介绍及作用

1. / 根目录
2. /sbin ，/bin 命令保存目录
    >根目录下的bin和sbin，usr下的bin 和sbin都是用来保存系统命令。bin目录下的命令任何用户都可以执行，sbin下只有root才可以执行。Linux通过此方式区分用户权限

3. /boot 启动目录，启动相关文件
4. /dev 设备文件保存目录
5. /etc 配置文件保存目录
6. /home  普通用户的家目录
7. /lib 系统库保存目录
8. /mnt 系统挂载u盘、移动硬盘目录
9. /media 挂载光盘目录
10. /misc 外接磁带机挂载目录
11. /root 超级用户的家目录
12. /tmp 临时目录 可存放临时数据
13. /proc 直接写入内存的
14. /sys 同 /proc不能直接操作
15. /usr 系统软件资源目录
    * /usr/bin/ 系统命令 (普通用户)
    * /usr/sbin/ 系统命令 (超级用户)

### 2.2 目录处理文件命令

* mkdir -p [目录名]
    -p 递归创建
    make directories
    mkdir  src  
    mkdir  bin

* cd 切换所在目录

    change directory

 > 简化操作

    cd ~ 进入当前用户的家目录
    cd - 进入上次目录
    cd .. 进入上一级目录
    cd . 进入当前目录

* pwd 查看当前所在目录位置
    print working directory

### 2.3 文件处理命令

* rmdir [目录名] 删除空目录

    remove empty directory

* rm -rf [文件或目录] 删除文件或目录

    选项：

      -r 删除目录
      -f 强制

      rm [文件名] :提示是否删除
      rm -r [目录]: 删除目录需加-r，目录中含有子文件，将继续询问是否删除
      rm -rf [目录]: 删除目录，直接删除

      **自杀指令** rm -rf /

* cp [选项] [原文件或目录] [目标目录] 复制

    copy

        -r 复制目录
        -p 连带文件属性复制
        -d 若源文件是链接文件，则复制链接属性
        -a 相当于-pdr 目标文件和源文件属性相同
        被复制文件的时间为执行复制命令的时间，若要使被复制的文件与原文件属性完全一致，需加 -a

    ***
      eg:
      cp abc /tmp/ 若目标目录不加文件名，则原名复制
      cp abc /tmp/ana 目标文件加入文件名，改名复制
      cp -r ja/ /tmp/ 复制目录
      cp -a ja/ /tmp/ 完全复制，包含所有属性

* mv [原文件或目录] [目标目录] move

      eg:
      mv ja /tmp/ 剪切
      mv abc longls 原文件与目标目录在同一个目录，则为重命名

* date 查看当前系统时间

### 2.4 链接命令

* 格式化硬盘
??

* ln -s [源文件] [目标文件]    link

> 选项 -s 创建软链接

* 硬链接特征

    拥有相同i节点和存储block块，可以看做是同一个文件。

    硬链接与源文件拥有相同的i节点。

    删除原文件或硬链接文件的任何一文件，不影响文件索引操作？？？原文件删除了吗？

      1）可以通过i节点识别
      2）不能跨分区建立
      3）ln ./source/abc ./target/bcd.hard 创建后，引用计数+1
      1) ls -i ./souce/abc ./target/bcd.hard 可使用ls -i 来查看文件i节点

    不建议创建硬链接文件：

  * 文件过于隐蔽，除了i节点很难区分它是不是硬链接
  * 硬链接限制较多，不能跨分区，不能针对目录，使用中容易出现错误使用方法

* 软链接特征
    1) 类似于Windows的快捷方式
    2) 软链接拥有自己的i节点和block块，只保存原文件的文件名和节点号，并没有实际的文件数据。
    3) 软链接的权限都为777，但实际权限要看原文件权限。
    4) 修改任意文件，另一个都会改变。
    5) 删除原文件，软链接不能用
    6) 创建软链接，原文件一定要写绝对路径，否则软链接会到它所在的同一个目录去找原文件

[硬链接与软链接图](https://www.processon.com/view/link/59b296fae4b0d3fbea262c6c")

## 三、文件搜索命令

### 3.1 locate 文件名

    速度快，但只能按照文件名搜索，不能进行更复杂的搜索

### 3.2 whereis

    用于搜索命令所在的路径已经帮助文档所在的位置
    -b: 只查找可执行文件
    -m: 只查找帮助文件

### 3.3 which

    能看到命令的路径，如果有别名，还能看到别名的说明
    只能看到外部安装的命令，如pwd.

### 3.4 $PATH

    类似于Windows的环境变量，执行命令时，从path定义的目录中寻找
    echo $PATH

### 3.5 whoami

    显示当前用户

### 3.6 whatis

    查询一个命令执行什么功能，并将结果打印到终端上

### 3.7 find [搜索范围] [搜索条件]

>1. 默认完全匹配
>2. 避免大范围搜索，非常浪费资源，建议不在直接'/'目录下搜索

    find /root -iname test 不区分要搜索的test大小写格式
    find /root -user root 搜索root目录下所有属于root用户的文件
    find /root -nouser 没有所属者的文件。

    linux中每个文件都有所属者，如果没有，一般都是垃圾文件。
    但还是有特殊的，内核产生的文件，就没有所属者，一般在proc和sys目录下；
    还有外来文件，u盘拷入的文件也会忽略所有者

#### 模糊查询

    通配符有3种
    1. * 匹配任何字符
        find /home -name "*test*",显示所有名字带test的文件
        find /home -name "*", home目录下所有文件，包括隐藏文件
    2. ? 匹配任意一个字符
    3. [] 匹配任意一个中括号内的字符，
        find /home -name "test[12]" 显示test1 test2文件
        find /home -name "[12]*" 显示1或2开头的文件
        find /home -name "*[12]" 显示所有1或2结尾的文件

#### find 按文件时间搜索

    1. find /home -mtime +10 在home目录下，查找10天前修改的文件
    2. find /home -mtime 10                    10天前当天的文件
    3. find /home -mtime -10                   10天内修改的文件

    atime 文件访问时间  ctime 改变文件属性 mtime 修改文件内容

#### find 目录 -size 大小

    小写k和大写M
    find /etc -size +20k -a -size -50k  查找/etc/目录下大于20k并且小于50k的文件
    -a and 与，两个条件都满足
    -o or  或，两个条件满足一个即可

    find /etc -size +20k -a -size -50k -exec ls -lh {} \;
    查找/etc 目录下，大于20k且小于50k的文件，并显示详细信息
    -exec/ -ok 命令 {} \; 对搜索结果执行操作

    固定格式：-exec {} \\ ，表示直接对前面的搜索结果进行后面的命令处理。？？？

#### grep [选项] 字符串 文件名

    -i 忽略大小写
    -v 排除指定字符串

>find与grep的区别

    find: 在系统中搜索符合条件的文件名，如果需要匹配，使用通配符，为完全匹配
    grep: 在文件中搜索符合条件的字符串，如果需要匹配，使用正则表达式，为包含匹配

## 四、帮助命令

### 4.1 man 命令名称  manual

进入man命令操作，q退出；输入: / -d 搜索'-d'字符串；按n往下搜，shfit+n 网上搜

### 4.2 其他帮助命令

* 命令 --help

* info 命令
    ls --help

    -回车 进入带*号的命令
    -u 进入上层页面
    -n 进入下一个帮助小节
    -p 进入上一个帮助小节
    -q 退出

## 五、压缩与解压缩命令

>.zip .gz .bz2 .tar.gz .tar.bz2

### 5.1 zip

    ```bash
    zip 压缩文件名 源文件 # 压缩文件
    zip -r 压缩目录名 源目录 # 压缩目录

    unzip 压缩文件 # 解压缩文件
    ```

### 5.2 gz

    ```bash
        gzip 源文件 # 压缩为.gz格式的压缩文件，源文件会消失
        gzip -c 源文件>压缩文件 # 压缩为.gz格式，源文件会保留
        gzip -r 目录 # 压缩目录下所有的文件夹，但不能压缩目录

        gzip -d 压缩文件 # 解压缩文件
        gunzip 压缩文件 # 解压缩文件
    ```

### 5.3 bzip格式

bzip 不能压缩目录

    ```bash
        bzip2 源文件 # 压缩文件 源文件会消失
        bzip2 -k 源文件 # 压缩后 保留源文件

        bzip -d 压缩文件 # 解压bzip2文件
        bunbzip 压缩文件 # 解压文件
    ```

### 5.4 tar.gz tar.bz2

    ```bash
        tar -cvf 打包文件名 源文件 # 压缩为tar格式
        tar -zvcf 压缩包名.tar.gz 源文件 # 压缩为.tar.gz格式
        tar -jvcf 压缩包名.tar.bz2 源文件 # 压缩为.tar.bz2格式
        # -c 打包
        # -v 显示过程
        # -f 指定打包后的文件名

        tar -xvf 打包文件名 # 解压tar格式
        tar -zxvf 压缩包名.tar.gz # 解压.tar.gz格式
        tar -jxvf 压缩包名.tar.bz2 # 解压.tar.bz2格式
        # -x 解压包
        # -z 压缩为tar.gz格式
        # -j 压缩为.tar.bz2格式
    ```

>其他用法

    1. 指定解压位置
    tar -jxvf打包文件名 -C 绝对路径
    2. 同时压缩多个文件到指定路径
    tar -zcvf 绝对路径 （/tmp/） 打包文件名 源文件 源文件
    3. 查看压缩包内文件，不解压
    tar -ztvf 压缩包文件名

    ```bash
    tar –cvf jpg.tar *.jpg # 将目录里所有jpg文件打包成tar.jpg
    tar –czf jpg.tar.gz *.jpg # 将目录里所有jpg文件打包成jpg.tar后，并且将其用gzip压缩，生成一个gzip压缩过的包，命名为jpg.tar.gz
    tar –cjf jpg.tar.bz2 *.jpg # 将目录里所有jpg文件打包成jpg.tar后，并且将其用bzip2压缩，生成一个bzip2压缩过的包，命名为jpg.tar.bz2
    tar –cZf jpg.tar.Z *.jpg # 将目录里所有jpg文件打包成jpg.tar后，并且将其用compress压缩，生成一个umcompress压缩过的包，命名为jpg.tar.Z
    rar a jpg.rar *.jpg # rar格式的压缩，需要先下载rar for linux
    zip jpg.zip *.jpg # zip格式的压缩，需要先下载zip for linux
    ```

解压

    ```bash
    tar –xvf file.tar # 解压 tar包
    tar -xzvf file.tar.gz # 解压tar.gz
    tar -xjvf file.tar.bz2 # 解压 tar.bz2
    tar –xZvf file.tar.Z # 解压tar.Z
    unrar e file.rar # 解压rar
    unzip file.zip # 解压zip

    ```

## 六、关机和重启命令

### 6.1 关机和重启

> shutdown [选项] 时间

    时间后面加"&",表示将当前计划任务放置后台运行！若不放置，当前界面直到关机/重启都无法进行操作。
    这时，如果当前用户按下ctrl+c ，可以取消本次关机或重启的操作；
    而其他用户按下ctrl+c，不会取消关机或重启，但可以中断退出，继续其他操作。

#### 选项

    -h 关机
    -r 重启
    -c 取消上一个关机命令

#### 时间

     now //现在
     时: 分 // 后面的时间可以使用[+m]格式，表示多少分钟后执行。
     也可以用[hh:mm]格式，表示指定的时间执行，该时间是24小时制的

#### 举例

    shutdown -h 05:30 设定凌晨05:30关机
    shutdown -h now 立即关机
    shutdown -r 05:30 设定凌晨05:30重启
    shutdown -r now 立即重启
    shutdown -c 取消前一个关机或重启命令

### 6.2 系统运行级别

    runlevel 查看运行级别 前级别 当前级别
    logout 注销

    0    //关机
    1    //单用户(类似windows安全模式）
    2    //不完全多用户，不含NFS服务（字符界面，不包含文件共享服务）
    3    //完全多用户（字符界面）
    4    //未分配
    5    //图形界面
    6    //重启

## 七、挂载与卸载命令

### 7.1 挂载(可理解为分配盘符)

(1)查询与自动挂载

mount 查询系统中已挂载的设备
mount -a 依据配置文件/etc/fstab的内容，自动挂载

光盘 U盘 数据不建议写入自动挂载

(2) 挂载命令的格式
>mount [-t 文件系统] [-o 特殊选项][设备文件名][挂载点]

#### mount选项

-t 文件系统：加入文件系统类型来指定挂载的类型，ext3,ext4,光盘：iso9660等文件系统
-o 特殊选项：可以指定挂载的额外选项

## 7.2 挂载/卸载光盘 没用了吧

## 7.3 挂载U盘

先看U盘的设备名，然后再挂载

fdisk -l //查看系统中已经识别的硬盘

mount -t vfat /dev/sdb1 /mnt/usb/

注:

    vfat 指的是fat32文件系统，单个文件不超过4G
    Linux默认不支持NTFS文件系统，可以下载ntfs-3g软件安装

## 八、用户登录查看命令

### 8.1 w

    查看系统当前信息(负载和开机时间等信息) 当前已经登录的用户及用什么终端进入。

> load average: X.XX X.XX X.XX 表示系统在1分钟内 5分钟内 15分钟内 的平均负载(CPU内存)
> USER: 用户
> TTY:登录终端 pts/0 第一个远程终端
> LOGIN@: 登录时间
> IDLE: 用户闲置时间
> JCPU: 指的是和该终端连接的所有进程占用的时间。
> PCPU: 指当前进程所占用的时间
> WHAT: 当前正在运行的命令

### 8.2 who 与w类似，但信息有所简化

    会显示登录来源IP地址

### 8.3 last

    查看当前登录和过去登录的用户信息
    可以看到reboot时间，实际是查看/var/log/wtmp但必须用last命令才能看

### 8.4 lastlog

    查看所有用户最后一次登录时间
    /var/log/lastlog 不能直接看，也是用lastlog看

## 编辑器

* :w 报错
* :q 退出
* :! 强制保存
* :ls 列出所有文件
* :n 下一个
* :N 上一个
* :15跳转到指定行
* /xxx 从光标位置开始向后搜索 xxx 字符串
* ?xxx 从光标位置开始向前搜索
