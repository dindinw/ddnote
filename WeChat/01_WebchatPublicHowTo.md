闹心的微信公众号文章管理
===================

本文实测如何利用GitHub和MarkDown插件维护微信公众号文章

思路
---

对于一个初期强迫症患者，不能对微信公众号文章进行版本管理是在是一件很郁闷的事情。理想的方式自然是：版本通过Git进行管理, 使用Markdown标签对文章进行排版，并能把内容发布到微信公众号平台。更理想的是情况自然是：版本的改动能自动触发一个到微信公 公众号的预发布，例如公号的维护者手机自动被推送预览的内容。而通过release管理来进行真正发布。更有甚者，还可以通过pull request 来进行协作文章编辑。

问题在于如何同步到微信公众号平台。微信公号平台本身是不能直接接驳到github的，那就只能看看微信平台给我们提供了那些API可以利用。打开微信公号平台，

### 木有权限 

貌似不错，让我们测试一下微信相关素材资料库API，从最简单的开始，取素材库的个数是最简单的。

~~~bash

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
~~~

理想很丰满，现实很骨感。实测发现非微信认证的普通用户是没有相关的权限的。上面的例子只是一个针对素材个数统计的简单调用。显然此路不通。

### 柳暗花明 

又仔细观察了一下“开发者工具”，发现了自己看漏了这个东东：“公众平台测试帐号”。下面的醒目的写着，无需申请公众号就可以体验并测试所有高级功能。


步骤
---

参考链接
------
* GitHub's [Mastering Markdown · GitHub Guides](https://guides.github.com/features/mastering-markdown/)
* Daring Fireball's ["Markdown Syntax."](https://daringfireball.net/projects/markdown/syntax)

