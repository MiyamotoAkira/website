---
title: Use-package behaviour on Emacs
date: 2018-11-26 21:00
excerpt: On which setting up Emacs for Rust lead to some nice discoveries 
tags:
- Emacs
---

So, originally, this post was going to be about how to setup emacs for Rust development. But at the end, if you go to [Julen Blanchard's blog](http://julienblanchard.com/2016/fancy-rust-development-with-emacs/) he will give you the basic packages that you should be using.

More interestingly, I have learned something new about [use-package](https://github.com/jwiegley/use-package) because of it. And that new thing is that the different keywords that you can pass on the setup of a package are evaluated on an specific order.

Let's use examples based on my setup of Rust. Originally I added the code as follows:

```elisp
(use-package rust-mode
  :defer t
  :ensure t)

(use-package cargo
  :defer t
  :ensure t
  :config
  (add-hook rust-mode-hook cargo-minor-mode))
```

With that setup when I loaded a rust file the `cargo-mode` was not loaded. I wondered if there was some relation to the fact that cargo package was being defered. So I changed the code to the version below and lo and behold my cargo mode loaded.

```elisp
(use-package rust-mode
  :defer t
  :ensure t
  :config
  (add-hook rust-mode-hook cargo-minor-mode))

(use-package cargo
  :defer t
  :ensure t)
```

So if I am using `:defer t` then the code under `:config` was not being loaded. `rust-mode` autoloads based on the extension, which triggers the config which then makes the `cargo-mode` load. At least at the moment that is what I expect is happening, though I will confirm at another moment.

But that wasn't right to me, why the setup of my `rust-mode` package should know anything about `cargo-mode`? Clearly I was indicating the dependencies incorrectly.

So decided to look into the code of `use-package` and there it was, a `defcustom` in which there was a comment indicating that the order is important. Of course, `:config` is the last item on that order, with`:defer` just a few lines above. Looking at the list, I discovered that there is keyword `:hook`. And well, I do wonder what it is for ....

So converted the code to this:

```elisp
(use-package rust-mode
  :defer t
  :ensure t)

(use-package cargo
  :defer t
  :ensure t
  :hook
  ((rust-mode . cargo-minor-mode)))
```

And now the `cargo-mode` loads as I expect whenever a rust file is opened, while keeping the dependency direction correctly 
