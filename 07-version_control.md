# Version Control

## 1. What is Version Control?
Version Control is a system that records changes to a file or set of files over time so that you can recall specific versions later.

It helps in:
1. **Sharing** – Multiple people can work on the same project without overwriting each other’s work.
2. **Versioning** – Keeps track of every change made, allowing rollback to previous versions if needed.

---

## 2. Version Control Tools
- **Centralized**: CVS, SVN  
  All developers commit changes to a central server. If the server is down, no commits can be made.
- **Distributed**: Git  
  Each developer has a full copy of the repository, allowing offline work and distributed collaboration.

**Difference between Centralized and Distributed:**
| Centralized                    | Distributed                    |
|--------------------------------|---------------------------------|
| Single central repository      | Each user has full repository  |
| Dependent on central server    | Can work offline               |
| Simpler but less resilient     | More resilient & flexible      |

---

## 3. Fork vs Clone
- **Fork**: Copying a remote repository (e.g., from someone else’s GitHub) into your own GitHub account.  
  Example: Copying `userA/project` to your GitHub account.
- **Clone**: Copying a repository from remote (GitHub) to your **local machine**.  
  Example: `git clone https://github.com/userA/project.git`

---

## 4. Git vs GitHub
- **Git**: A version control system (VCS) for tracking changes locally and remotely.
- **GitHub**: A cloud-based hosting platform for Git repositories with collaboration features.

---

## 5. Git Init and .git Folder
- `git init` creates a new Git repository in the current folder.
- This creates a hidden **.git** folder containing all metadata and version history.

### .git Folder Components:
| Component        | Description |
|------------------|-------------|
| `HEAD`           | Points to the current branch |
| `config`         | Git configuration for this repo |
| `refs/`          | References to branches, tags, and commits |
| `objects/`       | Stores all commits, trees, and blobs |
| `hooks/`         | Scripts triggered by Git events |
| `logs/`          | History of updates to refs |

**Example**:
```bash
mkdir project
cd project
git init
ls -la
# You will see a `.git` folder created
```

---

## 6. Branching
A branch is a pointer to a series of commits, allowing isolated development.
- **Main/Master Branch**: The primary, stable branch for production-ready code.
- **Feature Branch**: Created from `develop` (or sometimes `main`) to work on a new feature, then merged back after completion.
- **Release Branch**: Created to stabilize code before deployment, allowing bug fixes without blocking new features.
- **Hotfix Branch**: Created from `main` for urgent production fixes.

**Basic commands:**
```bash
git checkout -b feature-xyz   # Create and switch to a feature branch
git checkout main             # Switch back to main
git merge feature-xyz         # Merge feature into main
git branch -d feature-xyz     # Delete branch after merge
```

---

## 7. Merging
Merging is the process of integrating changes from one branch into another.
- **Fast-forward merge**: Simply moves the branch pointer forward when there’s no divergence.
- **Three-way merge**: Creates a merge commit when histories have diverged.

---

## 8. Common Workflow (Gitflow Example)
1. Start from `develop` branch for new features.
2. Create a feature branch: `feature/my-feature`.
3. Develop and commit changes.
4. Merge feature branch into `develop` for testing.
5. When ready for release, create `release/x.y.z` branch.
6. Fix bugs, finalize version, and merge `release` into both `main` and `develop`.
7. Tag the release in `main` for production.
8. For urgent fixes, create a `hotfix` branch from `main`.

---

## Summary
Version control is essential for modern software development, enabling safe collaboration, history tracking, and efficient code management. Git is the most popular distributed VCS, while GitHub provides an online platform for storing and collaborating on Git projects. Branching strategies like feature, release, and hotfix branches help organize and streamline development.
