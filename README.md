# FOCS Assignments

This is the base repo for FOCS assignments.

Assignments must be submitted by pushing to GitHub before noon on the day of the class in which they are due to be considered for credit. We will review work from assignments on that day, so it is not practical to get behind. You are allowed one "free pass" missed submission with no questions asked.

## Get Started

Fork this repository to your personal GitHub account by clicking the "Fork" button in the upper-right corner of the page.

Clone your copy of the repository to your laptop to work on by running the following commands (be sure to replace the username with your own). These instructions assume that you want to put the assignments directory in your home directory (~). If not, make sure to modify the first line to change to the directory where you want your assignments to reside.

```
$ cd ~
$ git clone https://github.com/YourUsername/focs-assignments.git
```

## Submitting Completed Assignments

Once you have completed your assignments, you can turn in your work by running the following commands. First, make sure you have saved the files. Then, run:

```
$ cd ~/focs-assignments
$ git add -u
$ git commit -m "Turning in my assignment for day X"
$ git push origin master
```

You will then be prompted to enter your GitHub username and password. Assuming you followed all of the instructions outlined above, that's it!

## Downloading Future Assignments

We will continue adding assignments to the original upstream class repository. These will not show up in your forked copy unless you explicitly pull them in.

### One Time Setup: Add Upstream Remote

On your laptop, you should have a cloned copy of the `focs-assignments` repository from your GitHub account. You can verify this by checking its remote repositories:

```
$ cd ~/focs-assignments
$ git remote -v

origin  https://github.com/YourUsername/focs-assignments.git (fetch)
origin  https://github.com/YourUsername/focs-assignments.git (push)
```

We want to keep `origin` (the cloned copy in your GitHub account) for you to push completed work to, but we also want to add the original upstream class master repository for you to pull new assignments from. We can add this additional remote by running:

```
$ git remote add upstream https://github.com/focs16fall/focs-assignments.git
If you run git remote -v now, you should see both origin and upstream listed.
```

### Pull New Notebooks from Upstream

Each time you want to grab the latest assignments, you should first first make sure all your recent work is committed. This is just to form good habits - each new assignment will be its own file(s), so there should not be any conflicts. Next, run:

```
$ git pull upstream master
```

This should pull in the latest assignment, which you can then complete and push to your origin repository by following the usual submission instructions above.
