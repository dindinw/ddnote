像写代码一样写公号
==============

> 作为一个情(tuo)怀(yan)党(zheng)和有(qiang)态(po)度(zheng)的程序汪，如何能像写代码一样撰写公众号文章，可以使用自己最熟悉的IDE（例如IDEA）或者文本编辑器（例如vi）和版本管理工具（诸如git）。可以迅速修改，可提交，发布。不用花太多精力去排版，却又不妥协版面的优雅与美感，注意力集中于创造内容，不用花太多精力在重复的劳动上？

本文以本汪的使用经验出发，主要讨论下面这些问题：

* 如何使用Git对公号文章进行版本管理，并利用github.com存储版本。
* 如何利用Markdown语言来简化排版
* 如何使用MarkdownHere插件来快速编辑与发布文章
* 如何利用微信公众平台API进行自动化管理

0x0 前方高能预警
----------------

对于一个懒散的初期强迫症病患汪来说，写微信公众号实在是一件极为挑战本汪心理极限的事情。不能进行版本控制，不能用自己喜欢的编辑器，调整版式排版工作烦心而容易出错。

顺便说一句，微信自身编辑器的简陋带动了大量第三方编辑器和平台的出现，如XiuMI（秀米）和爱排版（ipanban）等网站，这样网站通常提供丰富的界面模版资源，来方便公众号的编辑进行文章排版，大量的公号其实都是通过第三方编辑平台进行维护的。

但作为一个程序员来说，这些平台不能带来do_it_yourself的掌控感，和getUHandsDirty()的装逼感，所以他们自动被忽略了。如果读者大大只是为了维护公号，看到这里就不用读下去了。毕竟本文的重点是如何像写代码一样写公号，像写代码一样写公号，像写代码一样写公号。重要的事情说三遍。

因为答应过我妹这篇文章她也读得懂，所以本汪尽量将步骤详尽到如何打开Terminal窗口。话说作为一个编程零基础的金融妹纸，突然跟本汪说要学编程，极大地满足了我汪乐于助人（aimuxurong）和热爱分享（xihuanzhuangbi）的程序员精神。

下面是本程序汪脑海里面理想的工作方式（本汪YY中，妹妹请直接忽略）：

-  版本通过Git进行管理
-  使用vi和IDEA进行文本编辑，使用Markdown语言对文章进行排版。
-  根据不同的情景，支持下面三种不同玩法：
    -  通过使用MarkdownHere插件，通过公号官网维护平台进行发布，此为手工模式。
    -  通过编写脚本来调用微信公号API进行发布，此为自动模式。
    -  通过与github进行深度集成，支持pull request进行团队协作编辑。commit可以设置为自动触发到微信公众号的预览功能，即推送修改后的内容到公号维护者的手机进行预览。而通过release来正式发布内容到微信公号，并触发公号群发。此为持续集成模式。


0x1 使用GIT进行版本管理
--------------------

>Q：啥叫版本管理？

>A：简单来讲代码就是钱，版本就是账本。版本管理就是账本管理。木有账本，汪只知道自己现穷，为啥穷的不清楚。（维基百科：记录模块的改动历程，并为每次改动编上序号。软件设计师常会利用版本来追踪、维护源码、文件以及配置文件等等的改动。）

>Q：啥是Git

>A：猿世界中最赛雷的记账工具，厚厚。 （维基：Git is a widely used source code management system for software development. It is a distributed revision control system with an emphasis on speed, data integrity, and support for distributed, non-linear workflows. ）

Mac 自备，点右上角Spotlight｜搜索terminal｜点击打开terminal。

>除非特别说明，所有的命令都在terminal（即终端或曰命令行）中输入。

>更多Git介绍详见Git系列文章。

1. 检查版本

    ```
    $ git --version
    git version 1.9.5 (Apple Git-50.3)
    ```

2. 新建一个目录，名曰learngit, （#号是注释不需要输入。啥是注释？，就是转账备注）

    ```
    $ mkdir learngit
    ```

3.  进入learngit目录

    ```
    $ cd learngit
    ```

4.  初始化git

    ```
    $ git init
    Initialized empty Git repository in /Users/alex/Dev/github.com/dindinw/learngit/.git/
    ```

5.  创建文本文件Hello.md, 内容为一行文字: “Hello，World!”
    ```
    $ echo 'Hello World!'> Hello.md 
    $ cat Hello.md 
    Hello World!
    ```
    
6.  将改动提交到Git 

    ```
    $ git add Hello.md
    $ git commit -m 'first line'
    ```

0x10 Markdown语法简介
-------------------

>Q: 煞是马可挡？

>A: 马可挡就是一种猿与非猿都能直接读懂的写字格式。 维基：Markdown是一种轻量级标记语言，允许人们使用易读易写的纯文本格式编写文档，然后转换成有效的XHTML(或者HTML)文档。

>Q: 为啥要用Markdown？

>A: 因为文艺猿与技术猿都只爱排版的结果，而恨排版的过程。

举个栗子：下面是一个简单的Markdown加粗和列表的写法，以及排版后的效果

```
**过节**的姿势

1. 碎碎吃吃吃 
2. 吃吃吃碎碎
3. 碎碎碎碎吃
```

**过节**的姿势

1. 碎碎吃吃吃 
2. 吃吃吃碎碎
3. 碎碎碎碎吃

附赠一个简单的Markdown写法指南，更详尽的用法参考附录链接。

![MarkDown](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbYyHOVGicGibuZbE6oSrnricQOX4S6aNSYCgrekDoax56LichZKOvqkOsgaw7L6maut8ePtGhKq3f2wjg/0?wx_fmt=png)


0x11 MarkdownHere工具的使用
-------------------------

![MarkdownHereLogo](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbYyHOVGicGibuZbE6oSrnricQOah49KfgL01tt39C2BJ60BrtjgUNI90znsNAbv9QTVlzTnEv0Zo39Mw/0?wx_fmt=png)

MarkdownHere是一款开源浏览器以及邮件客户端插件：功能是可以将一段基于Markdown标签的文字，直接替换成HTML格式。 它支持基本上所有浏览器（IE除外），如Chrome,Firefox,Safari,Opera以及Chromium和Thunderfire等邮件客户端。 

### 安装

用你的浏览器访问下面链接选择对应浏览器安装皆可。

> http://markdown-here.com/get.html

![MarkdownInstall](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbZVFzH9t9ic8bia5YaWf8AbNfAswyd5zeh1aib1YMwPatQg7wDZQ7oQ69ePWLlWRSRnNsUhpIaNtzh5A/0?wx_fmt=png)

### 使用

> 当安装好插件后，在浏览器的任意编辑界面中，使用基于Markdown文本，可以使用热键 `Option` + `Command` + `M` 转换成Html文本。而且再使用一次相同的热键可以又转换为Markdown文本。

下面是使用时候的效果

![MarkdownHereAnimation](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbZVFzH9t9ic8bia5YaWf8AbNfkhhpN1wIibAYjrgL3qbctUaW1oW2Pou9GBRgBtC2o8pcTR5TSetUqKA/0?wx_fmt=gif)

0x100 定制MarkdownHere优化显示效果
------------------------------

### 解决语法高亮

强制插入换行符（解决微信官方网站Bug）

![ForceLineBreak](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbYyHOVGicGibuZbE6oSrnricQO14u4IHLeVIIp9gibibfxHKjU1lnXBoAKia9J0lCD3S1tD5l3kfJicK9crg/0?wx_fmt=png)

**使用前**

![BeforeUse](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbYyHOVGicGibuZbE6oSrnricQO6wrdxU2bl6Z4icCyJBYRtEWWVlYkib7MA3NIrpy7r9ZfoUM24eoZ2vIQ/0?wx_fmt=png)

**使用后**

![AfterUse](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbYyHOVGicGibuZbE6oSrnricQOp62jR33jLpyI7WUoaBibcakicR2ybtriaS5KiamkhqYTOWBl2ND8qb380Q/0?wx_fmt=png)


### 美化MarkDownHere的默认字体大小和行距

```css
.markdown-here-wrapper[data-md-url*="mp.weixin."] {
    font-size: 14px;
    line-height: 1.75;
}
```

0x101 使用微信API
----------------

如何利用微信API同步到微信公众号平台。微信公号平台本身是不能直接接驳到github的，那就只能看看微信平台给我们提供了那些API可以利用。打开微信公号平台，左下脚有个开发者工具的链接，打开链接你会发现开发手册，API文档，开发与测试工具等等。

### 木有权限 

阅读API文件发现，公号的文章在微信中被称为“图文素材”，而公号平台通过“素材资料库”API进行管理。貌似不错，让我们测试一下微信相关素材资料库API，从最简单的开始，取素材库的个数是最简单的。

```bash
# get ACCESS_TOKEN
$ my_app_id="da_si_bu_neng_gao_su_ni"
$ my_secret="da_si_bu_neng_gao_su_ni"
$ get_access_token="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=$app_id&secret=$app_secret"
$ access_token=`curl -s $get_access_token | sed -e 's/[{}]//g' | awk -F : '{print $2}' | cut -d , -f 1 | sed -e 's/"//g'`

# ACCESS_TOKEN太长我就不show给大家了 *_*
$ get_material_count=https://api.weixin.qq.com/cgi-bin/material/get_materialcount?access_token=$access_token
$ curl $get_material_count
{"errcode":48001,"errmsg":"api unauthorized hint: [nczsEa0612e292]"}
# too naive! 同学, 非微信认证客户（没交300块の用户）不能访问该API
```

理想很丰满，现实很骨感。实测发现非微信认证的普通用户是没有相关的权限的。上面的例子只是一个针对素材个数统计的简单调用。显然此路不通。

### 柳暗花明 

又仔细观察了一下“开发者工具”，发现了自己看漏了这个东东：“公众平台测试帐号”。下面的醒目的写着，无需申请公众号就可以体验并测试所有高级功能。


参考链接
------
* 微信API
    * [微信公众平台官方开发文档](http://mp.weixin.qq.com/wiki/home/index.html)
* Markdown语法
    * GitHub's [Mastering Markdown · GitHub Guides](https://guides.github.com/features/mastering-markdown/)
    * Daring Fireball's ["Markdown Syntax."](https://daringfireball.net/projects/markdown/syntax)
* Markdown Here!插件
    * http://markdown-here.com/
    * https://github.com/adam-p/markdown-here/wiki
* Git
    * [Pro Git Book Second Edition](https://git-scm.com/book/en/v2/)
    * [Atlassian’s Git tutorials](https://www.atlassian.com/git/tutorials/)
