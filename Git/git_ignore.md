
https://help.github.com/articles/ignoring-files/

Create a global .gitignore

You can also create a global .gitignore file, which is a list of rules for ignoring files in every Git repositories on your computer. For example, you might create the file at ~/.gitignore_global and add some rules to it.

Open Terminal. Run the following command in your terminal:

```
git config --global core.excludesfile ~/.gitignore_global

```

```
git config --global core.excludesfile ~/Dev/github.com/dindinw/usersettings/.gitignore
```