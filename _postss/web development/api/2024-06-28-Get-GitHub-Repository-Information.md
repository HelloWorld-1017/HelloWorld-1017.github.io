---
title: Get GitHub Repository Information through REST API (in JSON Format)
toc: false
categories:
 - Web Development
 - GitHub
tags:
 - API
 - JSON
date: 2024-06-28 00:19:15 +0800
last_modified_at: 2024-07-27 21:40:33 +0800
---

For a GitHub repository `$REPO_NAME` owned by user `$USER_NAME`, we can get its repository information through url `https://api.github.com/repos/$USER_NAME/$REPO_NAME`. For example, for the public repository hosting my personal website, through [https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io](https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io) I have these following information in JSON (JavaScript Object Notation) data format (or, a JSON file):

```json
{
  "id": 514507239,
  "node_id": "R_kgDOHqrB5w",
  "name": "HelloWorld-1017.github.io",
  "full_name": "HelloWorld-1017/HelloWorld-1017.github.io",
  "private": false,
  "owner": {
    "login": "HelloWorld-1017",
    "id": 50327243,
    "node_id": "MDQ6VXNlcjUwMzI3MjQz",
    "avatar_url": "https://avatars.githubusercontent.com/u/50327243?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/HelloWorld-1017",
    "html_url": "https://github.com/HelloWorld-1017",
    "followers_url": "https://api.github.com/users/HelloWorld-1017/followers",
    "following_url": "https://api.github.com/users/HelloWorld-1017/following{/other_user}",
    "gists_url": "https://api.github.com/users/HelloWorld-1017/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/HelloWorld-1017/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/HelloWorld-1017/subscriptions",
    "organizations_url": "https://api.github.com/users/HelloWorld-1017/orgs",
    "repos_url": "https://api.github.com/users/HelloWorld-1017/repos",
    "events_url": "https://api.github.com/users/HelloWorld-1017/events{/privacy}",
    "received_events_url": "https://api.github.com/users/HelloWorld-1017/received_events",
    "type": "User",
    "site_admin": false
  },
  "html_url": "https://github.com/HelloWorld-1017/HelloWorld-1017.github.io",
  "description": "helloworld-1017.github.io",
  "fork": false,
  "url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io",
  "forks_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/forks",
  "keys_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/keys{/key_id}",
  "collaborators_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/collaborators{/collaborator}",
  "teams_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/teams",
  "hooks_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/hooks",
  "issue_events_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/issues/events{/number}",
  "events_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/events",
  "assignees_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/assignees{/user}",
  "branches_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/branches{/branch}",
  "tags_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/tags",
  "blobs_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/git/blobs{/sha}",
  "git_tags_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/git/tags{/sha}",
  "git_refs_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/git/refs{/sha}",
  "trees_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/git/trees{/sha}",
  "statuses_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/statuses/{sha}",
  "languages_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/languages",
  "stargazers_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/stargazers",
  "contributors_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/contributors",
  "subscribers_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/subscribers",
  "subscription_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/subscription",
  "commits_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/commits{/sha}",
  "git_commits_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/git/commits{/sha}",
  "comments_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/comments{/number}",
  "issue_comment_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/issues/comments{/number}",
  "contents_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/contents/{+path}",
  "compare_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/compare/{base}...{head}",
  "merges_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/merges",
  "archive_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/{archive_format}{/ref}",
  "downloads_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/downloads",
  "issues_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/issues{/number}",
  "pulls_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/pulls{/number}",
  "milestones_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/milestones{/number}",
  "notifications_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/notifications{?since,all,participating}",
  "labels_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/labels{/name}",
  "releases_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/releases{/id}",
  "deployments_url": "https://api.github.com/repos/HelloWorld-1017/HelloWorld-1017.github.io/deployments",
  "created_at": "2022-07-16T07:16:20Z",
  "updated_at": "2024-06-27T15:17:36Z",
  "pushed_at": "2024-06-27T15:17:32Z",
  "git_url": "git://github.com/HelloWorld-1017/HelloWorld-1017.github.io.git",
  "ssh_url": "git@github.com:HelloWorld-1017/HelloWorld-1017.github.io.git",
  "clone_url": "https://github.com/HelloWorld-1017/HelloWorld-1017.github.io.git",
  "svn_url": "https://github.com/HelloWorld-1017/HelloWorld-1017.github.io",
  "homepage": "https://helloworld-1017.github.io",
  "size": 986256,
  "stargazers_count": 4,
  "watchers_count": 4,
  "language": "JavaScript",
  "has_issues": true,
  "has_projects": true,
  "has_downloads": true,
  "has_wiki": true,
  "has_pages": true,
  "has_discussions": true,
  "forks_count": 0,
  "mirror_url": null,
  "archived": false,
  "disabled": false,
  "open_issues_count": 0,
  "license": null,
  "allow_forking": true,
  "is_template": false,
  "web_commit_signoff_required": false,
  "topics": [

  ],
  "visibility": "public",
  "forks": 0,
  "open_issues": 0,
  "watchers": 4,
  "default_branch": "main",
  "temp_clone_token": null,
  "network_count": 0,
  "subscribers_count": 3
}
```

<br>

**References**

[1] [GitHub REST API documentation - GitHub Docs](https://docs.github.com/en/rest?apiVersion=2022-11-28).

