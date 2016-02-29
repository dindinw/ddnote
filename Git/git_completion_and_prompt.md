
### CentOS?
```
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\$ '
```
### Ubuntu 14.04

```
$ dpkg -L git |grep prompt               #find the prompt script
/usr/lib/git-core/git-sh-prompt
/etc/bash_completion.d/git-prompt
```

Add to `~/.bashrc`
```
GITPROMPT=/etc/bash_completion.d/git-prompt
if [ -e $GITPROMPT ]; then
    source $GITPROMPT
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\$ '
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM=auto
fi
```

GIT_PROMPT (http://neta-abc.blogspot.jp/2013/02/git.html)
The PS Color Guide (http://qiita.com/caad1229/items/6d71d84933c8a87af0c4)