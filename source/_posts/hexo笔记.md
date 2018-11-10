---
title: 搭建Hexo博客笔记
tags: hexo
---

# hexo 搭建
1. [HEXO官网](https://hexo.io/zh-cn/docs/)
2. [文档](https://hexo.io/zh-cn/docs/)

# 安装
1. node.js git 已经安装，跳过
2. hexo安装
```bash
npm install -g hexo-cli
```

运行
```bash
hexo init blog
cd blog
hexo server
```
访问localhost:4000即可看到网页

在sources/posts文件夹下新建一个test.md文件，再次访问页面，可看到新加的文章。

<!-- more -->

# 安装hexo-admin

```bash
npm install --save hexo-admin
hexo server -d
open http://localhost:4000/admin
```

# 安装next主题
1. 在根目录运行
```bash
 git clone https://github.com/theme-next/hexo-theme-next themes/next
```
会在themes目录下创建next文件夹

(需运行多次才能顺利下载)

2. 在根目录的_config.yml里配置themes: next

# 发布到github
需先安装插件
```bash
npm install hexo-deployer-git --save
```
在根目录_config.yml里配置deploy。
**根据github配置提示，branch只能是master，其他分支不生效(实测)。**
**repo 项目名一定要是用户名.github.io**
```json
deploy:
  type: git
  repo: git@github.com:believezjp/believezjp.github.io.git
  branch: master

```

配置完成运行
```
hexo clean
hexo d -g
```
发布出去。
访问believezjp.github.io，即可看到主页。

如果没有权限，需要将本地的id_rsa.pub里的key加到github的 SSH key 中
查看本地的key
```
less  ~/.ssh/id_rsa.pub
```
githubSSH keys地址[快捷地址](https://github.com/settings/ssh), 添加 SSH key 值

# 打赏设置
将二维码图片放到主题 source/images 下面
打开主题目录下面的配置文件_config.yml
这里的配置项可能每个主题不一样。
根据每个主题自己配置。
```
# 打赏文字提示
reward_comment: '扫码送礼, 走起~~~'
# 微信收款图片
wechatpay: /images/wechatpay.jpeg
# 支付宝收款图片
alipay: /images/alipay.jpeg
# 比特币收款
#bitcoin: /images/bitcoin.png
```


# 新建文章
```
hexo new "标题"
```

在 _posts 目录下会生成文件标题.md, 如下:
```
title: '标题'
date: 2018-11-04 10:17:16 #发表日期，一般不改动
categories: hexo #文章文类
tags: [hexo,github] #文章标签，多于一项时用这种格式
---

正文，使用Markdown语法书写
```
编辑完后保存，hexo server，浏览器输入 localhost:4000 预览


# 添加阅读全文隔断
默认文章列表页是全部展示, 只展示部分的话，可以在文章中加入
```

<!-- more -->

```
会自动隔断，添加阅读全文按钮。(注意, 是在文章列表页有阅读全文按钮)

# 展示摘要？？？

# 字数统计和阅读时长
1. 安装 hexo-wordcount
```
 npm install hexo-symbols-count-time --save
```
文件配置
在根目录的_config.yml中添加如下配置(注意格式一定要准确无误): 
```
symbols_count_time:
  symbols: true
  time: true
  total_symbols: true
  total_time: true
```
在next主题的配置文件中查看如下配置是否启用
```
symbols_count_time:
  separated_meta: true
  item_text_post: true
  item_text_total: false
  awl: 4
  wpm: 275
```
重启服务, 刷新页面, 可以看到效果。
这个只针对文章详情页才会展示。列表页不会展示。

# 修改footer内容
next主题默认会有由next强力驱动等文字。不喜欢可以去掉, 配置方法:
在目录themes/next/_config.yml中搜footer:, 将copyright 中的powered, 如下配置。即可去掉。
```
  copyright:
  powered:
    enable: false
    version: false

  theme:
    enable: false
    version: false
```
## 网站运行时间添加
根据目录themes/next/layout/_partials/footer.swig, 找到页脚配置文件。
在末尾添加
```javascript
<span id="timeDate">载入天数...</span><span id="times">载入时分秒...</span>
<script>
    var now = new Date(); 
    function createtime() { 
        var grt= new Date("02/14/2018 12:49:00");//此处修改你的建站时间或者网站上线时间 
        now.setTime(now.getTime()+250); 
        days = (now - grt ) / 1000 / 60 / 60 / 24; dnum = Math.floor(days); 
        hours = (now - grt ) / 1000 / 60 / 60 - (24 * dnum); hnum = Math.floor(hours); 
        if(String(hnum).length ==1 ){hnum = "0" + hnum;} minutes = (now - grt ) / 1000 /60 - (24 * 60 * dnum) - (60 * hnum); 
        mnum = Math.floor(minutes); if(String(mnum).length ==1 ){mnum = "0" + mnum;} 
        seconds = (now - grt ) / 1000 - (24 * 60 * 60 * dnum) - (60 * 60 * hnum) - (60 * mnum); 
        snum = Math.round(seconds); if(String(snum).length ==1 ){snum = "0" + snum;} 
        document.getElementById("timeDate").innerHTML = "本站已安全运行 "+dnum+" 天 "; 
        document.getElementById("times").innerHTML = hnum + " 小时 " + mnum + " 分 " + snum + " 秒"; 
    } 
setInterval("createtime()",250);
</script>


```


# leancloud 阅读统计功能
1. [注册leancloud](https://leancloud.cn/dashboard/login.html#/signup)
2. 登录后创建应用,点击设置-应用key, 查看app ID 和app Key
3. 在next/_config.yml中搜索`leancloud_visitors`配置ID 和Key
```
leancloud_visitors:
  enable: true
  app_id: #<app_id>
  app_key: #<app_key>
```
4. 创建 Class
  在左侧点击存储，创建一个名为Counter的 Class 文件，这里的名称一定为Counter 不能随意取！！！
  权限设置要选无限制, 否则在第二次访问会报错。
设置完后，回到我的博客，随便点击一篇博文，刷新几次 就可以在 leancloud–》存储–》Counter 看到我们的浏览记录了，在我们的博文副标题也可以看到浏览记录。

# hexo 新建目录，page, 标签, 分类, 关于
在主题的_config.yml中打开配置
```
menu:
  home: / || home
  about: /about/ || user
  tags: /tags/ || tags
  categories: /categories/ || th
  archives: /archives/ || archive
  #schedule: /schedule/ || calendar
  #sitemap: /sitemap.xml || sitemap
  
```
可以看到左上角新增关于, 标签, 分类
## 标签
运行hexo new page tags
访问标签页, 新页面可以正常访问
在source/tags/index.md中如下设置, 即可看到标签分类(前提:在文章中需添加tags)
```
---
title: tags
date: 2018-11-06 16:55:49
type: "tags"
layout: "tags"
---
```
## 分类
```
hexo new page categories
```
在source/categories/index.md中添加如下
```
---
title: categories
date: 2018-11-06 17:11:29
type: "categories"
layout: "categories"
---
```

文章中多个tag时，如下配置
```
tags: 
    - http
    - 网络
```
单个
```
tags: 网络
```


## 关于
```
hexo new page about
```
在source/about/index.md写个人信息


# 添加社交链接
在主题配置文件中搜索 social:
```
social:
  GitHub: https://github.com/believeZJP || github
  微博: https://weibo.com/u/6021664425 || weibo
  QQ: tencent://message/?uin=421790588&Site=www&Menu=yes || qq
```

图标配置：
```
social_icons:
  enable: true
  icons_only: true
  transition: false
  微博: weibo
  QQ: qq
```
在左侧即可看到链接。
需要注意, 图标的配置是根据font-awesome.min.css中的css属性样式, 想添加对应的可以在文件中搜索。

默认显示文字和图标, 如果只显示图标可设置
  icons_only: true

# 站内搜索
```
npm install hexo-generator-searchdb --save
```

在主题next/_config.yml中配置
```
local_search:
  enable: true
```
在全局配置中_config.yml添加
```
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```
-----------正常情况到这就可以使用搜索功能了---------

复盘:

点击首页搜索,发现弹框弹出, loading一直加载。没有显示搜索界面.
- 检查network, 发现search.xml请求成功, 状态200.
- 用链接直接访问search.xml localhost:4000/search.xml
提示报错, 有错误字符
- 可以拉到最后看哪篇文章被截断
- 也可以审查元素, 点击每个entry-content 查看最近为空的那个,找到后, 这篇文章中有错误字符不识别。
- 在network看search.xml中截断的文章中有两个字中间有个点的地方, 在文中找到这个地方光标移动发现会有一次没有移动, 删除即可。
- 实在找不到可以先剪切文章, 看是否能正常显示.


# 来必力评论

https://www.livere.com/一定要用这个注册, 中文版(http://www.laibili.com.cn/)失效！！！！
注册完成后, 填写相应信息, 即可获取到data-uid.
next/_config.yml中搜索`livere_uid`, 填入对应data-uid
**注意:**
格式如下:
livere_uid: fsdfs343==
一定不要加任何引号~~~~~~~(🕳🕳🕳🕳🕳)

# 本地图片添加

1. 在_config.yml中搜索`post_asset_folder`, 设为true
2. 在source文件夹下创建文件夹img
3. 在img中添加图片
4. 在md中引用图片
```
[记忆曲线](/img/clipboard.png)
<img src="/img/clipboard.png" >
```
注意: 这里一定要用绝对路径, 因为图片在根目录下

# 部署命令简化
在package.json中添加
```
"scripts": {
  "d": "hexo clean && hexo g -d",
  "s": "hexo clean && hexo g && hexo s"
},
```
部署时，只需在终端运行`npm run d`即可发布文章

启动时，运行`npm run s`,即可在本地访问服务

[好的链接](https://blog.csdn.net/qq_35561857/article/details/81590953)


# 百度统计
在next/_config.yml中搜索baidu_analytics, 配置id

在[官网](https://tongji.baidu.com/),新建应用，点击管理，复制id
```
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?60d1bc14f9ca17b7";
  var s = document.getElementsByTagName("script")[0]; 
```


# 添加头像
在next/config.yml里搜avatar,如下配置, 图片链接可更换
```
avatar:
  url: /images/avatar.gif
  rounded: true
  opacity: 1
  rotated: true
```


# 项目添加changelog❌
```
npm install --save conventional-changelog

conventional-changelog -p angular -i CHANGELOG.md -w -r 0
```



# hexo 命令
常用命令

```
hexo help #查看帮助
hexo init #初始化一个目录
hexo new "postName" #新建文章
hexo new page "pageName" #新建页面
hexo generate #生成网页，可以在 public 目录查看整个网站的文件
hexo server #本地预览，'Ctrl+C'关闭
hexo deploy #部署.deploy目录
hexo clean #清除缓存，**强烈建议每次执行命令前先清理缓存，每次部署前先删除 .deploy 文件夹**
```
简写
```
hexo n == hexo new
hexo g == hexo generate
hexo s == hexo server
hexo d == hexo deploy
```

# 参考文章
[Hexo进阶高级教程](http://tigerliu.site/2017/06/hexo-1/)