#!/bin/bash

# working with git

# useful resources:
# http://rogerdudler.github.io/git-guide/
# http://pcottle.github.io/learnGitBranching/

# create a folder
mkdir git-practice-3

# navigate into that folder
cd git-practice

# make it monitored by git:
git init

# Add all the files to git's monitoring (the . means all files)
git add .

# make a file
touch README.txt

# commit those changes. The -a adds anything that's changed since the last version.
git commit -a -m 'I edited the README file'

# Add the URL for the remote repository:
git remote add origin https://github.com/jimmyodonnell/git-practice.git

# Verify the new remote url
git remote -v

# update the remote version (in this case, the files as stored on github -- 'origin')
git push -u origin master
# the -u argument is important! It makes sure that that branch on your computer tracks the version on the server ('origin')

# create a file in your directory
touch file.txt

# add it to the git repository and commit that change.
git commit -a -m 'added file.txt'

# update the remote version (in this case, the files as stored on github)
git push origin master

# remove the file from the git repository AND ALSO delete it from the local file system.
git rm file.txt
git commit -m "remove file.txt"

# To remove the file from the repo and not delete it from the local file system use:
git rm --cached file.txt


# make a new branch and switch to it:
git checkout -b newbranchname

# push the branch to github
git push -u origin newbranchname

# show all branches
git branch

# delete a branch (locally - on your computer)
git branch -d the_local_branch

# Add a new remote for your branch :
git remote add [name_of_your_remote]

# Push changes from your commit into your branch :
git push origin [name_of_your_remote]

# Update your branch when the original branch from official repository has been updated :
git fetch [name_of_your_remote]

# Then you need to apply to merge changes, if your branch is derivated from develop you need to do :
git merge [name_of_your_remote]/develop

# Delete a branch on your local filesystem :
git branch -d [name_of_your_new_branch]

# To force the deletion of local branch on your filesystem :
git branch -D [name_of_your_new_branch]

# Delete the branch on github :
git push origin :[name_of_your_new_branch]

# check which files are different between two branches before you merge:
git diff --name-status master..branchName

# Before merging one branch into another, you can check whether there will be a ton of conflicts:
git merge --no-commit --no-ff $BRANCHTOBEMERGEDINTOCURRENTBRANCH

# This will allow you to examine/undo the merge, even if it is a fast-forward merge:
git merge --abort

# rename a file :
git mv oldname newname




# check if your local branches are up to date with those on the server (remote)
git remote show origin

# GOING BACK IN TIME! aka OOPS!
# view an old version of a file (e.g. the 4th most recent commit of the_file.c) 
git show HEAD~4:git_subdirectory/the_file.c

# view an old version of a file by date
git show HEAD@{2016-0510}:./fileInCurrentDirectory.txt

# revert to an old version of a file:
git checkout <commit-number> filename.txt
git checkout HEAD~4 filename.txt

# view the changes made since an old version
git diff <commit-number> filename.txt

# ways to revert a specific file to that commit
git reset <commit-number> filename.txt
git checkout <commit-number> filename.txt



# When you sit down to work at the work computer, first thing:
git pull origin workingbranch
# or
git pull origin master
# This updates the local repository to reflect changes that have happened to the copy on the server





# FORKED REPOSITORY
# Scenario: You fork a repository from someone else's github to yours.
# They make some changes, and you want to incorporate them.
# To do so, you need to set that *original* repository as the 'upstream' remote
git remote add upstream https://github.com/ropensci/taxize.git

# then download any changes that have been made
git fetch upstream

# and incorporate the changes from one of the remote brances into one of your local branches
git merge upstream/master master



# undo the last merge
git reset --hard HEAD~1

# undo/go back to three commits ago:
git reset --hard HEAD~3

#change global configuration to me
git config --global user.name "Jimmy O'Donnell"

#change global config to my email
git config --global user.email "jodonnellbio@gmail.com"

# change color settings
git config --global color.ui "auto"

# change your default text editor
git config --global core.editor nano

# set up a file listing which types of files git should ignore.
# make a text file containing each name (e.g. .DS_Store), one to a line
# save this file as '~/.gitignore_global'
git config --global core.excludesfile '~/.gitignore_global'

# check settings
git config --list

# make a directory (my_dir) into a git monitored repository
cd new_dir
git init

# check status
git status

# if a new file is added at this point, git won't automatically monitor it.
# to get git to monitor a file,
git add new_file.txt

git diff


git pull origin master

# !!!!!!!!!!!!!!!!!!!!!!!
# Can get a DOI for a specific git commit


# If you wish to set tracking information for this branch you can do so with:
git branch --set-upstream-to=origin/<branch> master

# Merging via command line
# If you do not want to use the merge button or an automatic merge cannot be performed, you can perform a manual merge on the command line.
# Step 1: From your project repository, check out a new branch and test the changes.
git checkout -b vlahm-master master
# if it already exists: git checkout vlahm-master
git pull https://github.com/vlahm/R_tips.git master

# Step 2: Merge the changes and update on GitHub.
git checkout master
git merge --no-ff vlahm-master
git push origin master
