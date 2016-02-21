
https://help.github.com/articles/syncing-a-fork/

1. add a remote (the fork you want to merge)
2. fetch the remote 
3. merge the remote to your master
4. push your master 

```github-cmd
$ git remote add otherfork https://my.git.repo/other/docker-sd-client.git
$ git remote -v
origin	https://my.git.repo/alex/docker-sd-client.git (fetch)
origin	https://my.git.repo/alex/docker-sd-client.git (push)
otherfork	https://my.git.repo/other/docker-sd-client.git (fetch)
otherfork	https://my.git.repo/other/docker-sd-client.git (push)
```

```github-cmd
$ git fetch otherfork
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 0), reused 4 (delta 0), pack-reused 0
Unpacking objects: 100% (4/4), done.
From https://my.git.repo/other/docker-sd-client
 * [new branch]      master     -> otherfork/master
```

```github-cmd
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/otherfork/master
```

```github-cmd
# make sure your are on the master
$ git checkout master
Already on 'master'
Your branch is up-to-date with 'origin/master'.

$ git merge otherfork/master 
Updating 441d045..9f46872
Fast-forward
 Dockerfile       | 15 +++++++++++++++
 run_sd_client.sh |  6 ++++++
 2 files changed, 21 insertions(+)
 create mode 100644 Dockerfile
 create mode 100755 run_sd_client.sh
 
$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working directory clean

$ git log
commit 9f46872f493c26cbf6fbc06323664c5eb979b2ba
Author: xuanzhong <other@company.com>
Date:   Mon Feb 15 22:45:07 2016 -0500

    Add the docker build for SD client.

commit 441d04550349111fdfe6f624653070d9c28ada6b
Author: other <other@company.com>
Date:   Mon Feb 15 09:57:06 2016 -0500

    Initial commit
```
