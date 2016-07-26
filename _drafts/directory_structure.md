---
title: Directory structure and F# projects
date: 2016-01-04 22:00:00
---

# The current situation

For a while I've been using Golang's directory structure for my default directory structure. Well, under a code directory, as I always liked to have a code directory.

So under home/ I have code/ then inside src/, bin/ and pkg/. Of course, Golang likes to have the location of the remote as a subdirectory, e.g. github.com/ and inside the account. e.g. miyamotoakira/

I started that when I was investigating Go. Bbut, as it happens, I did not continue with Go. Yet the directory structure remained. You know, you do some change, and you never go back to revisit it.

# The catalyst

I was trying to create an FSharp application to investigate code that is stored on Visual Studio Online. Because right now I'm using a lot emacs (this is being written on it), I looked and, sure enough, there was an fsharp mode for it.

The annoying part is that fsharp mode depends on the existence of an fsproj file to be able to do part of its work. Have you looked at a fsproj (or csproj for that matter?) lately? They are stuck in the past (well, not really, they are stuck in Visual Studio land). There are this massive (for the information that they actually contain) xml configuration files.

They are required by msbuild. As long as you are working inside Visual Studio (or Xamarin), you barely interact with them. Actually, they serve two functions: to provide information for MsBuild, and to provide information for the IDE


