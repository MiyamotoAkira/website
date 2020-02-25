---
title: Multiple SSH configuration git
date: 2020-02-25 05:00
excerpt: How do we handle separate SSH key
tags:
- git
---

Finally!, Finally!!!, I went and finished this investigation. Therefore, let's gonna document it for the future (next time I need to do it, because chances are I will have forgottent all about it).

# The Setup

I don't think this will be strange to most people reading this blog, but I have my personal accounts both on Github and Gitlab. On both I have setup SSH keys, instead of using HTTPS. In fact, every combo user/machine that I have/use has a different SSH key. I don't reuse SSH keys. For each machine I have added them to the ssh `config` file for performance purposes (my understanding is that if there is no specific entry on the ssh `config` file, git will check every single key within the `.ssh` directory until it decides to give up or the server said you tried too many times). When I have to go to a client, sometimes I need to create a specific user for that client, and because the user for using ssh with git is always the same(`git`) then I had issues as I couldn't keep both ssh keys together. Started to do the research sometime ago, convinced that there had to be a solution, went like 90% of the way, left it on the side, and now I have added the last 10% to have it working.

# SSH Config

The `config` file for ssh (on *nix systems), is relatively simple.

The beginning of an entry is the `Host` line. That gives the name of the host for which the entry is used. For example `github.com` 

Then you can add multiple config options within the entry. The basic one that you want to use is `IdentityFile` which is the path to the ssh key that you want to use for that entry.

You have the `User` entry when you want to indicate which user is the one for which this configuration is used. So if you have multiple users for the same host, you could use this to differentiate. For git is not that important, because the user is always `git`.

The other one that you want to use is `HostName`. This indicates the real name of the host.

# The confusion

That last part is what I didn't understand correctly. If you don't have `HostName`, then the entry `Host` is the host name, but if you have `HostName` then `Host` becomes  more like a synonym, and it is used to match against the host name passed as an argument.

Which is at the point where I want to tell myself off. Have I used this synonyms before to do remote ssh sessions into machines (hello, my Raspberrian Pies), given then whatever nickname I wanted. Of course I have! But did it click that I could do the same on git? No, I was just using straight up the location given by GitHub or GitLab (ok, they make it easy to just copy the address for cloning and you don't think twice about it.

# Example

Let's use an example

```
Host github.com-personal
	HostName github.com
	User git
	IdentityFile ~/.ssh/github
```

Imagine that I want to clone my `.emacs.d` repo. If I just click copy on the web interface and then I write `git clone git@github.com:MiyamotoAkira/.emacs.d.git` But that will not use that entry. It will try entries that are on the ssh-agent or on the .ssh directory.

But if I do `git clone git@github.com-personal:MiyamotoAkira/.emacs.d.git` then it will use the entry that I configured. Which was the part I missed before. That the section after `@` is just your identifier for the host. If you want to call your host `theincrediblemachine` your will change that to `git clone git@gtheincrediblemachine:MiyamotoAkira/.emacs.d.git`

Easy (well, not while researching)

# More Information

I have only scratched the surface of SSH. You can read far more about SSH at their [website](https://www.ssh.com/ssh/config).
