---
title: Delete All Commit History of A Certain GitHub Repository
toc: false
categories:
 - GitHub
 - Windows
date: 2025-01-15 16:56:29 +0800
last_modified_at: 2025-01-17 16:17:07 +0800
---

StackExchange answer[^1] gives a way to delete all commit history of a certain GitHub repository:

<div class="quote--left" markdown="1">

Deleting the `.git` folder may cause problems in your git repository. If you want to delete all your commit history but keep the code in its current state, it is very safe to do it as in the following:

1. Checkout/create orphan branch (this branch won't show in `git branch` command):

   ```powershell
   git checkout --orphan latest_branch
   ```

2. Add all the files to the newly created branch:

   ```powershell
   git add -A
   ```

3. Commit the changes:

   ```powershell
   git commit -am "commit message"
   ```

4. Delete `main` (default) branch (this step is permanent):

   ```powershell
   git branch -D main
   ```

5. Rename the current branch to `main`:

   ```powershell
   git branch -m main
   ```

6. Finally, all changes are completed on your local repository, and force update your remote repository:

   ```powershell
   git push -f origin main
   ```

PS: This will not keep your old commit history around. Now you should only see your new commit in the history of your git repository.

</div>

The answer is detailed. However, during the process of using it for my blog image hosting repository[^4], an error occurred when I executed the last piece of code (pushing code):

```
fatal: unable to access 'https://github.com/HelloWorld-1017/blog-images.git/': Failed to connect to github.com port 443 after 21082 ms: Timed out
```

This is because I didn’t use the right connection port[^2][^3].

My computer is using a proxy (VPN) to access GitHub *et al.* websites, and it works. Previously, I always used GitHub Desktop to pull, commit, and push changes to GitHub repositories, rather than native Git Bash. Like other applications, GitHub Desktop could use proxy by default, but Git Bash couldn’t[^2]. So, when I executed above commands in Git Bash and encountered the last pushing command, the error happened. To solve this problem, I need to configure proxy using commands like[^3]:

```powershell
git config --global http.proxy http://127.0.0.1:<port>
git config --global https.proxy http://127.0.0.1:<port>
```

where `<port>` is proxy port, which can be found in (for Windows 11):

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151726365.png" style="width:67%;" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151726401.png" style="width:67%;" />

After deleting commit history, the repository looks like:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151744959.png" style="width:67%;" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151732883.png" style="width:67%;" />

which show the deletion is successful.

However, the corresponding statistics of commit doesn’t disappear:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151733546.png" style="width:67%;" />

and repository size doesn’t decrease (still 884 MB), either:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151734751.png" style="width:67%;" />

that is my initial purposes of deleting commit history aren’t reached 😂 Perhaps the website hasn’t updated. Maybe I should check it out again tomorrow.

<br>

**Jan. 17, 2025**

To date, previous amount of commits didn’t disappear:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501171618621.png" alt="image-20250117161858500" style="width:50%;" />

but the repository size has been decreased:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501171619826.png" alt="image-20250117161947776" style="width:50%;" />

Maybe this feature is just as it.

<br>

**References**

[^1]: [https://stackoverflow.com/a/26000395/22763127](https://stackoverflow.com/a/26000395/22763127).
[^2]: [Git报错： Failed to connect to github.com port 443 解决方案](https://blog.csdn.net/zpf1813763637/article/details/128340109).
[^3]: [[报错解决] Failed to connect to github.com port 443 after \*\*\*\*\* ms: Couldn‘t connect to server](https://blog.csdn.net/m0_64007201/article/details/129628363).
[^4]: [HelloWorld-1017/blog-images](https://github.com/HelloWorld-1017/blog-images).
