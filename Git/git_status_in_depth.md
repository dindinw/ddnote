Git internal for git status
---------------------------

> What Git do for the `git status` command.

###  `git status` try to compare current branch with `origin/master` 

* even 
```
~/Dev/github.com/dindinw/git/builtin (master=)
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean
```

* ahead
```
~/Dev/github.com/dindinw/ddnote (master *%>)
$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
```

#### Call stack 

`git.c (main)` -> `./builtin/commit.c(cmd_status)`

```
$ find . -name "*.[ch]" -exec grep -aHn --color "cmd_status" {} \;
./builtin/commit.c:1316:int cmd_status(int argc, const char **argv, const char *prefix)
./builtin.h:121:extern int cmd_status(int argc, const char **argv, const char *prefix);
./git.c:474:    { "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
```

`./builtin/commit.c(cmd_status)` -> `./wt-status.c(wt_status_print)` -> \

```
$ find . -name "*.[ch]" -exec grep -aHn --color "wt_status_print(" {} \;
./builtin/commit.c:515:         wt_status_print(s);
./builtin/commit.c:1394:                wt_status_print(&s);
./wt-status.c:1427:void wt_status_print(struct wt_status *s)
./wt-status.h:100:void wt_status_print(struct wt_status *s);

$ find . -name "*.[ch]" -exec grep -aHn --color "wt_status_print_tracking" {} \;
./wt-status.c:897:static void wt_status_print_tracking(struct wt_status *s)
./wt-status.c:1464:                     wt_status_print_tracking(s);
```

`./wt-status.c(ws_status_print_tracking)`_-> `remote.c(format_tracking_info)`_
```
$ find . -name "*.[ch]" -exec grep -aHn --color "format_tracking_info" {} \;
./builtin/checkout.c:600:       if (!format_tracking_info(branch, &sb))
./remote.c:2057:int format_tracking_info(struct branch *branch, struct strbuf *sb)
./remote.h:256:int format_tracking_info(struct branch *branch, struct strbuf *sb);
./wt-status.c:909:      if (!format_tracking_info(branch, &sb))

$ find . -name "*.[ch]" -exec grep -aHn --color "Your branch is" {} \;
./remote.c:2073:                        _("Your branch is based on '%s', but the upstream is gone.\n"),
./remote.c:2080:                        _("Your branch is up-to-date with '%s'.\n"),
./remote.c:2084:                        Q_("Your branch is ahead of '%s' by %d commit.\n",
./remote.c:2085:                           "Your branch is ahead of '%s' by %d commits.\n",
./remote.c:2093:                        Q_("Your branch is behind '%s' by %d commit, "
./remote.c:2095:                           "Your branch is behind '%s' by %d commits, "
```

####  How to compare and calculate the commits ahead or behind?

```c
2054 /*
2055  * Return true when there is anything to report, otherwise false.
2056  */
2057 int format_tracking_info(struct branch *branch, struct strbuf *sb)
2058 {
2059     int ours, theirs;
2060     const char *full_base;
2061     char *base;
2062     int upstream_is_gone = 0;
2063
2064     if (stat_tracking_info(branch, &ours, &theirs, &full_base) < 0) {
2065         if (!full_base)
2066             return 0;
2067         upstream_is_gone = 1;
2068     }
2069
2070     base = shorten_unambiguous_ref(full_base, 0);
2071     if (upstream_is_gone) {
2072         strbuf_addf(sb,
2073             _("Your branch is based on '%s', but the upstream is gone.\n"),
2074             base);
2075         if (advice_status_hints)
2076             strbuf_addf(sb,
2077                 _("  (use \"git branch --unset-upstream\" to fixup)\n"));
2078     } else if (!ours && !theirs) {
2079         strbuf_addf(sb,
2080             _("Your branch is up-to-date with '%s'.\n"),
2081             base);
2082     } else if (!theirs) {
2083         strbuf_addf(sb,
2084             Q_("Your branch is ahead of '%s' by %d commit.\n",
2085                "Your branch is ahead of '%s' by %d commits.\n",
2086                ours),
2087             base, ours);
2088         if (advice_status_hints)
2089             strbuf_addf(sb,
```

The function `stat_tracking_info` will calculate the branch with upstream (`original/master` be default)

```
/*
 * Compare a branch with its upstream, and save their differences (number
 * of commits) in *num_ours and *num_theirs. The name of the upstream branch
 * (or NULL if no upstream is defined) is returned via *upstream_name, if it
 * is not itself NULL.
 *
 * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
 * upstream defined, or ref does not exist), 0 otherwise.
 */
int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
		       const char **upstream_name)
{
	struct object_id oid;
	struct commit *ours, *theirs;
	struct rev_info revs;
	const char *base;
	struct argv_array argv = ARGV_ARRAY_INIT;

	/* Cannot stat unless we are marked to build on top of somebody else. */
	base = branch_get_upstream(branch, NULL);
	if (upstream_name)
		*upstream_name = base;
	if (!base)
		return -1;

	/* Cannot stat if what we used to build on no longer exists */
	if (read_ref(base, oid.hash))
		return -1;
	theirs = lookup_commit_reference(oid.hash);
	if (!theirs)
		return -1;

	if (read_ref(branch->refname, oid.hash))
		return -1;
	ours = lookup_commit_reference(oid.hash);
	if (!ours)
		return -1;

	/* are we the same? */
	if (theirs == ours) {
		*num_theirs = *num_ours = 0;
		return 0;
	}

	/* Run "rev-list --left-right ours...theirs" internally... */
	argv_array_push(&argv, ""); /* ignored */
	argv_array_push(&argv, "--left-right");
	argv_array_pushf(&argv, "%s...%s",
			 oid_to_hex(&ours->object.oid),
			 oid_to_hex(&theirs->object.oid));
	argv_array_push(&argv, "--");

	init_revisions(&revs, NULL);
	setup_revisions(argv.argc, argv.argv, &revs, NULL);
	if (prepare_revision_walk(&revs))
		die("revision walk setup failed");

	/* ... and count the commits on each side. */
	*num_ours = 0;
	*num_theirs = 0;
	while (1) {
		struct commit *c = get_revision(&revs);
		if (!c)
			break;
		if (c->object.flags & SYMMETRIC_LEFT)
			(*num_ours)++;
		else
			(*num_theirs)++;
	}

	/* clear object flags smudged by the above traversal */
	clear_commit_marks(ours, ALL_REV_FLAGS);
	clear_commit_marks(theirs, ALL_REV_FLAGS);

	argv_array_clear(&argv);
	return 0;
}

```

Here `rev-list --left-right ours...theirs` command is used, in another word,
`git status` command do use `git rev-list` internally.

#### Compare with git-prompt.sh

```bash
		# produce equivalent output to --count for older versions of git
		local commits
		if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
		then
			local commit behind=0 ahead=0
			for commit in $commits
			do
				case "$commit" in
				"<"*) ((behind++)) ;;
				*)    ((ahead++))  ;;
				esac
			done
			count="$behind	$ahead"
		else
			count=""
		fi
```

Now, We know the two command actually use the same way to implementation. 
I am sure that there is no big different for the performance of the `git status` command and the `git-prompt.sh` script.
*(precisely, the git status get reversion info in the memory. the shell script need to use IO redirect)*
