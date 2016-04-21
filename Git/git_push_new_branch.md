### How to push new branch to remote origin

first, check out your new branch. and commit changes. then execute `git push -u origin <your_brach_name>` at the first time. _
after do that, you can use `git push` when you at the branch just like what your are doing with `master` branch.

```
~/Dev/my-app (my-new-branch)
$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        ignorecase = true
        hideDotFiles = dotGitOnly
[remote "origin"]
        url = https://my-git-server.site/my-app.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master

~/Dev/my-app (my-new-branch)
$ git push -u origin my-new-branch
Counting objects: 24, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (14/14), done.
Writing objects: 100% (24/24), 2.32 KiB | 0 bytes/s, done.
Total 24 (delta 7), reused 0 (delta 0)
To https://my-git-server.site/my-app.git
 * [new branch]      my-new-branch -> my-new-branch
Branch my-new-branch set up to track remote branch my-new-branch from origin.

~/Dev/my-app (my-new-branch=)
$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        ignorecase = true
        hideDotFiles = dotGitOnly
[remote "origin"]
        url = https://my-git-server.site/my-app.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
[branch "my-new-branch"]
        remote = origin
        merge = refs/heads/my-new-branch

~/Dev/my-app (my-new-branch=)
```