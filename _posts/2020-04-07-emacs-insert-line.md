---
title: Adding insert lines to Emacs
date: 2020-04-05 04:00
excerpt: Why and how I have added functionality to insert lines
tags:
- Emacs
---

I tried [evil-mode](https://github.com/emacs-evil/evil) twice. Second time more prepared. Still, I found too many issues with maps, with the buffers where it should be active or not, keybinding classes with every single package that I have installed, configuration in general.

I do consider the [vim](https://www.vim.org/) keybindings slightly superior, and still have it activated on [VsCode](https://code.visualstudio.com/), for example ([LiveShare](https://visualstudio.microsoft.com/services/live-share/) is too good, sadly, to ignore). But the annoyances on Emacs where too much. And although I am fine with trying things and adapting Emacs to my liking, there is only so much time I can dedicate to a single system.

So I went back to "vanilla" Emacs (with all my other packages)

# The missing functionality

But quickly I discovered that I was missing something: `o` and `O`. Which in vi/vim creates a line below the point, or above the point.

Although they were not 100% perfect, they did a good job.

One thing that I discovered long time ago is that I will start writing some code and then realized that I needed to leave an empty blank line above or below the code that I was writing. `o` and `O` are not perfect because they change you into `INSERT` mode. And sometimes you want to create the line but keep the point where you were.

In Emacs you have `open-line`, binded to `C-o`. Which basically is using `Return` in the middle of a line for any other editor. It creates a new line, moves everything after the point to the new line, and then moves the point to the first character of the new line. This is not what I wanted.

You could use `C-a RET` and `C-e RET`. The former is going to the beginning of the line, add new line above and keep the point on the line you were. The latter is going to the end of the line, adding a new line below, and moving the point to the new line. I dislike inconsistency.

So, time to investigate how to replicate the functionality on Emacs.

# The initial solution

The beginning of my solution comes from this answer from [Basil](https://emacs.stackexchange.com/users/15748/basil): [insert-line-above-below](https://emacs.stackexchange.com/questions/32958/insert-line-above-below) on the Emacs StackExchange.

```elisp
(defun insert-line-below ()
  "Insert an empty line below the current line."
  (interactive)
  (save-excursion
    (end-of-line)
    (open-line 1)))
```

Investigating a bit what we have here is:
- `defun insert-line-below ()`. `defun` is a macro that creates a new function with the name pased as the first argument and arguments passed as the list that is the second parameter. So here we have a new function defined called `insert-line-below` with no parameters.
- Then we have a string that represents the documentation for the function. The string can be multiline without adding any special operator. It is always recommeneded that you add this documentation string, as it will appear on the Emacs help (for example, using `C-h f insert-line-below`)
- Then we have `(interactive)`. This is a special form in elisp that indicates that the function is callable using `M-x` (or any keybinding that you setup. Basically, all commands that you can call while on Emacs from the minibuffer are interactive commands
- Next is `save-excursion`. This is also a special form (implemented in C for speed). It saves the location of the point, and the current buffer, executes the body, and the restores the saved point and buffer. On this specific case, we are not modifying the buffer we are working on, so the functionality that we are using is to save and restore the point.
- `end-of-line` goes to the end of the line (good naming there)
- `open-line` was described above. The 1 is because you can pass the number of lines that you want to create (on this case we want to create a single line)

if you change the `(end-of-line)` to `(end-of-line 0)` you can create a function for inserting a line above, as passing a numeric argument to `end-of-line` makes you go to the end of the line that is `argument - 1`. So for an argument of 2, it will go to the end of the line below, and for an argument of 0 it will go to the end of the line above.

Ok, so now I have defined two functions, one for inserting a line above, one a line below. In both cases the point will remain where it was. And unlike `C-o` (or `return` on most editors) it will not break the current line.

I just give them keybindings and I am sorted

```elisp
(global-set-key (kbd "C-c M-n") 'insert-line-above)

(global-set-key (kbd "C-c n") 'insert-line-below)
```

Take into account that the keybindings chosen are based on my other keybindings (`C-c a`, which was an option, is part of my [ag](https://github.com/ggreer/the_silver_searcher) keybindings). And the `n` does remind me of "new line".

# The improved solution

What if I want to move the point to the new line? We know that `C-a RET` doesn't do the job. I could create separate functions, but I don't like that. very much, especially as we have in Emacs the awesome universal argument `C-u`.

Well, not complete awesome, because the implementation is strange (probably I am missing some history here).

The universal argument (or prefix argument) is used to modify behaviour, usually through the passing of a numeric argument (e.g., `C-u 6 C-p` going 6 lines up).

On this case I am going to use the presence of the universal argument on its own to modify if I want to move to the newly created line or not.

The modified code is

```elisp
(defun insert-line-above (universal)
  "Insert an empty line above the current line.
The behaviour change if you pass the default UNIVERSAL argument.  Without it, a new line 
above the current one will be created, but the point will not change its location.  With 
the default UNIVERSAL argument, the point will change to the beginning of the new line created."
  (interactive "P")
  (if (equal universal '(4))
      (progn
        (end-of-line 0)
        (open-line 1)
        (forward-line))
    (save-excursion
      (end-of-line 0)
      (open-line 1))))
```

The first two things that you will discover is that now we have a parameter in our list (`universal`), and that the call to `interactive` now has a parameter `"P"`. Both things are related.

`"P"` tells elisp that the function will receive a parameter with the value of the universal argument. By the way, this value is also stored on `current-prefix-arg`, but using it as above is the recommended way (still haven't found way).

On the if statement we compare the parameter universal against '(4). That's it, the list that has only 4 within. This is one of the quirkiness of the universal argument. If you want to read a bit more about the strange implementation, you can go to [this gnu page](https://www.gnu.org/software/emacs/manual/html_node/elisp/Prefix-Command-Arguments.html).

If you have used `C-u` before calling the function then instead of using `save-excursion` it will use `progn` and will call `forward-line` as the last command. `progn` allows you to call multiple functions and returns the result of the last call. It is used for side effects (like `do` in Clojure). `forward-line` is the programmatic way (that's it, is not an interactive function), to go to the next line.

So now, if I call `C-c M-n` I can create a new line above the current one without changing my position, and if I call `C-u C-c M-n` I create a new line above and then go to it.
