#!/usr/bin/env bash

# sources: https://stackoverflow.com/questions/10067848/remove-folder-and-its-contents-from-git-githubs-history
# more complete: https://blog.ostermiller.org/git-remove-from-history


# Step 1: Create a clone of the repository
# Replace MY_GIT_REPOSITORY with the URL of your git repository. This will also track all the branches so all branches can be cleaned as well. (source)

git clone MY_GIT_REPOSITORY.git workingrepo
cd workingrepo

# Create tracking branches of all branches
for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
    git branch --track ${branch##*/} $branch
done

# alt:
for remote in `git branch -r | grep -v /HEAD`; do git checkout --track $remote ; done

# Step 2: Find the files that you want to remove
# Case A: Large deleted files
# Large deleted files are stored in the repository and are still transfered for every clone. Here is a command that will find the 20 largest files in your git repository (source):
git rev-list master | while read rev; do git ls-tree -lr $rev  | cut -c54- | sed -E 's/^ +//g;'; done  | sort -u | perl -e 'while (<>) { chomp; @stuff=split("\t");$sums{$stuff[1]} += $stuff[0];} print "$sums{$_} $_\n" for (keys %sums);' | sort -rn | head -n 20

# Case B: Deleting a file that contains a password
# You can grep the history for the password and find the file that contains it:
git grep -i 'mypassword' $(git rev-list --all)

# Case C: Deleting entire deleleted directories
# To get a list of entire directories that have been removed from the repository:
git log --all --pretty=format: --name-only --diff-filter=D | sed -E 's|[^/]+$||g' | sort -u

# Step 3: Rewrite history and remove the old files
# Replace FILE_LIST with the files or directories that you are removing.
# Remove FILE_LIST from all commits, then remove the refs to the old commits
# (repeat these two commands for as many directories that you want to remove)
git filter-branch \
  --index-filter 'git rm -rf --cached --ignore-unmatch FILE_LIST' \
  --prune-empty \
  --tag-name-filter cat \
  -- --all

# I'm not sure what this does...
git for-each-ref --format="%(refname)" refs/original/ |\
  xargs -n 1 git update-ref -d

# Step 4: Prune all references with garbage collection and reclaim space
# Ensure all old refs are fully removed
rm -rf .git/logs .git/refs/original

# not sure if this is necessary
git reflog expire --expire=now --all

# Perform a garbage collection to remove commits with no refs
git gc --prune=all --aggressive


# Step 5: Verify they have been removed
# Run the same command that you used to in step 2 to verify that your removed files are no longer in history.

# Step 6: Push the history changes
# Force push all branches to overwrite their history
# (use with caution!)
git push origin --all --force
git push origin --tags --force

# check the size of the repository before and after:
git count-objects -vH

# Step 8: Everybody must rebase and prune
# All users must get the alter history and prune their own copies of the repository. Tell your coworkers and teammates that have clones of this repostory to run the following:
cd MY_LOCAL_GIT_REPO
git fetch origin
git rebase
git reflog expire --expire=now --all
git gc --aggressive --prune=now

# or if they have no work outstanding commits, they can just set their repository to mirror the origin rather than rebasing (WARNING: destroys anything not pushed!):
cd MY_LOCAL_GIT_REPO
git fetch origin
# WARNING: can destroy unpublished data!
git reset --hard origin/master
git reflog expire --expire=now --all
git gc --aggressive --prune=now
