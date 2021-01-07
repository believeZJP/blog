---
title: Java环境搭建
date: 2021-01-07 14:42:28
updated: 2021-01-07 14:42:28
tags:
---


## 添加java_home到.bash_profile文件

vi ~/.bash_profile

添加下面代码

```bin
 export JAVA_HOME=$(/usr/libexec/java_home)
 export PATH=$JAVA_HOME/bin:$PATH
 export CLASS_PATH=$JAVA_HOME/lib
```

配置生效$source ~/.bash_profile

配置maven环境变量

export M3_HOME=/usr/local/Cellar/maven/3.6.3_1/libexec
export PATH=$M3_HOME/bin:$PATH

在vscode中配置的    `"maven.executable.path": "/usr/local/Cellar/maven/3.6.3_1/libexec/bin/mvn",`

要包含到mvn才行

## idea中能查看代码每一行最后修改人的插件

`GitToolBox` 在MarketPlace中搜索

## 主题

`preferences -> plugins -> marketplace搜索one dark`

## Inteli Java 配置tomcat

默认Java环境和IDEA已经安好了

### 安装Tomcat

1. [官网](https://tomcat.apache.org/download-90.cgi)下载，Mac的话可以选择zip或者tar格式的，我这里下载的是tomcat9  

2. 下载完成后，建议将Tomcat移动到`/Library`目录下。进入到终端，输入如下命令

    `cd /Library/apache-tomcat-9.0.34/bin # apache-tomcat-9.0.34是我的目录名`

3. 授权bin目录下的所有操作：终端输入如下命令

    `sudo chmod 755 *.sh`

    回车之后会提示输入系统密码

4. 完成之后就可以打开Tomcat了

    `sudo sh ./startup.sh`

    可以在浏览器输入`http://localhost:8080/`

5. 关闭的话，可以输入如下命令：

    `sh ./shutdown.sh`

### IDEA配置Tomcat

1. 打开IDEA，通过菜单 run -> Edit Configurations进入到如下界面  

2. 依次点击`+`、`Tomcat Server`、`Local`，进入到如下界面  
    可以给新配置的环境起名，初次配置Application server应该无内容，可以点击然后选中Tomcat存放的目录，我这里为`/Library/apache-tomcat-9.0.34`

3. 这些弄好之后，下面会提示warning，可以进入到Deployment选中一个项目  
    选完项目后，一路ok下去。

4. 配置好Tomcat后，运行时，可能会报如下错误

    > Directory is invalid /usr/local/apache-tomcat-8.5.3/conf/Catalina

    原因是tomcat下Catalina目录没有权限导致，将其设置读写权限即可。命令如下：

    `cd /Library/apache-tomcat-9.0.34/conf/`

    `sudo chmod 777 Catalina`

5. 重启Tomcat，但又可能出现如下问题

    > conf/Catalina/localhost (权限不够)

    解决的话，进入到Library目录下，输入如下命令

    `cd /Library`

    `sudo chmod -R 755 apache-tomcat-9.0.34`

再重新启动Tomcat即可。
