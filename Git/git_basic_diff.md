
```github-cmd
$ mkdir learngit
$ cd learngit/
$ git init
Initialized empty Git repository in /Users/alex/Dev/github.com/dindinw/learngit/.git/
$ git status
On branch master

Initial commit

nothing to commit (create/copy files and use "git add" to track)
```

```github-cmd
$ git diff
$ echo 'Hello World!' > Hello.md
$ git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	Hello.md

nothing added to commit but untracked files present (use "git add" to track)
$ git diff
$ git diff --cached
```

```github-cmd
$ git add Hello.md
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

	new file:   Hello.md

$ git diff
$ git diff --cached
diff --git a/Hello.md b/Hello.md
new file mode 100644
index 0000000..980a0d5
--- /dev/null
+++ b/Hello.md
@@ -0,0 +1 @@
+Hello World!
```

```github-cmd
$ echo '你好，世界！' >> Hello.md 
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

	new file:   Hello.md

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   Hello.md

$ git diff
diff --git a/Hello.md b/Hello.md
index 980a0d5..c65f4df 100644
--- a/Hello.md
+++ b/Hello.md
@@ -1 +1,2 @@
 Hello World!
+你好，世界！
$ git diff --cached
diff --git a/Hello.md b/Hello.md
new file mode 100644
index 0000000..980a0d5
--- /dev/null
+++ b/Hello.md
@@ -0,0 +1 @@
+Hello World!
```

```github-cmd
$ git commit -m "commit first line."
[master (root-commit) 2155de4] commit first line.
 1 file changed, 1 insertion(+)
 create mode 100644 Hello.md
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   Hello.md

no changes added to commit (use "git add" and/or "git commit -a")
$ git diff
diff --git a/Hello.md b/Hello.md
index 980a0d5..c65f4df 100644
--- a/Hello.md
+++ b/Hello.md
@@ -1 +1,2 @@
 Hello World!
+你好，世界！
$ git diff --cached
```

```github-cmd
$ git add Hello.md
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	modified:   Hello.md

$ git diff
$ git diff --cached
diff --git a/Hello.md b/Hello.md
index 980a0d5..c65f4df 100644
--- a/Hello.md
+++ b/Hello.md
@@ -1 +1,2 @@
 Hello World!
+你好，世界！
```

```github-cmd
$ git commit -m "commit second line."
[master 57bc598] commit second line.
 1 file changed, 1 insertion(+)
$ git status
On branch master
nothing to commit, working directory clean
$ git diff
$ git diff --cached
```
