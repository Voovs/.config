https://git-scm.com/docs
https://www.atlassian.com/git/tutorials
https://github.com/github/gitignore
# Making commits
##    Git setup
##    Basic commits
##    Modifying commits
##    Selective commits
# Remotes
##    Setup and info
##    Push/pull with remotes
##    Removing remote branches
# Branching
##    Basic checkouts and merges
##    Tags
##    Stashing
##    Rebasing
# Debugging
##    Gitdesk replaces
##    True debugging
# Other
##    Notes
##    Example workflow


#Making commits
##Git setup
git config --user core.editor

git init

git status

##Basic commits
git add file.txt
git commit -am "description"

git add [--interactive | -i]

git <cmd> -p
      checkout
      stash
      reset
      commit

*How to write a commit message:
- One short line of what the changes are < 50char
- More complete description on following lines < 72char each
- Write in present tense
- Clear and descriptive. Longer is sometimes better
Make your commits atomic*

##Modifying commits
git commit --amend

git restore --staged file.txt
git reset HEAD file.txt

git clean -f

git rm file.txt
git mv file.txt new.txt

git checkout -- file.txt
git checkout e42d8c91 -- file.txt
git revert e42d8c91

git reset --soft <treeish>

__RE: see #braching ##rebasing__

##Selective commits
.gitignore
git rm --cached file.txt

*use github . or the gitdesk alias on this machine*

git cherry-pick -e <treeish>

git diff from_brch to_brch > file.diff
git apply file.diff

git format-patch <treeish>..<treeish> -o /out_dir
git format-patch <treeish>..<treeish> --stdout > file.patch
git format-patch master #diff in curr branch since divergence

git am dir/file.patch
git am dir/\*.patch

__RE: see #braching ##rebasing__

#Remotes
##Setup and info
git remote add origin https://link.com
git clone https://link.com folder_name

git branch -a

git branch --merged
git branch --no-marged
git branch -r --merged

##Push/pull with remotes
git push -u origin master
git push

git fetch
*fetch before you start, push, or go offline*

git branch other_branch origin/other_branch
git checkout -b branch origin/branch

git push origin tag_name
git push origin --tags

git pull *git fetch; git merge*

git pull [--rebase | -r]
git pull --rebase=preserve //rebases merges as well
git pull --rebase=interactive

##Removing remote branches
git push origin :other_branch
git push origin --delete other_branch

git push --force
*Rewrites remote to look identical to your repo*
*Collabs should git reset --hard origin/*

git branch -d feature_branch
*must be fully merged into current branch*
git branch -D feature_branch

git remote prune origin [--dry-run]
git fetch [--prune | -p]

git push --delete origin tag_name

#Branching
##Basic checkouts and merges
git branch
git branch --merged

git branch new_branch
git checkout new_branch
git checkout -b new_branch //git branch; git checkout

git branch -m new_name
git branch -d delete_branch

git merge other_branch

<<<<<<< HEAD

=======

>>>>>>> other_branch

git merge --abort
git merge --continue

##Tags
git tag tag_name e42d8c
git tag -a tag_name -m "message" e42d8c

git tag [--list | -l]
git tag --list -n "v2*"
git tag [--delete | -d]

*detached HEAD state*
git checkout tag_name
git tag temp_tag

##Stashing
git stash save "title"
git stash list
git stash show -p stash@{0}
git stash pop stash@{0}

git stash apply stash@{0}
git stash drop stash@{0}
git stash clear

##Rebasing
git rebase master [curr_branch]
*never rebase a public branch*

git merge-base <treeish> <treeish>

git rebase --continue
git rebase --skip #when the code is already there
git rebase --abort

git rebase --onto reciving_brch parent_brch moving_brch
*parent_brch is simply the stopping point. Could be any ancestor*
*1 2 3: "taking 3 off of 2 and moving it onto 1"*

git reset --hard ORIG_HEAD
git rebase --onto prev_parent curr_parent moving_brch

git rebase -i parent_brch moving_brch
git rebase -i HEAD~3
*Allows you to modify last 3 commits*

squash *cleans up small commits*

#Debugging
##Gitdesk replaces
git log -n 3 e42d8c91
git log file.txt
git log <treeish> --after=2020-01-01 --before=3.days --oneline --author="komi"
git log <treeish>..<treeish> --grep="mobile view"

git diff readme.txt
git diff -S --color-words readme.txt --staged
git diff <treeish>..<treeish>

git show e42d8c91
*use github . or the gitdesk alias on this machine*

git log --stat
git log --graph --all --oneline --decorate

##True debugging
git ls-tree <treeish>

git praise -w -L 2,+8 file.txt
git praise e42d8c -- file.txt

git bisect start
git bisect bad <treeish>
git bisect good <treeish>
git bisect reset

#Other
##Notes
<treeish> = e42d8c, master^^, HEAD, tag
<treeish>^
<treeish>~2

##Example basic workflow
*Pure production end*
git checkout master
git fetch
git merge origin/master
git checkout -b form_branch
git add form.rs
git commit -m "Creates pgrm to take user feedback"
git fetch
git push -u origin form_branch

*Reciving others' work*
git pull
git checkout -b form_branch origin/form_branch
git log -p; git show
git commit -am "Improves form error handling"
git fetch
git push

*Revising other's work*
git checkout form_branch
git fetch
git log -p form_branch..origin/form_branch
git merge origin/form_branch
git checkout master
git pull
git merge form_branch
git push

##Garbage collection (stuff that I don't know)
---git remote -v
git remote rm origin

---git push origin :feature_branch
git push --delete origin feature_branch
