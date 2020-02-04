---
title: Emacs and Evil
date: 2020-01-28 05:00
excerpt: Why Emacs?, why Evil? and some code
tags:
- Emacs
- Tools
---


When I started my career, long time ago, on my third job, I was maintaining new accounting and members management systems for a Chartered Institute in Spain. It was the first time I saw users actually using the system I was coding. The two applications were created to move from "legacy" DOS application to Windows system written on VB6. I saw the users interact with the old system, flying through the different menus and text boxes, using the keyboard, adding or modifying information as quickly as their fingers could move. Our new VB application required you to use the mouse for everything, which was slow. You wrote something down in an input box, then you had to move your hand to the mouse, locate the cursor on the screen, then move the cursor to the new box so you could introduce more text. Oh, and the pain of using dropdown boxes with no search/filtering capabilities, having to scroll clicking on the small arrow buttons (at that point, not scroll wheels). I felt disheartened by the fact that our new application was actually reducing so much our users efficiency.

I play World of Warcraft (not that much on the current expansion). Nearly everyone above a certain level of competency uses the mouse for turning the character and executes all the skills and abilities using the keyboard. One hand always on the mouse, one hand always on the keyboard. Based on the input methods, this is the most efficient way to play the game to decrease your reaction time. As an interesting note for later, each player has different keybindings that they have evolved through playing the game and adapting to the changes brought on the game.

# Characteristics

There are three characteristics I look for in my tools. This characteristics are informed by the fact that I am a developer working mostly on text input. Even if some other profession, a designer as example, has the same requirements, the most optimal solution for them could be different, due to different context.

So, the three characteristics:
- Speed. I want to be able to be limited by my own klutziness (which is something I can train to improve), not by inherent issues with the system. 
- Consistency. If an action is done a specific way, similar actions should be done similar (one thing I dislike from the otherwise good IntelliJ tools, the small inconsitencies)
- Context Switching. I want to be able to avoid as much as possible switching context on my brain, between thinking about the problem at hand, and thinking about the input.

Taking into account our biology, and our input methods, development of muscle memory on the keyboard is the most efficient way of improving speed and reducing context switching. Most of the time now I save on "automatic mode". I don't think about it, I just do it. If I were limited to the mouse I will have to: locate the mouse on my right, move my hand to it, wiggle the mouse to locate the cursor, move the mouse to nearly top left (but not top left). Click on the menu, move down the cursor to the `Save` entry, click on it. Compare that to either using `C-x C-s` or `:w`. Of course, you can do `Ctrl-S` or `Command-S` on most applications. But imagine that for every single action that you can do within your IDE/editor.

I can mostly write on my laptop keyboard without looking at all on it. Like I am doing right now for this sentence (while looking at the other people on the train). I think what I want to write, and I let my fingers do the work, because they already know the location of the keys. Yes, my job as a developer is not really to write text, but for as long as the input method is mostly keyboard based, it will be inefficient of me not to use it properly. Whenever I hve to think where my fingers are supposed to be to press the right keys, whenever I have to use a menu, whenever I need to focus my attention on the mouse I am breaking my line of thinking around the design and development that I am dealing with.

# Emacs and Vim

What I like both from [Emacs](https://www.gnu.org/software/emacs/) and [Vim](https://www.vim.org/) is that they are very much based around the idea of text editing and the use of the keyboard to its full extent. By default there is no mouse (X11 mode of Emacs does allow mouse, but I have currently disable the use of mouse for Emacs). Every single command/function/action that you can take on Emacs or Vim can be done using the keyboard. I have a strong dislike for tools that force me to use the mouse (every single IDE).

I think Emacs is the superior application, elisp and the ability to just go bananas with plugins and setup is unmatched. But Vim actually has the better keybindings for editing, even when the modes sometimes annoy me. Of course, once you have [M-x buttefly](https://www.xkcd.com/378/), you can find [evil](https://github.com/emacs-evil/evil) the package to bring vim keybindings to Emacs. 

# The Trade-Offs

Of course, with all systems there are trade-offs. As an example, you can increase the speed of your mouse pointer, but that leads to a reduction on precision.

Vim and Emacs are quite different enough, but there are some common differences that affect both systems. The main one is that they came basically barebones. Oh, they have been adding some stuff (like the package system on Emacs now coming out of the box). But you need to do a lot of work on them. Consequently, each personn's Emacs (and Vim) configuration tends to be unique, like Mon Calamari spaceships.

Which brings to another trade-off: with things like remote pairing and code reviews, you can just have the other person directly use your editor, because they will be lost (There are ways around it).

Another issue, of special importance to Java developers, is the refactoring tools. Emacs refactoring tools have been always dependent on the package that you are using. It was so egregious on the Java modes, that last time I was doing a Java project I decided to use IntelliJ Idea, because the refactoring tools were given me greater speed than the text based approach of Emacs (mind you, there is a vi plugin for some basic editing). Thanskfully, this is now getting resolved by the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/). Also, not all languages are so dependant on refactoring tools as Java is.

# My current configuration

Ok, so now, finally, to the piece of code that I wanted to show, from my [current setup](https://github.com/MiyamotoAkira/.emacs.d). This is based on the idea of [Spacemacs](https://www.spacemacs.org/) using the spacebar as a leading key.

```elisp
(use-package evil-leader
  :ensure t
  :config
  (evil-leader/set-leader "<SPC>"))

(use-package evil
  :ensure t
  :hook
  ((prog-mode . evil-mode)
   (prog-mode . evil-leader-mode))
  :bind (:map tools-map
              ("g" . magit-status)
              ("m" . monky-status))
  :config
  (define-prefix-command 'languages-map)
  (evil-leader/set-key (kbd "l") 'languages-map)
  (define-prefix-command 'tools-map)
  (evil-leader/set-key (kbd "t") 'tools-map))
```

The above install both evil and the evil-leader for the leader key functionality. I create two keymaps, one for languages and one for tools, to be reached from that spacebar leading key. 

```elisp
(use-package tide
  :ensure t
  :defines languages-map
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode))
  :bind (
         :map tide-mode-map
         ("r" . tide-rename-symbol)
         ("f" . tide-fix)
         ("." . #'tide-jump-to-definition)
         ("," . #'tide-jump-back)
         ("/" . #'tide-jump-to-implementation))
  :config
  (define-prefix-command 'tide-mode-map)
  (define-key languages-map (kbd "t") 'tide-mode-map)
  (add-hook 'typescript-mode-hook (lambda ()
                                    (setq typescript-indent-level 2)))
  (setq tide-format-options '(:indentSize 2 
                              :insertSpaceBeforeFunctionParenthesis t 
                              :insertSpaceAfterFunctionKeywordForAnonymousFunctions t 
                              :insertSpaceAfterConstructor t)))
```

And then I configure a new language map linked to the previous language map, using the `define-prefix-command` and `define-key`.  Then using `:bind` from [use-package](https://github.com/jwiegley/use-package) and the created map I can start linking functions to keys. So, if I want to rename a symbol on typescript I can press `SPC l t r`.

As I start adding this to other languages I will be able to remap everything to bring me consistency (for example, I can remap the clojure clj-refactor function `cljr-rename-symbol` to `SPC l c r`.

I think at some point I will want to be able to replicate the idea of layers from Spacemacs so I can avoid the two middle key-presses and increase my speed. But we will see as I use it.

By the way, if you see something that can improved around the setup of those maps, I would be glad to hear about it.

# Note
With all the discussion above, you can see that I feel pretty strongly about tooling and how to be efficient. But, if tomorrow a new input method appears that is more efficient, or a tool improves my efficiency more than Emacs currently does, I would change my approach.
