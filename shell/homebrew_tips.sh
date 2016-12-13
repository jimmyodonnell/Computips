#!/usr/bin/env bash

# Homebrew installs packages to their own directory and then symlinks their files into /usr/local.
# install homebrew:
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# Tip #1: Update Your Homebrew
# You want to always ensure that you’re running the newest version of Homebrew and that it has the newest list of formulae available from the main repository. This is done with the “brew update” command:
brew update
# Already up-to-date.

# Tip #2: Know What You Have Installed
# The problem with a package management tool is that it can cause app-creep, as new and wonderful software gets downloaded to your Mac, and then never gets used again. So, every once in a while you should type “brew list,” which will show everything installed on your machine with Homebrew:
brew list
# lynx	openssl	wget

# As usual, you can then use “brew info [package]” to get more info on an individual package:
brew info wget


# Tip #3: Uninstall Unused Software
# If you find software that’s outdated, it’s easy to get rid of it. You just “brew uninstall [package]” and the software disappears:
brew uninstall wget
# Uninstalling /usr/local/Cellar/wget/1.15...

# Unfortunately, uninstalling a package will not uninstall its dependencies, so you’ll need to do that by hand, one package at a time.
# Be sure that you’re not uninstalling something used by another package, as Homebrew won’t protect you from doing so.

# Tip #4: Check Your Used Software
# One of the coolest elements of package management software is that you can use it to constantly keep your installed software up-to-date. There’s no remembering where you grabbed software from and then hunting down updates. Instead, you can automatically update everything with just a few commands.
# It’s safest to start out by seeing what’s out-of-date. You want to “brew update” first to make sure your listings are up-to-date, and then you can “brew outdated”.
brew outdated

# This command is purely information; it’ll just show you what could be updated.



# Tip #5: Update Your Out-of-date Software
# Once you’ve seen what’s out-of-date, you can then update everything that was installed by Homebrew with a simple “brew upgrade” command:
brew upgrade

# You may not want to upgrade certain packages, however, because they’re too important or because you need to keep using an older version of the software. In this case, you should protect the older software by “pinning” it, so that it won’t be upgraded. The following command would keep MySQL at its current version:
brew pin mysql

# You can then run “brew upgrade” and everything but your pinned packages will be updated. At some point in the future you can choose to “brew unpin [package]” to unprotect the package in question.

# If you prefer to instead only upgrade specific packages, you can do that by using the “brew upgrade” command selectively on packages that are outdated. The following command would only upgrade the wget package:
brew upgrade wget

# Tip #6: Take Control By Tapping Other Repositories
# The above tips all presume that you’re in sync with Homebrew’s master repository. However, sometimes you may want to access other repositories that include other packages. This is done with the “brew tap” command.
# You can find a list of interesting brew taps here: https://github.com/Homebrew/homebrew/wiki/Interesting-Taps-&-Branches.
# If you want to access a tap, you can do so like this:
brew tap homebrew/science

# You can then install directly from the new tap with the “brew install [package]” function.
# You’ll probably want to keep your brew taps up to date too, so that you don’t inadvertently install things from taps that are old and out-of-date. You can always use “brew tap” to see the current list of taps that you’re accessing. You can choose to “unsubscribe” from a tap with the “brew untap” command:
brew untap homebrew/dupes
Untapped 39 formula