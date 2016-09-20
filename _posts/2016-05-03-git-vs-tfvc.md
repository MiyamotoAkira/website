---
title: Things that I can do on git that are a pain (or impossible) on tfvc
date: 2016-05-03 23:40:00
excerpt: There are a few things that are possible on Git that are not allowed by TFVC. Here I will show some of those behaviours.
---

## The Setup

One week ago I got into a discussion on why someone would move from TFVC to Git. On a instinct level, I know that Git is the far better option. But the question put forward was why it was better. Does it improve productivity? It is difficult to put numbers on this. How you calculate productivity? How do you calculate how does it affect productivity? I have not found any one giving any kind of statistics.

I only have few numbers to offer, though I can show quite a few possibilites that are available on Git, but not on TFVC (I haven't found anything that is available on TFVC that you couldn't replicate with Git). The other thing that I can talk about, is that introduces some changes on the programming culture regarding branches and commits

## The Comparison

### The Core

As its core, this about comparing a CVCS against a DVCS: full consistency against eventual consistency, always online vs online on demand. Some of the differences that you will see over here are based on those two reasons. But are not the only ones (see below for the differences in approach). One of the biggest differences is having the Team Project as the root of everything on TFVC vs having the commit as the center of all work on Git.

TFVC was designed as a general tool for business based on Visual Studio and Windows systems. It was a more powerful replacement for Visual SourceSafe. There is a SqlServer database behind. It can only be used on Windows systems. It creates workspaces that are assigned per computer per user. You map folders on team projects to locations in the hard drive. To paliate some of the issues with being online all the time, a Local Workspace format was created, while the previous way of working was renamed Server Workspace. Finally, TFVC only exists inside TFS, and is deeply integrated to it.

Git was originally designed to satisfy the needs of Linux Kernel development. It uses the filesystem as a repo. It relies exclusively on the command line (even when there are third party GUI tools). It can run anywhere where the git command line has been compiled for, which right now means at least all Linux systems, BSD systems (including MacOSX) and Windows systems. There is no kind of mapping between a possible git server, and your hardrive. The concept of workspace is segregated to a single repository, but even if I just called it workspace, there is basically no relationship with the workspace concept on TFVC.

There is a bit more of workspaces talk [here](#workspaces)

### Usage

TFVC seems to have been originally designed to be used on Visual Studio. I know of only one other person that me that has used the command line at all. With TFVC, if you use the SourceControl explorer and commands inside Visual Studio, all changes will be recognised. Trying to use the command line is a bit more complicated. First, it doesn't get installed by default on the path. You either invoke the developer command prompt or add it into your path. Furthermore, you will need to run for some commands on an elevated prompt (I though maybe it was something related to being a centralized system, but then, that is why you have credentials). Changes that you do on the file system will not be recognised. TFVC will not show you that those changes have taken place in the command line (though if you are using a Local Workspace Visual Studio will show them). Of course, as long as you are dealing exclusively with Visual Studio projects, it will know which files needs to keep track of, and which not. If you have to deal with non-VS solutions ... it becomes more complicated.

Git was designed to be used from the command line and to have an involved relation with the file system. Any change done on the file system will be acknowledged by Git, indicating that changes have been done on the repo. Once you install git, is automatically available on the terminal/command prompt without the need to have elevated privileges. Because is not tied to an IDE it can deal very easily with any kind of project. You will have to provide gitignore files, though, to make sure that unneeded files are not being tracked.

A small interesting point, TFS will be happy to track empty folders. Git, on the other hand, only register files, and their path, so an empty directory will not be acknowledged by Git.


### Changes

Centralized vs Distributed make a big difference to the way that changes are recorded. Because on the centralized architecture of TFVC the commit goes immediately to the server it cannot be modified. Comments can be modified, but the changeset itself is absolutely immutable. Of course, they could have still chosen to allow some way to modify the changeset. 

Git does instead allow you to modify commits. First time I came across this I didn't like it. But that dislike came more from meeting the unknown than from the idea actually being bad. Because of this facility there are options available to the developers that are not available on TFVC. A couple are shown below.
    
* Squash
	
	With [git rebase --interactive](https://git-scm.com/docs/git-rebase) you can squash commits together. That it is, create two or more commits, and before you push them to the server, you can merge them together, as if they were one single commit the whole time. This ability favours the use of small commits on your repo, collating together commits a later point if deemed necessary. The small commits culture, I've found, make it much easier to do some [exploratory coding](#exploratory-codingrefactoring), as it becomes less painful to drift slightly to try to improve your code and discard if the route is not good enough. 
    
* Ammend 
	
	Before you push a commit to the server you can ammend the commit with [git commit --ammend](https://git-scm.com/docs/git-commit). Not just the comments, like with TFVC, but also files, adding or changing files. That is it, you have made a commit, you discover a typo, or maybe you decide to change the name of a class/variable/function, and you can do over the last commit, as it from the beginning that was the one chosen. This ability reduces the number of correction commits, which are, on themselves, waste.


First number I can give comes here. When trying to undo pending changes on your code, TFVC will need to contact the server. I usually see timings north of 5 seconds, with 10 not being unusual. Git, on the other hand, as it only has to deal with it on the computer where you are working, does that well below 2 seconds. In fact, even on Local Workspace, with TFVC you need to keep calling the server constantly, which means that for every operation there is a small delay.

### Searching for information

There are a few advanced scenarios for information retrieval that you can do on Git that I haven't found possible on TFVC.

* Bisect

    This is one of those marvelous little helpers, that you will not use often, but when it is needed is a life saver. [git bisect](https://git-scm.com/docs/git-bisect) will allow you specify an initial good commit, an initial bad commit, and through the use of a  binary search it will allow you to find at which point the code went from good to bad. It is very useful when you introduced a mistake into the system and not only need to fix it, but to know how long has been in place.
	
* Blame

	Very unfortunate name (does it has anything to do with the type of person Linus is?). With [git blame](https://git-scm.com/docs/git-bisect) you can get the name of the last person to modify every single line of code. Git, being what it is, has alternative ways to find it, throught the use of the multiple options of log.

### Workspaces

This is a concept of TFVC. A workspace is a collection of folder/branches mapped to local folders. A workspace is linked to a single combination of machine/username. The local folder can only be mapped to a single workspace. If your computer blows up, TF will still have the workspace linked. If the machine is redone with the same name, then you will not be able to remap, because there is a mapping already there. If you are given the machine of another person, that person didn't remove its mappings and you are using a common structure (antivirus purposes, standarization), you can not do your own mapping, you will need an admin to delete the previous person workspace. 

Its handling of issues has improved from TFS2012. If you are working with a local workspace and you delete a file outside of VS, it will allow you to redownload the same version of the file. If you are on a server workspace, it will not allow you to delete files outside of VS (well, you could and then you will have issues trying to get it sorted).

I must talk about both type of workspaces here. Server workspace keeps the full control of the mapping on the server side. That means that no changes can be done without a full trip to the server. This means that offline work is not possible (or quite difficult). To facilitate offline work, recover from deleting by mistake and supposedly Visual Studio should detect changes done outside, though a couple of tests didn't seem to work. Of course, there are issues with Local workspaces. The first, the more items you have mapped, the worst performance you get, with a limit of 100k items, after which it will start throwing you errors. The limit is established by the workspace. I think TF2012 had the limit around 50K, which I have reached in a few occasions. The second, and most insidious, is [TF400030](https://duckduckgo.com/?q=tf400030&t=ffsb). This is an error where there is a lockup of resources. When dealing with files on the workspace, TFVC will lock the files. The problem is that having two instances of Visual Studio open will make them compite for those locks. Even worse, a single instance of VS open with both the Source Control Explorer and Solution Explorer could produce the same issue. The timing out for the try of getting hold of the lock is 45 seconds. Which means that VS will be locked for those 45 seconds. There hasn't been a fix for this issue. I have read people recommending to just go to server workspace. Personally, I have two or three instances of Visual Studio with different solutions opened quite usually. In a SOA, you will need to have them open.

Git, because it doesn't use have centralized information, doesn't care. You can have multiple downloaded copies of the same repository. More important is the fact that if something goes wrong with your mapping, because it is not registered anywhere, there will be no issue. Download/Clone and move on. There is no lock. You will end having degradation of performance with a big repo size (on the Gbs of data). Chosing the right segmentation of repos does help on never encoutering the problem (I haven't work on a system big enough to introduce any significative delay).


### Branches

Conceptually, I think this is where the different approach tilts massively the balance in favor of Git. Branches on a more flexible, lightweight constructs, that what you find on TFVC. In fact, a branch is just a pointer to a commit. Branches on Git are, in its concept, shortlived, though you can leave branches actives for long periods of time. Branches on TFVC are more involved, requiring new entries into the Sql Server backing TFVC. Furthermore, branches on TFVC are perennial. You can't fully delete branches, they are just marked as non-visible. One last important point: On Git, all branches, because they are just points to commits, are connected. It is the famous DAG (directed acyclic graph) of Git, which allows for some advanced scenarios. On TFVC branches are completely separated entities, with an initial point that is common, but their history is completely separated once the branching happens (though there is some linking once you do a merge).

* Shelvesets

	In a few places I have read that Git doesn't have shelvesets. I couldn't disagree more. It is the equivalent to saying that C++ doesn't have interfaces, just because there is no interface reserved word.

	Shelvesets on TFVC are a snapshot of some changes done, saved on the server. They are quite useful to be able to do some exploratory coding that you can either ditch or retake later. I have used them in the past as well as temporary backups for the work that I am doing when I'm leaving work at the end of the day. But you work on some code, create a shelveset, at a later point you or someone else want to do additional work, and have to create a new shelveset, without information stored. 

	Git doesn't have shelveset per se. It has, though, two different options. If you don't need to save on the server, or don't need to record at this point a commit, you can stash the changes. While shelvesets can be applied by anyone on their workspaces, stash are only available in the computer where the stash was created. If you want to store changes on the server (or you want to keep history), what you do is create a separate branch. Because is a branch that you are saving, you can easily continue working on or merge back, with whole history of changes.

* Cherry Pick

	Baseless merge (which are merges between branches that are no related on first degree) are sometimes needed. On TFVC, the general recommendation is don't. Because changesets on different branches are not related, TFVC has to do far more to try to merge two branches. On Git, though, they are not problematic, as the DAG will be easy to traverse and check what are the differences between the branches. To help things even further the [git cherry-pick](https://git-scm.com/docs/git-cherry-pick) command will allow you to select which commits from one branch you want to apply to another branch without going through a merge. 

### Reviews

Because of the way that TFVC works, code reviews are done on changesets (which they could be the ones done on your special branch, or on your main branch after a merge). If there is any issue, you need to create a new changeset with the change, and then start a new code review. This form of code reviews is slow, confusing and wasteful.

Git doesn't indicate, as far as I know, how to do code reviews. But the concept of Pull Request appeared (which is included on Git on TFS) at some point. The code review then happens at this stage, when you want to merge, instead of doing it on changesets. The best improvement is that you can keep adding commits to the pull request, as comments on your code are given, keeping all centralized on that pull request, without having to chase on separate changesets the comments.

Stopping your work to do code reviews for another developer is a costly context switch. Having a flow that makes it easier, eliminates some of the pain.

### Exploratory coding/refactoring

And here the difference shows the most, on my view (the length of the section is not proportional to the importance). All the different things that I have mentioned before (plus a few others) means that any kind of exploratory coding or refactoring is much easier with Git. I can jump back and forth my working branch and my refactoring branch. I can easily merge them together if I think it is worthy. I can keep track of history while sharing with others.

I'm more reticient to do this kind of exploratory work on TFVC. And, when I do, the source control is working against me.

I cannot put numbers over here. I cannot specify my productivity has gone up X. I can say that it does go up, and it is not marginal.

## Cost

What is the cost associated with moving from TFVC to Git? If you stay inside TFS, there are only two costs: both involve time.

First an introductory session for those people that do not know Git yet. As much as the documentation is still confusing, and some of the commands are not very intuitive, the default flow of clone, fetch/merge, branch, commit, and push is relatively easy. Some additiona time will be needed for some advanced scenarios.

Second, Microsoft provides a tool called git-tf, which allows you to clone a TFVC repo on your computer as if it was a git repo, with full history. Then you need to create a Git repo on TFS, point the remote to it, and push it. Done. 10 minutes per project if you are slow. Rinse and repeat for all your projects.

Maybe you want to automatise the transfer of your collections. VSO has a Rest API that you can use to programatically setup this all this. TFS (on premises) doesn't seem to have this Rest API, but still provides an API through a set of libraries for .Net. This could be quite effective if your collections and team projects are set up just right. Though on the ocassion that I was lucky to be part of this migration, we end restructuring some of the team projects.

You have to be careful, though, regarding branches. On TFVC there are completely separate entities. So you will be migrating a single branch into a Git repo. You will want that to be your main branch, and probably do it at a point in which there are no active branches on development. You could still fiddle your way around the current branches, adding their files to a new branch of your git repo. Because git tracks files, it will be able to detect changes introduced in them and add them, though this way you could loose some history from th TFVC branch.

## Conclusion

Git provides far more flexibility and power than TFVC. Although you will want to plan your migration, I believe that your development process will improve through the use of Git

Let me finish with one last thought: As soon as you have more than one person on your team, you are already working on a distributed manner. You should choose the version control designed for it.
