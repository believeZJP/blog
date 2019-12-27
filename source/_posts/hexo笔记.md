---
title: 搭建Hexo博客笔记
date: 2018-10-10 18:05:59
updated: 2018-10-10 18:05:59
tags: hexo
---

[toc]

## hexo 搭建

1. [HEXO 官网](https://hexo.io/zh-cn/docs/)
2. [文档](https://hexo.io/zh-cn/docs/)

## 安装

1. node.js git 已经安装，跳过
2. hexo 安装

```bash
npm install -g hexo-cli
```

<!-- more  -->
```html

不能在文章中有{{}},否则hexo无法见解析，会报错
```

运行

```bash
hexo init blog
cd blog
hexo server
```

访问 localhost:4000 即可看到网页

在 sources/posts 文件夹下新建一个 test.md 文件，再次访问页面，可看到新加的文章。

<!-- more -->

## 安装 hexo-admin

```bash
npm install --save hexo-admin
hexo server -d
open http://localhost:4000/admin
```

## 安装 next 主题

1. 在根目录运行

    ```bash
    git clone https://github.com/theme-next/hexo-theme-next themes/next
    ```

    会在 themes 目录下创建 next 文件夹

    (需运行多次才能顺利下载)

2. 在根目录的\_config.yml 里配置 themes: next

## 发布到 github

需先安装插件

```bash
npm install hexo-deployer-git --save
```

在根目录\_config.yml 里配置 deploy。
**根据 github 配置提示，branch 只能是 master，其他分支不生效(实测)。**
**repo 项目名一定要是用户名.github.io**

```json
deploy:
  type: git
  repo: git@github.com:believezjp/believezjp.github.io.git
  branch: master

```

配置完成运行

```bash
hexo clean
hexo d -g
```

发布出去。
访问 believezjp.github.io，即可看到主页。

如果没有权限，需要将本地的 id_rsa.pub 里的 key 加到 github 的 SSH key 中
查看本地的 key

```bash
less  ~/.ssh/id_rsa.pub
```

githubSSH keys 地址[快捷地址](https://github.com/settings/ssh), 添加 SSH key 值

## 打赏设置

将二维码图片放到主题 source/images 下面
打开主题目录下面的配置文件\_config.yml
这里的配置项可能每个主题不一样。
根据每个主题自己配置。

```bash
## 打赏文字提示
reward_comment: '扫码送礼, 走起~~~'
## 微信收款图片
wechatpay: /images/wechatpay.jpeg
## 支付宝收款图片
alipay: /images/alipay.jpeg
## 比特币收款
#bitcoin: /images/bitcoin.png
```

## 新建文章

```bash
hexo new "标题"
```

在 \_posts 目录下会生成文件标题.md, 如下:

```md
title: '标题'
date: 2018-11-04 10:17:16 #发表日期，一般不改动
categories: hexo #文章文类
tags: [hexo,github] #文章标签，多于一项时用这种格式
---

正文，使用Markdown语法书写
```

编辑完后保存，hexo server，浏览器输入 localhost:4000 预览

## 添加阅读全文隔断

默认文章列表页是全部展示, 只展示部分的话，可以在文章中加入

```md

<!-- more -->

```

会自动隔断，添加阅读全文按钮。(注意, 是在文章列表页有阅读全文按钮)

## 展示摘要

## 字数统计和阅读时长

1. 安装 hexo-wordcount

```bash
 npm install hexo-symbols-count-time --save
```

文件配置
在根目录的\_config.yml 中添加如下配置(注意格式一定要准确无误):

```md
symbols_count_time:
  symbols: true
  time: true
  total_symbols: true
  total_time: true
```

在 next 主题的配置文件中查看如下配置是否启用

```md
symbols_count_time:
  separated_meta: true
  item_text_post: true
  item_text_total: false
  awl: 4
  wpm: 275
```

重启服务, 刷新页面, 可以看到效果。
这个只针对文章详情页才会展示。列表页不会展示。

## 展示总访问量

[不蒜子 - 极简网页计数器](http://busuanzi.ibruce.info/)

在 themes/next/layout/\_partials/footer.swig 中添加如下代码

```html
<script
  async
  src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"
></script>

<span id="busuanzi_container_site_pv"
  >本站总访问量<span id="busuanzi_value_site_pv"></span>次</span
>
```

即可在首页末尾看到总数，因为本地是 localhost:4000,所以数量有误

## 修改 footer 内容

next 主题默认会有由 next 强力驱动等文字。不喜欢可以去掉, 配置方法:
在目录 themes/next/\_config.yml 中搜 footer:, 将 copyright 中的 powered, 如下配置。即可去掉。

```yml
  copyright:
  powered:
    enable: false
    version: false

  theme:
    enable: false
    version: false
```

### 网站运行时间添加

根据目录 themes/next/layout/\_partials/footer.swig, 找到页脚配置文件。
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

## leancloud 阅读统计功能

1. [注册 leancloud](https://leancloud.cn/dashboard/login.html#/signup)
2. 登录后创建应用,点击设置-应用 key, 查看 app ID 和 app Key
3. 在 next/\_config.yml 中搜索`leancloud_visitors`配置 ID 和 Key

    ```yml
    leancloud_visitors:
      enable: true
      app_id: #<app_id>
      app_key: #<app_key>
    ```

4. 创建 Class
  在左侧点击存储，创建一个名为 Counter 的 Class 文件，这里的名称一定为 Counter 不能随意取！！！
  权限设置要选无限制, 否则在第二次访问会报错。
  设置完后，回到我的博客，随便点击一篇博文，刷新几次 就可以在 leancloud–》存储–》Counter 看到我们的浏览记录了，在我们的博文副标题也可以看到浏览记录。

## hexo 新建目录，page, 标签, 分类, 关于

在主题的\_config.yml 中打开配置

```yml
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

运行 hexo new page tags
访问标签页, 新页面可以正常访问
在 source/tags/index.md 中如下设置, 即可看到标签分类(前提:在文章中需添加 tags)

```md
---
title: tags
date: 2018-11-06 16:55:49
type: "tags"
layout: "tags"
---
```

## 分类

```bash
hexo new page categories
```

在 source/categories/index.md 中添加如下

```md
---
title: categories
date: 2018-11-06 17:11:29
type: "categories"
layout: "categories"
---
```

文章中多个 tag 时，如下配置

```md
tags:
    - http
    - 网络
```

单个

```md
tags: 网络
```

## 关于

```bash
hexo new page about
```

在 source/about/index.md 写个人信息

## 添加社交链接

在主题配置文件中搜索 social:

```yml
social:
  GitHub: https://github.com/believeZJP || github
  微博: https://weibo.com/u/6021664425 || weibo
  QQ: tencent://message/?uin=421790588&Site=www&Menu=yes || qq
```

图标配置：

```yml
social_icons:
  enable: true
  icons_only: true
  transition: false
  微博: weibo
  QQ: qq
```

在左侧即可看到链接。
需要注意, 图标的配置是根据 font-awesome.min.css 中的 css 属性样式, 想添加对应的可以在文件中搜索。

默认显示文字和图标, 如果只显示图标可设置
icons_only: true

## 站内搜索

```bash
npm install hexo-generator-searchdb --save
```

在主题 next/\_config.yml 中配置

```yml
local_search:
  enable: true
```

在全局配置中\_config.yml 添加

```yml
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

-----------正常情况到这就可以使用搜索功能了---------

复盘:

点击首页搜索,发现弹框弹出, loading 一直加载。没有显示搜索界面.

- 检查 network, 发现 search.xml 请求成功, 状态 200.
- 用链接直接访问 search.xml localhost:4000/search.xml
  提示报错, 有错误字符
- 可以拉到最后看哪篇文章被截断
- 也可以审查元素, 点击每个 entry-content 查看最近为空的那个,找到后, 这篇文章中有错误字符不识别。
- 在 network 看 search.xml 中截断的文章中有两个字中间有个点的地方, 在文中找到这个地方光标移动发现会有一次没有移动, 删除即可。
- 实在找不到可以先剪切文章, 看是否能正常显示.
- 用 vim 编辑器查看特殊字符一目了然
  常见的特殊字符`^H, .(灰色)`

## 来必力评论

<https://www.livere.com/一定要用这个注册,> 中文版(<http://www.laibili.com.cn/)失效！！！！>
注册完成后, 填写相应信息, 即可获取到 data-uid.
next/\_config.yml 中搜索`livere_uid`, 填入对应 data-uid
**注意:**
格式如下:
livere_uid: fsdfs343==
一定不要加任何引号~~~~~~~(🕳🕳🕳🕳🕳)

## 本地图片添加

1. 在\_config.yml 中搜索`post_asset_folder`, 设为 true
2. 在 source 文件夹下创建文件夹 img
3. 在 img 中添加图片
4. 在 md 中引用图片

```md
[记忆曲线](/img/clipboard.png)
<img src="/img/clipboard.png" >
```

注意: 这里一定要用绝对路径, 因为图片在根目录下

### 不用根目录的图片添加

用`hexo n '文章标题'`创建文章后，会生成与文章标题相同的文件夹，可以把图片放到对应文件夹中
在md中引用方式

```md
![添加自定义search](/posts/Alfred/addbaidu.png)
![设置百度内容](/posts/Alfred/addbaidu-input.png)
```

## 部署命令简化

在 package.json 中添加

```json
"scripts": {
  "d": "hexo clean && hexo g -d",
  "s": "hexo clean && hexo g && hexo s"
},
```

部署时，只需在终端运行`npm run d`即可发布文章

启动时，运行`npm run s`,即可在本地访问服务

[好的链接](https://blog.csdn.net/qq_35561857/article/details/81590953)

## 百度统计

在 next/\_config.yml 中搜索 baidu_analytics, 配置 id

在[官网](https://tongji.baidu.com/),新建应用，点击管理，复制 id

```html
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?60d1bc14f9ca17b7";
  var s = document.getElementsByTagName("script")[0];
```

## 添加头像

在 next/config.yml 里搜 avatar,如下配置, 图片链接可更换

```yml
avatar:
  url: /images/avatar.gif
  rounded: true
  opacity: 1
  rotated: true
```

## 添加缓存

[hexo-offline](https://www.npmjs.com/package/hexo-offline)

```bash
npm i hexo-offline --save
```

## 修改默认的文章链接

[官方文档](https://hexo.io/zh-cn/docs/permalinks.html)

默认文章链接是<http://localhost:4000/2018/10/18/hello-world/>

有年月日层级太深，不利于 SEO

修改为<http://localhost:4000/posts/hello-world/>

在\_config.yml 中搜索`permalink`,修改如下

```JavaScript
## permalink: :year/:month/:day/:title/
permalink: :category/:title/
```

搜索`default_category`,修改如下

```JavaScript
default_category: posts
```

重启服务即可

## 绑定自己域名

在阿里云控制台域名修改域名解析，记录类型 CNAME, 记录纸为 believezjp.github.io

在 hexo 项目下，source 文件夹下面创建 CNAME 文件（没有后缀名的），在里面写上购买的域名。

```cname
believezjp.oriht.com
```

注意，这个要写自己的域名，不是 github 的域名

在 github 上面，打开 username.github.io 项目的（Settings）设置，然后在 GitHub Pages 的 Custom domain 设置里填上购买的域名。

详见:[参考链接](https://blog.csdn.net/wgshun616/article/details/81019739)

## 替换 jquery 资源库地址

在主题目录下找到 after-footer.ejs 文件，PS：主题目录指的是 themes 下 next 目录

找到下面一段代码

```html
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
```

修改为：（将 jquery 的在线地址修改为百度的静态资源库地址）

```html
<script src="http://libs.baidu.com/jquery/2.1.1/jquery.min.js"></script>
```

## 项目添加 changelog❌

```bash
npm install --save conventional-changelog

conventional-changelog -p angular -i CHANGELOG.md -w -r 0
```

## 项目添加git commit 规范

[插件链接](https://github.com/marionebl/commitlint)

```bash
npm install --save-dev @commitlint/{cli,config-conventional}
echo "module.exports = {extends: ['@commitlint/config-conventional']};" > commitlint.config.js
npm install --save-dev husky

## 在package.json中配置
## package.json
{
  "husky": {
    "hooks": {
      "commit-msg": "commitlint -E HUSKY_GIT_PARAMS"
    }  
  }
}
```

提交方式：

格式：
> type(scope?): subject  ## scope 可选

subject是 commit 目的的简短描述，不超过50个字符，且结尾不加句号（.）

eg:

```js
chore: run tests on travis ci
fix(server): send cors headers
feat(blog): add comment section


```

- build: 主要目的是修改项目构建系统(例如 gulp，webpack，rollup 的配置等)的提交
- ci: 主要目的是修改项目继续集成流程(例如 Travis，Jenkins，GitLab CI，Circle等)的提交
- docs：文档（documentation）
- feat：新功能（feature）
- merge: 合并分支
- fix：修复bug
- perf: (performance) 优化相关，比如提升性能、体验
- refactor：重构（即不是新增功能，也不是修改bug的代码变动）
- revert: 回滚到上一个版本
- style： 格式（不影响代码运行的变动）
- test：增加测试
- wip：移除文件或者代码
- chore：不属于以上类型的其他类型

## 生成changelog

Change log 就可以用脚本自动生成。生成的文档包括以下三个部分：

- New features
- Bug fixes
- Breaking changes.

[onventional-changelog](https://github.com/conventional-changelog/conventional-changelog) 就是生成 Change log 的工具，运行下面的命令即可。
用到的是其中的[cli工具](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-cli)

```bash
npm install -g conventional-changelog-cli
conventional-changelog -p angular -i CHANGELOG.md -s -w -r 0
```

为了方便使用，可以将其写入 package.json 的 scripts 字段：

```json
{
    "scripts": {
        "changelog": "conventional-changelog -p angular -i CHANGELOG.md -s -w -r 0"
    }
}
```

以后，直接运行下面的命令即可：

```bash
npm run changelog
```

## 新建草稿

草稿相当于很多博客都有的“私密文章”功能。
`hexo new draft "new draft"`
会在source/_drafts目录下生成一个new-draft.md文件。但是这个文件不被显示在页面上，链接也访问不到。
也就是说如果你想把某一篇文章移除显示，又不舍得删除，可以把它移动到_drafts目录之中。
如果你希望强行预览草稿，更改配置文件_config.yml：
`render_drafts: true`
或者，如下方式启动server：
`hexo server --drafts`
下面这条命令可以把草稿变成文章，或者页面：
`hexo publish [layout] <filename>`
或`hexo P <filename>`
filename为不包含md后缀的文章名称。它的原理只是将文章从 source/_drafts 移动到 source/_posts 而已。

> 若日后想将正式文章转为为草稿，只需手动将文章从 source/_posts 目录移动到 source/_drafts 目录即可。

## hexo 命令

常用命令

```bash
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

```bash
hexo n == hexo new
hexo g == hexo generate
hexo s == hexo server
hexo d == hexo deploy
```

## Hexo博客收录百度和谷歌-基于Next主题

[参考链接](https://www.jianshu.com/p/8c0707ce5da4)

## 参考文章

[Hexo 进阶高级教程](http://tigerliu.site/2017/06/hexo-1/)
[Hexo+Github: 个人博客网站搭建完全教程](https://www.cnblogs.com/shwee/p/11421156.html)
