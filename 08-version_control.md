## 1. Working Tree, Staging Area, and Repository

To understand Git clearly, first understand these 3 areas:

### Working Tree
This is your actual project folder where you create, edit, and delete files.

### Staging Area (Index)
This is the temporary area where you choose which changes should go into the next commit.

### Repository
This is Git’s stored history inside the `.git` directory.

### Flow
```text
Working Directory -> Staging Area -> Local Repository -> Remote Repository
```

### Example
```bash
git add app.py
git commit -m "Add customer validation"
git push origin main
```

Here:
- `git add` moves changes to staging area
- `git commit` saves them in local repository
- `git push` sends them to remote repository

---

## 2. Git File States

A file in Git usually moves through these states:

- **Untracked** → Git sees the file, but it is not yet added
- **Tracked** → Git is already monitoring the file
- **Modified** → The tracked file has changes
- **Staged** → The changes are ready for commit
- **Committed** → Changes are saved into Git history

### Check file states
```bash
git status
```

---

## 3. Important Daily Commands

## `git status`
Shows current branch, changed files, staged files, and untracked files.

```bash
git status
```

## `git add`
Adds changes to staging area.

```bash
git add file.txt
git add .
```

- `git add file.txt` → add only one file
- `git add .` → add all changes in current directory

## `git commit`
Creates a snapshot of staged changes.

```bash
git commit -m "Fix premium calculation logic"
```

## `git log`
Shows commit history.

```bash
git log
git log --oneline
git log --graph --oneline --decorate
```

## `git diff`
Shows line-by-line differences.

```bash
git diff
git diff --staged
```

- `git diff` → unstaged changes
- `git diff --staged` → staged changes

---

## 4. `git rm` and `git mv`

## `git rm`
Removes a file from working directory and Git tracking.

```bash
git rm old_file.txt
git commit -m "Remove old file"
```

If you want Git to stop tracking but keep the file locally:

```bash
git rm --cached config.txt
```

## `git mv`
Renames or moves a file.

```bash
git mv old_name.py new_name.py
git commit -m "Rename file"
```

---

## 5. `.gitignore`

`.gitignore` tells Git which files or folders should not be tracked.

Common examples:
- log files
- temporary files
- build output
- secrets
- virtual environments
- `.env` files

### Example `.gitignore`
```gitignore
*.log
.env
__pycache__/
node_modules/
venv/
dist/
```

### Why use it?
Because some files should not go to the repository.

Especially:
- sensitive files
- generated files
- unnecessary large files

---

## 6. Local vs Remote Repository

## Local Repository
The copy on your machine.

## Remote Repository
The shared repository stored on GitHub, GitLab, Bitbucket, or another server.

### Common remote commands
```bash
git remote -v
git fetch origin
git pull origin main
git push origin main
```

---

## 7. `git fetch`, `git pull`, and `git push`

## `git fetch`
Downloads latest changes from remote but does **not** merge them into your current branch.

```bash
git fetch origin
```

Use it when you want to first inspect remote changes safely.

## `git pull`
Fetches changes and then merges them into your current branch.

```bash
git pull origin main
```

In simple words:
```text
git pull = git fetch + git merge
```

## `git push`
Sends your local commits to the remote repository.

```bash
git push origin main
```

---

## 8. Upstream Branch

An upstream branch means the remote branch connected to your local branch.

### Example
```bash
git push -u origin feature/login-api
```

Here:
- local branch = `feature/login-api`
- upstream remote branch = `origin/feature/login-api`

After setting upstream, you can use simpler commands:

```bash
git push
git pull
```

---

## 9. `HEAD` in Git

`HEAD` is a pointer to your current checked out branch or commit.

### Example
If you are on `main`, then `HEAD` points to `main`.

### Check current position
```bash
git log --oneline
```

### Detached HEAD
If you checkout a commit directly instead of a branch:

```bash
git checkout a1b2c3d
```

Then Git puts you in **detached HEAD** state.

This means:
- you are not on a normal branch
- you can inspect old code
- new commits here can be lost unless you create a branch

Create a branch from detached HEAD:

```bash
git checkout -b rescue-branch
```

---

## 10. Tags

A tag marks an important point in history, usually a release.

### Example
```bash
git tag v1.0.0
git tag
```

### Annotated tag
```bash
git tag -a v1.0.0 -m "Release version 1.0.0"
```

### Push tag to remote
```bash
git push origin v1.0.0
```

### Why use tags?
Because releases are easier to identify by tag than by commit id.

---

## 11. Stash

`git stash` temporarily saves your uncommitted changes so you can switch branches or pull updates safely.

### Example
```bash
git stash
git checkout main
```

Bring them back:

```bash
git stash pop
```

See stashed items:

```bash
git stash list
```

Use it when:
- your work is incomplete
- you must quickly change branch
- you do not want to commit unfinished work yet

---

## 12. Merge vs Rebase vs Cherry-pick

These are important branch/history operations.

## Merge
Merges one branch into another branch.

```bash
git checkout main
git merge feature/login
```

### Result
- full branch changes come into current branch
- usually keeps branch history
- may create merge commit

## Rebase
Moves or replays your commits on top of another base branch.

```bash
git checkout feature/login
git rebase main
```

### Result
- cleaner linear history
- commit ids change
- useful for private feature branches

## Cherry-pick
Copies one specific commit from another branch.

```bash
git checkout main
git cherry-pick abc1234
```

### Result
- only selected commit comes
- whole branch does not come
- useful for hotfixes or selective changes

### Quick difference
| Command | Meaning |
|---|---|
| `merge` | bring all branch changes |
| `rebase` | replay commits on a new base |
| `cherry-pick` | copy one commit only |

---

## 13. `git reset`, `git revert`, and `git restore`

These commands are commonly confusing, so they must be separated clearly.

## `git restore`
Used to restore file content.

### Discard unstaged file changes
```bash
git restore app.py
```

### Unstage a file
```bash
git restore --staged app.py
```

## `git reset`
Moves branch pointer backward. It can also unstage changes or remove commits from local history.

### Unstage changes
```bash
git reset HEAD app.py
```

### Move back one commit but keep changes
```bash
git reset --soft HEAD~1
```

### Move back one commit and unstage changes
```bash
git reset --mixed HEAD~1
```

### Move back one commit and delete changes
```bash
git reset --hard HEAD~1
```

### Warning
`--hard` can permanently remove local uncommitted work.

## `git revert`
Creates a new commit that reverses the effect of an old commit.

```bash
git revert abc1234
```

This is safer than reset for shared branches because it does not rewrite public history.

### Simple difference
| Command | Main use |
|---|---|
| `restore` | restore file content or unstage files |
| `reset` | move HEAD/branch backward, rewrite local history |
| `revert` | undo via a new commit |

---

## 14. Merge Conflicts

A merge conflict happens when Git cannot automatically decide which change to keep.

Example:
- branch A changes line 10
- branch B also changes line 10
- Git needs manual help

### Conflict markers look like this
```text
<<<<<<< HEAD
Current branch code
=======
Incoming branch code
>>>>>>> feature/login
```

### Steps to resolve
1. Open the conflicted file
2. Decide what content should remain
3. Remove conflict markers
4. Stage the file
5. Continue merge or rebase

```bash
git add app.py
git commit
```

For rebase conflict:

```bash
git rebase --continue
```

Abort if needed:

```bash
git merge --abort
git rebase --abort
```

---

## 15. Branching Strategy

A branching strategy means the rules a team follows for using branches.

### Common branch names
- `main` / `master` / `trunk` → primary branch
- `feature/*` → new work
- `release/*` → release preparation
- `hotfix/*` → urgent production fix

### Example strategy
- `main` always stable
- developers create `feature/*` branches
- pull request is created
- code is reviewed
- branch is merged to `main`
- release is tagged

### Why strategy matters
Because it gives:
- better collaboration
- cleaner history
- safer releases
- fewer production mistakes

---

## 16. Pull Request (PR)

A pull request is a request to merge your branch into another branch.

Usually done in GitHub/GitLab.

### PR flow
1. Create feature branch
2. Commit and push changes
3. Open PR
4. Reviewer checks code
5. CI/CD runs tests
6. Comments are addressed
7. PR is approved and merged

### Why PR is important
Because it supports:
- code review
- discussion
- quality checks
- controlled merge to stable branch

---

## 17. Git Branch Commands

### Create branch
```bash
git branch feature/report-api
```

### Create and switch
```bash
git checkout -b feature/report-api
```

### Switch branch (modern way)
```bash
git switch main
git switch -c feature/report-api
```

### List branches
```bash
git branch
git branch -a
```

### Delete local branch
```bash
git branch -d feature/report-api
```

### Force delete local branch
```bash
git branch -D feature/report-api
```

### Delete remote branch
```bash
git push origin --delete feature/report-api
```

---

## 18. Best Practices

### 1. Do not commit directly to `main`
Use feature branches and PR review.

### 2. Commit small logical changes
This makes history cleaner and easier to review.

### 3. Write meaningful commit messages
Bad:
```text
fix
update
changes
```

Better:
```text
Fix claim status mapping for rejected policies
Add validation for missing customer DOB
Update Redshift load script for retry logic
```

### 4. Pull latest code before starting work
```bash
git checkout main
git pull origin main
```

### 5. Keep branches short-lived
Long-running branches create more conflicts.

### 6. Never commit secrets
Use `.gitignore`, secret managers, and environment variables.

### 7. Use tags for release versions
Example: `v1.0.0`, `v2.1.3`

### 8. Prefer `revert` over `reset` for shared branches
Because shared history should not be rewritten carelessly.

---

## 19. Practical Example End-to-End

### Step 1: Clone project
```bash
git clone https://github.com/org/project.git
cd project
```

### Step 2: Create feature branch
```bash
git checkout -b feature/customer-api
```

### Step 3: Make code changes
Edit files in working directory.

### Step 4: Check status
```bash
git status
```

### Step 5: Stage changes
```bash
git add .
```

### Step 6: Commit
```bash
git commit -m "Add customer API endpoint"
```

### Step 7: Push branch
```bash
git push -u origin feature/customer-api
```

### Step 8: Open PR
Merge after review and CI validation.

### Step 9: Update local main after merge
```bash
git checkout main
git pull origin main
```

---

## 20. Interview Quick Answers

### What is Git stash?
It temporarily saves uncommitted changes so you can switch context without losing work.

### What is the difference between fetch and pull?
`fetch` downloads remote changes only. `pull` downloads and merges them.

### What is the difference between merge and rebase?
Merge combines histories. Rebase rewrites commits onto a new base for a cleaner history.

### What is cherry-pick?
It copies one selected commit from one branch to another branch.

### What is revert?
It undoes a commit by creating a new opposite commit.

### What is reset?
It moves branch history backward and can remove commits from local history.

---

## Summary

This file extends the first version control notes by covering the practical Git areas used in real projects:
- working tree, staging area, repository
- file states
- daily commands
- `.gitignore`
- local and remote repositories
- fetch, pull, push
- upstream branch
- HEAD and detached HEAD
- stash and tags
- merge, rebase, cherry-pick
- reset, restore, revert
- merge conflicts
- pull requests
- branch strategy and best practices