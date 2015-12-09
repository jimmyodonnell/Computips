# Source: http://stackoverflow.com/questions/161813/fix-merge-conflicts-in-git

# Here's a probable use-case, from the top:

# You're going to pull some changes, but oops, you're not up to date:

git fetch origin
git pull origin master

From ssh://gitosis@example.com:22/projectname
 * branch            master     -> FETCH_HEAD
Updating a030c3a..ee25213
error: Entry 'filename.c' not uptodate. Cannot merge.

# So you get up-to-date and try again, but have a conflict:

git add filename.c
git commit -m "made some wild and crazy changes"
git pull origin master

From ssh://gitosis@example.com:22/projectname
 * branch            master     -> FETCH_HEAD
Auto-merging filename.c
CONFLICT (content): Merge conflict in filename.c
Automatic merge failed; fix conflicts and then commit the result.

# So you decide to take a look at the changes:

git mergetool

#Oh me, oh my, upstream changed some things, but just to use my changes...no...their changes...

git checkout --ours filename.c
git checkout --theirs filename.c
git add filename.c
git commit -m "using theirs"

# And then we try a final time

git pull origin master

From ssh://gitosis@example.com:22/projectname
 * branch            master     -> FETCH_HEAD
Already up-to-date.

# Ta-da!