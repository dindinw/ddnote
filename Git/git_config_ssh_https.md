A remote's URL
--------------
git's remote URL has two kinds:
HTTPS
```
https://github.com/USERNAME/REPOSITORYNAME.git
```
SSH
```
git@github.com/USERNAME/REROSITORYNAME.git
```

Using `HTTPS`, so that firewall or proxy can also work in the most case. 

When using `SSH`, You can use SSH keys instead of providing username and password.

But when use `HTTPS`,  you can use a credential helper to cache your git username and password  
> need  Git version > 1.7.10 to use the credential helper.

```
# WINDOWS (msysgit)
$ git config --global credential.helper wincred
```

When use `wincred` see *Credential manager* in your *Control Panel* settings
![winced](https://mmbiz.qlogo.cn/mmbiz/ykYribFYPpbZnxaIia48Gm8uFTqLQPpBFgictVBeeKweVmz9ia5tnpa8mCIbXpiaIKbo5RkOkSXnhM7hibPrnHATwypQ/0?wx_fmt=png)


```
# MAC, using osxkeychain
```

```
# all platform , `cache' helper will cache for 15 mins by default
git config --global credential.helper cache                  # by default, timeout is 15mins
git config --global credential.helper 'cache --timeout=3600' # timeout after 1 hour
```
```

REFERENCES
----------
https://git-scm.com/docs/gitcredentials
