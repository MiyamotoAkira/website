---
title: Plugins for file navigation sidebars
Date: 2019-10-27 05:00
excerpt: I have been using NeoTree for a while. Time to look at alternatives
tags:
- Emacs
---

I've been a user of [Neotree](https://github.com/jaypei/emacs-neotree) for a while. I don't use it that much, only ocassionally. And when I use it, I haven't paid enough attention to learn correctly the keybindings. But why I don't use, it? Is it because I don't need it on my current flow? Maybe `C-x C-f` is enough?. As it happens, recently [Bozhidar Batsov](https://twitter.com/bbatsov), asked a [question](https://twitter.com/bbatsov/status/1185779487235084288) about alternative sidebars.

## Disclaimers
I use Emacs exclusively from the GUI, which could make a difference in how you evaluate the tools yourself. Don't use projectile as much as I should. I use vanilla GNU Emacs with my own modifications. I don't consider myself an emacs expert, and see things through the `please-make-it-simple` glasses. Also, my opinion is my own, and could be deeply flawed.

## The Contenders
The contenders for sidebar that I am evaluating are five:
- [Project-Explorer](https://github.com/sabof/project-explorer)
- [Treemacs](https://github.com/Alexander-Miller/treemacs)
- [Neotree](https://github.com/jaypei/emacs-neotree)
- [Dired-sidebar](https://github.com/jojojames/dired-sidebar)
- [Ranger](https://github.com/ralesi/ranger.el)

Why those five? Neotree was the one I have, Dired-sidebar is the one Batsov asked about and the rest are from the answers. (In fact, I was going to have only four but I saw [John Stevenson](https://twitter.com/jr0cket) singing the praises of Ranger, so I added it to the list). Luckily, I can have 5 variations of pressing [f8].

## Popularity
Popularity should not be, in general, why you choose a tool, but is a datapoint for your decision. As of 2019-10-26, downloads on Melpa are:
 - Project-Explorer = 8,740
- Treemacs = 76,773
- Neotree = 398,616
- Dired-Sidebar = 5,744
- Ranger = 37,296

## Installation
All are in Melpa, which is good. Neotree doesn't have instructions for `use-package`, but is a single package to install. Project-Explorer has no instructions at all. Ranger doesn't give an example. Treemacs is a bit confusing, as they show a full-fledge example and seems to require so many things out of the bat (which is not the case). Finally, Dired-Sidebar has easy sample (both for `use-package` and for manual install). It also provides a simple settings example.

## First Impressions

Neotree opens on the same folder where the file on my buffer is located. Simplistic icons, not separated by type

Treemacs asked me on the first which folder I wanted to use and which was the root of the project. After that it did not ask me again, even if I moved to a buffer which file was in a completely different tree. At least comes out of the bat with nice icons. Orders the files and folders purely alphabetically (*nix way)

Dired-Sidebar, for some reason the binding didn't work. Opened on the root of the project, but with the current buffer file highlighted. No icons whatsoever. Unlike Treemacs, it changes the root based on your active buffer.

Project-Explorer was noticeable slower than the others when opening the buffer the first time. No Icons. Opens the file using a Windows style organization (directories first, case matters for ordering). The same keybinding to show the buffer doesn't work to close the buffer. It repositions the cursor to it.

Ranger has a baffling behaviour: completely rearranges your windows, opening three new vertical windows. Two with directory data, and your active buffer. And as with Project-Explore, the close command is different from the opening. No Icons.

## Notes on the first impressions

So a few notes on what I said so far.

There is a package called [All-the-icons](https://github.com/domtronn/all-the-icons.el) that can be used with Neotree and Dired-Sidebar. On a quick check neither Project-Explorer nor Ranger seemed to support this (is possible that they do)

Treemacs has a plugin to link with projectile. But activiting projectile mode doesn't seem to change the root of the directory when opening treemacs. It seems to be a conscious decision, I am not especially interested in this behaviour (at the moment). Somehow reminds me of workspaces on Eclipse, which I don't like.

I don't want my frame to be rearranged. The sidebar is fine. The rest of what Ranger does, no thank you.

I was for years a windows user and, therefore, I am used (like?) directories at the top. But I am not specially precious with it.

## Navigability

One of the great things of Emacs is that you can reconfigure all keybindings. I love that flexibility. All of them seem to be using `n` and `p` for the basic movement up and down. Except for Ranger, that operates directly in [evil](https://github.com/emacs-evil/evil) mode, it seems. Dired-Sidebar, Neotree and Treemacs have the possibility to switch to evil mode.

## Features

All of them have a set of features that don't overlap. I would recommend you to check it. Neotree seems to have the least. Project-Explorer is the only one that seems to have Helm support. Dired-sidebar and Treemacs operate with Ace-Window and projectile. Neotree also seems to be able to work with projectile.

## Decisions?

Maybe I should use them for a bit longer. But, again, is not something that I use a lot, mostly when I want to show someone else something. Most of the time I rely on `C-x C-f` and [ag](https://github.com/Wilfred/ag.el) to move around. Still, the little I saw of dired-sidebar I liked.

