---
title: Switching font on my emacs
date: 2020-10-08 06:00
excerpt: Some code that I did for Emacs when sharing screen
tags:
- Emacs
---

My font on Emacs has been, for quite a while, Fira Code on a size of 10 (though I yet have to make the effort to get the ligatures working). This sometimes present an issue when sharing the screen, especially when working from my desktop, where my Emacs is usually on the 27" screen. Usually I will just use `C-x C-+` to increase the font size of the buffer. But it was wearing thin having to do that for all buffers.

As it happens, I was pairing with someone on Tuesday that requested me to increase the font size when sharing my screen, so on Tuesday evening I put quickly together the below code:

``` elisp
(defvar using-sharing-font nil)

(defun set-standard-font ()
  (set-face-attribute 'default nil :font "Fira Code-10"))

(defun set-sharing-font ()
  (set-face-attribute 'default nil :font "Fira Code-16"))

(defun switch-font ()
  "Switches the font between my normal one and the one used to share screen"
  (interactive)
  (if using-sharing-font
      (set-standard-font)
    (set-sharing-font))
  (setq using-sharing-font (not using-sharing-font)))
```

This code allows me to switch for the whole of Emacs the font. I could have just switched the font size, but I was already using the `(set-face-attribute ...)` call to setup the font (so now `(set-standard-font)` is called on startup), so copy paste and move on.

Notes for the future:
- Can I use a number with the universal argument to indicate the font size that I want?
- Do I even bother to add a keybinding? 
- Is the second time I am using that defvar boolean format. Is there a better way of doing that?
