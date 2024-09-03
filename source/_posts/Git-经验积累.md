---
title: Git 经验积累
date: 2018-12-03 14:58:57
updated: 2018-12-03 14:58:57
tags:
- Git
- SmartGit
- GitKraken
---

## git status不显示中文

配置 Git 设置
确保 Git 的输出也使用 UTF-8 编码。

```bash
git config --global i18n.commitencoding utf-8
git config --global i18n.logoutputencoding utf-8
git config --global core.quotepath false
```

## git命令学习网站

[Learn Git Branching](https://learngitbranching.js.org/?locale=zh_CN)

## 客户端推荐

- [SmartGit](https://www.syntevo.com/smartgit/)✨✨✨(开始用的，后来放弃)
- [Sourcetree](https://www.sourcetreeapp.com/)✨✨✨✨✨(现在用的这个，需要翻墙注册)
- [GitKraken](https://www.gitkraken.com/) 很好用，可以替代SourceTree, 全平台免费(也开始收费了)

<!-- more -->

## git 快捷键

```js
bdgp() {
 if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
 git push origin head:refs/for/"${*}"
 else
 [[ "$#" == 0 ]] && local b="$(git_current_branch)"
 git push origin head:refs/for/"${b:=$1}"
 fi
}



```

## github contributions 展示问题

正常情况下会将每天的提交记录展示到图表中。
有天突然发现之前好多提交记录没展示，查看原因发现是提交账号和github的账号不一致的原因导致的。

GitHub默认只有账号绑定的邮箱提交的commits才会展示.

解决办法:

- 将公司邮箱加到GitHub账户下--[链接](https://github.com/settings/emails)

- 将当前项目的提交设置为个人邮箱

    ```bash
    git config user.email "email@example.com"
    ```

## centos安装git

### 安装

yum install -y git

### 检查版本

git --version

### 生成公钥并复制到服务器上

### 生成公钥

ssh-keygen -t rsa

### 查看公钥

cat ~/.ssh/id_rsa.pub

mac中直接复制到剪贴板

pbcopy < ~/.ssh/id_rsa.pub

### 复制id_rsa.pub里的公钥到服务器上的authorized_keys文件

拷贝，复制到github.com的settings的SSH and GPG keys中

## 安装nodejs

参考：<https://nodejs.org/>

## 卸载

yum remove nodejs -y

## 正确方法

1.确保系统下 g++ 版本在 4.6 以上，python 版本在 2.6 以上。

2.从 nodejs.org 下载 tar.gz 后缀的 NodeJS 最新版源代码包并解压到某个位置。

`wget https://nodejs.org/dist/v4.5.0/node-v4.5.0.tar.gz`

3.进入解压到的目录，使用以下命令编译和安装。

```bash
tar -zvxf node-v4.5.0.tar.gz
./configure
make
sudo make install
```

## git提交commit后，想撤回重新commit

`git reset --soft HEAD^`

这样就成功的撤销了你的commit
注意，仅仅是撤回commit操作，您写的代码仍然保留。

`--hard`
会删除本地修改代码，回到上次commit状态

查看分支 `git branch -a` (可以查看所有分支)
创建分支 `git branch name`
切换分支 `git checkout name`
创建并切换 `git checkout -b name`
合并某分支到当前分支 `git merge name` 用于合并指定分支到当前分支
删除分支 `git branch -d name`

注，合并分支时，加上--no-ff参数就可以用普通模式合并，合并后的历史有分支记录，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。
9.团队多人开发协作

1).查看远程仓库分支
查看远程仓库的信息 git remote命令可以查看远程仓库，加-v选项可以查看详细信息。

2).分支推送

首先，可以试图用git push origin branch-name推送自己的修改如果推送失败，则因为远程分支比你的本地更新，需要先用git pull试图合并如果合并有冲突，则解决冲突，并在本地提交没有冲突或者解决掉冲突后，再用git push origin branch-name推送就能成功如果git pull提示“no tracking information”，则说明本地分支和远程分支的链接关系没有创建，用命令git branch --set-upstream branch-name origin/branch-name。

git 创建tag
用 -a （译注：取 annotated 的首字母）
git tag -a v0.1 -m 'sidebar is ok'

git tag :  查看tag列表
git show v1.4 ： 查看tag的具体信息

git tag -l ‘v0.1.*’ # 搜索符合模式的Tag

给指定的commit打Tag
 git tag -a v1.2 9fceb02

切换到Tag
与切换分支命令相同，用git checkout [tagname]
删除Tag
误打或需要修改Tag时，需要先将Tag删除，再打新Tag。
$ git tag -d v0.1.2 # 删除Tag

分享标签
Tag推送到服务器
 git push origin v1.5

一次推送所有本地新增的标签上去，可以使用 --tags 选项：
git push origin --tags

注意：如果想看之前某个Tag状态下的文件，可以这样操作
1.git tag 查看当前分支下的Tag
2.git checkout v0.21 此时会指向打v0.21 Tag时的代码状态，（但现在处于一个空的分支上）

git pull origin master

/**修改提交用到的命令***/
git push origin gitcafe-pages  //提交到远端的服务器上
git commit -m 'gitabc first commit'   //在本地创建一个版本
git add -A
/**修改提交用到的命令***/
git add -A

添加多个文件及文件夹

进入某个文件夹路径：
cd D:/gitCafe     即可进入D:\gitCafe
cd believeZJP     即可进入 D:\gitCafe\believeZJP

git log常用命令以及技巧
1.git log
如果不带任何参数，它会列出所有历史记录，最近的排在最上方，显示提交对象的哈希值，作者、提交日期、和提交说明。如果记录过多，则按Page Up、Page Down、↓、↑来控制显示；按q退出历史记录列表。

当git出现

> Please enter a commit message to explain why this merge is necessary
 especially if it merges an updated upstream into a topic branch
 Lines starting with '#' will be ignored, and an empty message aborts
 the commit
~
".git/MERGE_MSG" 7L, 293C
这个画面时：

type i to insert a comment then press esc and type :wq

vi编辑模式：
进入：
vi test.txt
从插入模式切换为命令行模式

　　按「ESC」键。
按esc退出编辑模式
退出vi及保存文件

别忘了wq前面的:
:w   保存文件但不退出vi
:w file 将修改另外保存到file中，不退出vi
:w!   强制保存，不推出vi
:wq  保存文件并退出vi
:wq! 强制保存文件，并退出vi
q:  不保存文件，退出vi
:q! 不保存文件，强制退出vi
:e! 放弃所有修改，从上次保存文件开始再编辑
cat test.txt   //查看文件内容

配置SSH KEYS
步骤严格按照<https://help.github.com/articles/generating-ssh-keys/> 是可以成功的。

转 push本地代码到github出错
刚创建的github版本库，在push代码时出错：

$ git push -u origin master

解决办法：
    2.push前先将远程repository修改pull下来

```bash
    git pull origin master

    git push -u origin master
```

添加公钥:
    应将id_rsa.pub中的内容拷贝到文本框中，而不是id_rsa中的！！！！！！！！！！！！！！

git 合并：
    1.先git pull 将远程的文件更新过来
    2.有冲突的，会在文件中有

这样的提示，解决冲突，
    3.git add ，然后再commit
    4.git push origin master

git add -A
git commit -m 'dd'
git push origin master

github 提交时，多次要求输入用户名密码的解决方法

git生成ssh key
    ssh-keygen.exe
    vim ~/.ssh/id_rsa.pub
将ssh key 复制到添加页面

git diff 以后，按q 退出
git 强制覆盖本地某个文件
git checkout  -- file

git切换分支：
    git checkout 分支名称
git 只添加文件夹，
   用git status 是不会检测到添加的文件夹，(多级文件夹也无法检测到)
    只有文件夹中有文件，才会检测到，

### 给本次存储加个备注，以防时间久了忘了

`git stash save "存储"`

git stash 经验，
当遇到本地已经commit后，发现忘记了git pull 时，此时，git pull会提示：you have unstaged changes.
可以先git stash ，将本地的状态存起来，
然后就可以git pull,
再从本地恢复之前的状态，
git stash pop

git stash list   可以查看本地有哪些状态，
git stash pop stash@{0}    可以将原先保存的状态还原。
直接git stash pop 也可以。
此时再git commit -m ""，git push
就可以正常提交了。
回退到某个版本
 sudo git reset --hard 3943d5c74a08a8f6ad113e63ed191ecb4f48b053
git强制覆盖本地所有修改：
git fetch --all  
git reset --hard origin/master

error: cannot lock ref 'refs/remotes/origin/master': unable to resolve reference refs/remotes/origin/master: Invalid argument
发生原因：
git push origin master 写成了git push origin/master

解决办法：
rm .git/refs/remotes/origin/master
git fetch

修复bug的流程
说明：从生产环境的分支上修改，再逐渐改到测试环境，dev环境
操作步骤：
    1.在主分支master拉一个分支branch1出来，修改，
    2.将branch1合并到master,并提交，git push
    3.切换到test分支，git merge branch1,并提交，git push
    4.切换到dev分支，git merge branch1 并提交，git push
    5.登录到每个环境的服务器中，分别git pull，即可看到更改的结果。

-----

让某个分支和另外一个分支一样的话，直接将另一个分支merge过来。

 Read-Search-Ask methodology

git pull的时候遇到这样的问题：
The following untracked working tree files would be overwritten by merge balabala...
解决办法：
git clean -d -fx
备注：会删除掉没有add到仓库的文件，操作记得慎重，以免改动文件的丢失。本质上就是操作仓库中没有被追踪的本地文件
$ git clean -f -n         # 1
$ git clean -f            # 2
$ git clean -fd           # 3
$ git clean -fX           # 4
$ git clean -fx           # 5
(1): 选项-n将显示执行（2）时将会移除哪些文件。
(2): 该命令会移除所有命令（1）中显示的文件。
(3): 如果你还想移除文件件，请使用选项-d。
(4): 如果你只想移除已被忽略的文件，请使用选项-X。
(5): 如果你想移除已被忽略和未被忽略的文件，请使用选项-x。

mkdir learngit
cd learngit
pwd
git init
git add readme.txt
git commit -m "wrote a readme file"
git status
 git diff readme.txt //查看文件的区别
git log  历史记录
git log --pretty=oneline   一行显示
 git reset --hard HEAD^   回退上一个版本
上上一个版本就是HEAD^^   写成HEAD~100  上100个版本
git reset --hard 3628164  指定回到未来的某个版本。版本号没必要写全，前几位就可以了，Git会自动去找
gitreflog   记录每一次命令
git diff //查看修改的内容
git diff HEAD -- readme.txt命令可以查看工作区和版本库里面最新版本的区别
git checkout -- readme.txt    丢弃工作区的修改

命令git checkout -- readme.txt意思就是，把readme.txt文件在工作区的修改全部撤销，这里有两种情况：
    一种是readme.txt自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
    一种是readme.txt已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。
    总之，就是让这个文件回到最近一次git commit或git add时的状态。
--很重要，没有--，就变成了“切换到另一个分支”的命令，
git checkout其实是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”。
git reset HEAD readme.txt   可以把暂存区的修改撤销掉（unstage），重新放回工作区：
    小结：
        场景1：当你改乱了工作区某个文件的内容，想直接丢弃工作区的修改时，用命令git checkout -- file。
        场景2：当你不但改乱了工作区某个文件的内容，还添加到了暂存区时，想丢弃修改，分两步，第一步用命令git rese            t HEAD file，就回到了场景1，第二步按场景1操作。
        场景3：已经提交了不合适的修改到版本库时，想要撤销本次提交，参考版本回退，不过前提是没有推送到远程库                    。
-----删除文件----
rm test.txt   直接在文件管理器中把没用的文件删了，或者用rm命令删了：---相当于从文件管理器删除
 git rm test.txt   从版本库中删除该文件，那就用命令git rm删掉，并且git commit：
git commit -m "remove test.txt"
            文件就从版本库中被删除了。
-----------远程关联------------
git remote add origin git@server-name:path/repo-name.git；
      eg:  $ git remote add origin <git@github.com>:michaelliao/learngit.git
git push -u origin master第一次推送master分支的所有内容；
每次本地提交后，只要有必要，就可以使用命令git push origin master推送最新修改；
git remote -v   看有没有权限推送

------------用命令克隆一个远程库----------------
git clone <git@github.com>:michaelliao/gitskills.git      用命令git clone克隆一个本地库：
<git@github.com>/believeZJP/believeZJP.github.io.git

<https://gitcafe.com/believeZJP/believeZJP.git>

git 只克隆一个分支
 `git clone -b <branch> <remote_repo>`
 eg:      git clone -b gitcafe-pages  <git@gitcafe.com>:believeZJP/believeZJP.git

--------------切换分支-------------
git checkout -b dev   checkout命令加上-b参数表示创建并切换，相当于以下两条命令：
git branch dev
git checkout dev
git branch   查看当前分支：会列出所有分支，当前分支前面会标一个*号
git checkout master         切换回master分支：
 git merge dev                把dev分支的工作成果合并到master分支上
git branch -d dev            删除dev分支了
git branch -D feature-vulcan  强行删除分支

小结
Git鼓励大量使用分支：
查看分支：git branch     //  git branch -a
创建分支：git branch <name>
切换分支：git checkout <name>
创建+切换分支：git checkout -b <name>
合并某分支到当前分支：git merge <name>
删除分支：git branch -d <name>

 git log --graph --pretty=oneline --abbrev-commit   分支的合并情况：

git merge --no-ff -m "merge with no-ff" dev        请注意--no-ff参数，表示禁用Fast forward：
因为本次合并要创建一个新的commit，所以加上-m参数，把commit描述写进去。
合并分支时，加上--no-ff参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而fast forward合并就看不出来曾经做过合并。

--------------从远程获取文件-------------------
将修改的文件推送到远程
git push origin master
git push origin dev

---------Bug分支-----------------
git stash            把当前工作现场“储藏”起来，等以后恢复现场后继续工作：
git stash list        查看工作现场

Git把stash内容存在某个地方，需要恢复，有两个办法：
一是用git stash apply恢复，但是恢复后，stash内容并不删除，你需要用git stash drop来删除；
另一种方式是用git stash pop，恢复的同时把stash内容也删了：

可以多次stash，恢复的时候，先用git stash list查看，然后恢复指定的stash，用命令：
$ git stash apply stash@{0}
修复bug时，我们会通过创建新的bug分支进行修复，然后合并，最后删除；
当手头工作没有完成时，先把工作现场git stash一下，然后去修复bug，修复后，再git stash pop，回到工作现场。

-----------------多人协作--------------------
小结
查看远程库信息，使用git remote -v；
本地新建的分支如果不推送到远程，对其他人就是不可见的；
从本地推送分支，使用git push origin branch-name，如果推送失败，先用git pull抓取远程的新提交；
在本地创建和远程分支对应的分支，使用git checkout -b branch-name origin/branch-name，本地和远程分支的名称最好一致；
建立本地分支和远程分支的关联，使用git branch --set-upstream branch-name origin/branch-name；
从远程抓取分支，使用git pull，如果有冲突，要先处理冲突。

---------------创建标签---------------
git tag v1.0                默认标签是打在最新提交的commit上
git tag                    查看所有标签
git tag v0.96224937         打标签到某一个commit上
 git show v0.9                查看标签信息
git tag -a v0.1 -m "version 0.1 released"3628164        创建带有说明的标签，用-a指定标签名，-m指定说明文字
git tag -s <tagname> -m "blablabla..."可以用PGP签名标签；
git tag -d v0.1               删除标签
git push origin v1.0            推送某个标签到远程
 git push origin --tags            一次性推送全部尚未推送到远程的本地标签
git push origin :refs/tags/v0.9
签已经推送到远程，要删除远程标签就麻烦一点，先从本地删除：从远程删除。删除命令也是push，但是格式如下：
git push origin :refs/tags/v0.9
// To <git@github.com>:michaelliao/learngit.git   不知道有没有这个

小结
命令git push origin <tagname>可以推送一个本地标签；
命令git push origin --tags可以推送全部未推送过的本地标签；
命令git tag -d <tagname>可以删除一个本地标签；
命令git push origin :refs/tags/<tagname>可以删除一个远程标签。

----------使用GitHub---------------------
小结
在GitHub上，可以任意Fork开源仓库；
自己拥有Fork后的仓库的读写权限；
可以推送pull request给官方仓库来贡献代码。

------------------自定义Git------------------------
git config --global color.ui true                让Git显示颜色，会让命令输出看起来更醒目
------------------配置别名-----------------------------

git config --global alias.st status
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.br branch
以后st就表示status    co表示checkout，ci表示commit，br表示branch

--global参数是全局参数，也就是这些命令在这台电脑的所有Git仓库下都有用

git config --global alias.unstage 'reset HEAD'
        当你敲入命令：$ git unstage test.py   实际上Git执行的是：   $ git reset HEAD test.py
git config --global alias.last 'log -1'        让其显示最后一次提交信息

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git lg

配置文件放哪了？每个仓库的Git配置文件都放在.git/config文件中：
别名就在[alias]后面，要删除别名，直接把对应的行删掉即可。
当前用户的Git配置文件放在用户主目录下的一个隐藏文件.gitconfig中：

…or create a new repository on the command line
echo "# node-server" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin <https://github.com/believeZJP/node-server.git>
git push -u origin master

…or push an existing repository from the command line
git remote add origin <https://github.com/believeZJP/node-server.git>
git push -u origin master

git远程有分支，本地没有，解决办法
git fetch 命令会更新 remote 索引。

git fetch origin

## git存储

### git分区

git存储分成四个部分

- workspace：工作空间（我们的开发代码目录）
- index： 暂存区，.git目录下的index文件
- Repository：本地仓库，通过git clone将远程的代码下载到本地；代码库的元数据信息在根目录下的.git目录下
- Remote：远程仓库（比如GitHub就是一个远程仓库）

整个过程就是：

1. 工作区--git add--暂存区--git commit--本地仓库-- git push--远程仓库

2. 远程仓库区–-fetch–-使用refs\remotes下对应分支文件记录远程分支末端commit_id 和 本地仓库区 --merge–-工作区
3. 远程仓库区–-pull–-使用refs\remotes下对应分支文件记录远程分支末端commit_id and 本地仓库区 and 工作区

### git fetch和git pull的区别

git fetch: 是将远程主机的最新内容拉到本地，用户在检查了以后决定是否合并到工作本机分支中。具体操作如下:

```bash
git  fetch origin master:temp
//本地新建一个temp分支，并将远程origin仓库的master分支代码下载到本地temp分支
git diff temp
//比较远程代码与本地代码的区别
git merge temp
//将temp分支合并到本地master分支
git branch -d temp
//如果不想保留分支，可以将其删除
```

git pull: 基于本地的FETCH_HEAD记录，比对本地的FETCH_HEAD与远程仓库的版本号，然后git fetch获得当前的远程分支的后续版本的数据，然后利用git merge将其与本地的分支合并，可以认为是git pull是git fetch和git merge两个步骤的合并。
实际的git pull过程可以理解为：

```bash
git fetch origin master  //将远端的master分支拉取最新内容
git merge FETCH_HEAD //将拉取的最新内容与当前分支合并
```

 git pull用法：

```bash
git pull <远程主机名>  <远程分支名>:<本地分支名>`
// 将远程主机的某个分支，与本地的指定分支合并
```

 git pull合并后可能会出现冲突，需要手动解决冲突。
出现的错误提示如下

> error: Your local changes to the following files would be overwritten by merge:
Please commit your changes or stash them before you merge.
// 更新的代码与本地的修改代码有冲突，先提交你的改变或者先将本地修改暂存起来

解决冲突的方式：先将本地的代码暂存

```bash
git stash //先将本地修改暂存起来
git stash list  //查看保存信息
git pull     //拉取内容
git stash pop   //还原暂存的内容
```

## git status

1. Changes to be committed：代表被add的文件，被加载到了暂存区
2. Changes not staged for commit：代表在当前分支中被修改的文件，还没有被add，存储在工作区

### git内部存储

本地git项目里面的.git目录下的文件如下：

1. refs：存储git各种引用的目录，包含分支、远程分支和标签
2. objects：是存储git各种对象及备用的对象库，包含正常的压缩和压缩后的
3. info：存储git信息的目录，比如判处特定后缀的文件
4. index：暂存区
5. hooks：存储git钩子的目录，钩子只在特定事件发生时触的脚本，比如：提交之前，提交之后
6. description：项目描述
7. config：代码库几倍的配置文件
8. ORIG_HEAD：针对某些 危险操作 ，Git通过记录HEAD指针的上次所在的位置 ORIG_HEAD提供了回退的功能。当你发现某些操作失误了，比如错误的reset到了一个很早很早的版本，可以使用 git reset --hard ORIG_HEAD回退到上一次reset之前。
9. HEAD：代码库当前分支的指向
10. FETCH_HEAD： 是一个版本链接，记录在本地的一个文件中，指向着目前已经从远程仓库取下来的分支的末端版本。
11. COMMIT_EDITMSG：commit编辑

git 常用插件

1. [commitizen](https://github.com/commitizen/cz-cli) 规范commit message

`git show`
在当前分支，运行`git show <其他分支名>` k可以查看当前分支与其他分支的diff

`git diff master f_tmp`

可以查看master和f_tmp分支的区别

## github无法访问解决办法

`Failed to connect to github.com port 443: Operation timed out`

`LibreSSL SSL_connect: SSL_ERR`

### 地址失效

查询可以用的IP

在 <http://ping.chinaz.com/github.com> 查询对应的耗时情况。

修改 hosts 文件
hosts 文件路径：`sudo vim /etc/hosts`
找一个最快的IP添加到hosts文件中, 如下：

```hosts
13.250.177.223  github.com
```

即可正常访问

## 用github520可以自动更新ip，更加方便，推荐

[github520](https://github.com/521xueweihan/GitHub520)

## git命令行配置不用账号密码登录，改用token登录

[创建token的方法](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)

创建好token后，在命令行执行git push操作时，会要求输入账号和密码，注意这里的密码是刚才生成的token

如果没有提示输入账号的时候，在mac的keychains里删除github.com相关的密码，再次操作即可。
