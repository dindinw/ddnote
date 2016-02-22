
### All possible places for git config files

* --system `/etc/gitconfig` 
* --global `~/.gitconfig` or `~/.config/git/config`
* --local `.git/config`

> NOTE: For Windows system, there are a hidden file (add since Git for Windows 2.x)  

```
C:\Documents and Settings\All Users\Application Data\Git\config      # Windows XP
C:\ProgramData\Git\config                                            # Windows Vista and newer
```

REF
---
https://github.com/git-for-windows/git/pull/104

https://github.com/git-for-windows/git/issues/531

https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup