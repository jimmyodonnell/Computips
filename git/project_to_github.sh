# 1. Create a new repository on GitHub. To avoid errors, do not initialize the new repository with README, license, or gitignore files. You can add these files after your project has been pushed to GitHub.
# let's call it "my_new_project"

# 2. Open Terminal.

# 3. Change the current working directory to your local project.
cd ~/path/to/the/project_folder

# 4. Initialize the local directory as a Git repository.
git init

# 5. Add the files in the local repository and stage them for commit. To unstage a file, use 'git reset HEAD YOUR-FILE'.
git add .

# 6. Commit the files that you've staged in your local repository.
git commit -m "First commit"
# To remove this commit and modify the file, use 'git reset --soft HEAD~1' and commit and add the file again.

# 7. At the top of your GitHub repository's Quick Setup page, click to copy the remote repository URL. (should be under "Quick setup — if you’ve done this kind of thing before")
# e.g. https://github.com/your_github_username/my_new_project.git

# 8. In Terminal, add the URL for the remote repository where your local repository will be pushed.
git remote add origin https://github.com/your_github_username/my_new_project.git
# Sets the new remote
git remote -v
# Verifies the new remote URL

# 9. Push the changes in your local repository to GitHub.
git push -u origin master
