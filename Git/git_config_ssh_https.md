A remote's URL
--------------
git's remote URL has two kinds:

* HTTPS
    > https://github.com/USER/REPO.git
* SSH
    > git@github.com/USER/REPO.git

### Use SSH
When using `SSH`, You can use SSH keys instead of providing username and password.

### Use HTTPS 

Using `HTTPS`, so that firewall or proxy can also work in the most case. 

when use `HTTPS`,  you can use a credential helper to cache your git username and password  
> need  Git version > 1.7.10 to use the credential helper.

#### Windows 

```bash-github
# WINDOWS (msysgit)
$ git config --global credential.helper wincred
```

When use `wincred` see **Credential manager** in your **Control Panel** settings
![winced](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbZnxaIia48Gm8uFTqLQPpBFgictVBeeKweVmz9ia5tnpa8mCIbXpiaIKbo5RkOkSXnhM7hibPrnHATwypQ/0?wx_fmt=png)

#### MAC 

MAC using `osxkeychain`

```bash-github
$ git config --global credential.helper osxkeychain
$ git config -l|grep cred
credential.helper=osxkeychain
```
see `Keychain Access` app
![osxkeychain](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbZMzcpiaX1FriaNO0ibLcCdgJQuWNKcNicuk23urKr2lTmQsFWLoHXfrRhYciahO72YZDNficSEXtcuLdibw/0?wx_fmt=png)

#### LINUX

For all platform , `cache' helper will be used 

```bash-github
# by default, timeout is 15mins
$ git config --global credential.helper cache

# timeout after 1 hour
$ git config --global credential.helper 'cache --timeout=3600'
```


### A Special Note about APPLE-Git 50.3
In the mac platform, an apple built git version is shipped with Xcode command line tools.
For example, `Apple Git-50.3` in my 10.9.5 OS X Mavericks 
```
$ /usr/bin/git --version
git version 1.9.5 (Apple Git-50.3)
```
The Apple-git has a special feature, which is different with official git. the `osxkeychain` is 
included by hardcoded. It means you need NOT to configure `credential.helper osxkeychain`. 
Apple-get will try to get it from your keychain and use it.

See `./credential.c:14`
```c
  1 #include "cache.h"
  2 #include "credential.h"
  3 #include "string-list.h"
  4 #include "run-command.h"
  5 #include "url.h"
  6 #include "prompt.h"
  7 
  8 void credential_init(struct credential *c)
  9 {
 10     memset(c, 0, sizeof(*c));
 11     c->helpers.strdup_strings = 1;
 12 
 13     /* <rdar://problem/12266645> */
 14     string_list_append(&c->helpers, "osxkeychain");
 15 }
 16 
```

and `./credential.c:279`
```c
269 void credential_fill(struct credential *c)
270 {
271     int i;
272 
273     if (c->username && c->password)
274         return;
275 
276     credential_apply_config(c);
277 
278     for (i = 0; i < c->helpers.nr; i++) {
279         credential_do(c, c->helpers.items[i].string, "get");
280         if (c->username && c->password)
281             return;
282     }
283 
284     credential_getpass(c);
285     if (!c->username && !c->password)
286         die("unable to get password from user");
287 }
288 
```

and `./crendential.c:263`
```c
249 static int credential_do(struct credential *c, const char *helper,
250              const char *operation)
251 {
252     struct strbuf cmd = STRBUF_INIT;
253     int r;
254 
255     if (helper[0] == '!')
256         strbuf_addstr(&cmd, helper + 1);
257     else if (is_absolute_path(helper))
258         strbuf_addstr(&cmd, helper);
259     else
260         strbuf_addf(&cmd, "git credential-%s", helper);
261 
262     strbuf_addf(&cmd, " %s", operation);
263     r = run_credential_helper(c, cmd.buf, !strcmp(operation, "get"));
264 
265     strbuf_release(&cmd);
266     return r;
267 }
```


The hidden credential helper is installed inside of `Xcode.app`  
> `/Applications/Xcode.app/Contents/Developer/usr/libexec/git-core/git-credential-osxkeychain`

But if you use a more updated version though `homebrew`. for example, I am using the latest stable git version `2.7.1`
```bash-github
$ /usr/local/bin/git --version
git version 2.7.1
```

compare the `credential_init()` method 
```c
  1 #include "cache.h"
  2 #include "credential.h"
  3 #include "string-list.h"
  4 #include "run-command.h"
  5 #include "url.h"
  6 #include "prompt.h"
  7 
  8 void credential_init(struct credential *c)
  9 {
 10     memset(c, 0, sizeof(*c));
 11     c->helpers.strdup_strings = 1;
 12 }
 13 

```
In this case, you must set config `credential.helper`, otherwise the keychain will not use. and you are prompt user/passwd every time.

REFERENCES
----------
Git Doc git-credentials 
> https://git-scm.com/docs/gitcredentials

Git Official Source Code
> https://github.com/git/git

Apple Git Source
> https://opensource.apple.com/tarballs/Git/Git-50.3.tar.gz

