---
title: "GitHub Error `error: could not delete reference refs/remotes/origin/HEAD: cannot lock ref 'refs/remotes/origin/HEAD': unable to resolve reference 'refs/remotes/origin/HEAD': reference broken` and `git gc` Command"
toc: false
categories:
 - GitHub
date: 2025-01-19 23:43:37 +0800
last_modified_at: 2025-01-20 11:26:48 +0800
---

Recently, when I pushed commits to GitHub via GitHub Desktop, I encountered the following error every time although it didn’t affect pushing normally (the error never occurred before):

```
error: could not delete reference refs/remotes/origin/HEAD: cannot lock ref 'refs/remotes/origin/HEAD': unable to resolve reference 'refs/remotes/origin/HEAD': reference broken
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501192343919.png" alt="image-20250119234315860" style="width:67%;" />

About this problem, GitHub user “zhzoo” provides a way to solve it[^1]:

<div class="quote--left" markdown="1">

running: `git gc --prune=now`

and deleting `.git/refs/remote/origin`

</div>

where the `git gc` command is to “cleanup unnecessary files and optimize the local repository”[^2]:

<div class="quote--left" markdown="1">

Runs a number of housekeeping tasks within the current repository, such as compressing file revisions (to reduce disk space and increase performance), removing unreachable objects which may have been created from prior invocations of *git add*, packing refs, pruning reflog, rerere metadata or stale working trees. May also update ancillary indexes such as the commit-graph.

</div>

and the `--prune=<date>` option[^2]:

<div class="quote--left" markdown="1">

`--prune=<date>`

Prune loose objects older than date (default is 2 weeks ago, overridable by the config variable `gc.pruneExpire`). `--prune=now` prunes loose objects regardless of their age and increases the risk of corruption if another process is writing to the repository concurrently. `--prune` is on by default.

</div>

But when I executed `git gc --prune=now`, there were other errors:

```
$ git gc --prune=now

error: bad ref for .git/logs/refs/remotes/origin/HEAD
fatal: bad object refs/remotes/origin/HEAD
fatal: failed to run repack
```

To resolve it, an extra command `mv .git/refs/remotes/origin/HEAD /tmp` should be executed firstly[^3].

And at this time, it’s okay to run the command `git gc --prune=now` again:

```
$ git gc --prune=now

Enumerating objects: 3385, done.
Counting objects: 100% (3385/3385), done.
Delta compression using up to 20 threads
Compressing objects: 100% (3363/3363), done.
Writing objects: 100% (3385/3385), done.
Total 3385 (delta 1896), reused 0 (delta 0), pack-reused 0
```

At last, delete `.git/refs/remote/origin`, and the problem is successfully solved.

<br>

**References**

[^1]: [https://github.com/desktop/desktop/issues/5438#issuecomment-414163603](https://github.com/desktop/desktop/issues/5438#issuecomment-414163603).
[^2]: [Git - `git-gc` Documentation](https://git-scm.com/docs/git-gc).
[^3]: [https://stackoverflow.com/a/38192799/22763127](https://stackoverflow.com/a/38192799/22763127).
