---
title: ""
slug: How I do my computing
---

= How I do my computing

In the spirit of #link("https://stallman.org/")[Richard Stallman]'s #link("https://stallman.org/stallman-computing.html")[How I do my computing] page and #link("https://web.youwen.dev/tools")[others like it], I have decided to publicize my views on the subject along with a tirade of my personal opinions on software choices and freedom.
I fundamentally disagree with the views expressed by #link("https://web.youwen.dev/tools#loc-1")[Youwen et al.] positing that reliance on modern technology is some form of ceding control to "the machine," whatever that is.
I find the majority of pages like this tend to engage in self-righteousness in avoiding fancy software and computing systems.
Hence, the result is more about how _not_ to do computing rather than how computing _should_ be done.

I take the opposite view: that computation is a fundamental aspect of human existence, and serves to trivialize that which was previously nontrivial.
Some of the greatest advances in modern civilization are the result of thinking alone, and computation is merely another mode of thought, allowing us to turn intellectual breakthroughs into embodied systems capable of tackling actual problems.
Thus, computers have served to free us from the drudgery of manual labor and rote intellectual exercises, ushering in an era of philosophical inquiry and mathematical logic.

Ok, enough evangelizing about the nature of computation.
How do I do _my_ computing?
I'll answer in four parts, divided by the level of abstraction which they concern.

== Hardware

I use an Alienware m16 R2 laptop codenamed #link("https://code.functor.systems/q9i/netsanet")[Netsanet] (transliterated from Ge'ez script: "ነጻነት", which means "freedom" in Amharic) as my primary mobile computing device.
This is in some ways the embodiment of proprietary hardware, especially since it comes with a discrete NVIDIA GPU, the menace of free software (it requires proprietary drivers to operate at maximum performance).
This was a deliberate tradeoff between the growing need for raw computational power and the desire for a more open and free computing experience.
However, the "free as in freedom" philosophy is practically impossible to implement in hardware, as the #link("https://eexiv.functor.systems/document/view/opencompute")[FOSH ecosystem is nowhere near complete].

== Operating System

I use Linux as my primary operating system.
I refuse to switch to unfree alternatives like Windows or macOS.
Linux is not a monolithic operating system, and the choice of a distribution is significant---it affects everything from how you install packages to how you configure permanent settings on your system.
#link("https://nixos.org/")[NixOS] is objectively the best Linux distribution (it's powered by the same technology that builds this site).
The fundamental difference between Nix and other distributions is that Nix provides a purely functional language and package manager for configuring an entire operating system reproducibly (modulo hardware).
In theory, I could port my entire system---applications, themes, settings, kernel configurations, etc.---to any other laptop with zero effort.
That type of modularity is unparalleled across ecosystems.

After the result of a series of experiments in customizing NixOS, I've entered into a collaboration with other Nix hackers at #link("https://code.functor.systems/functor.systems/functorOS")[functor.systems] to create the ultimate NixOS experience, packaged as #link("https://functor.systems/functorOS")[functorOS].
It's essentially a distribution _on top of_ NixOS, meaning you get the benefits of reproducible configuration plus the convenience of a pre-configured environment with bleeding edge packages and modern defaults.
functorOS is to NixOS what something like #link("https://linuxmint.com/")[Linux Mint] is to #link("https://ubuntu.com/")[Ubuntu], or what #link("https://manjaro.org/")[Manjaro] is to #link("https://archlinux.org/")[Arch Linux].
The main difference being that it's much, much better.

functorOS tracks `nixos-unstable`, the bleeding edge rolling-release branch of NixOS.
As a result, it's always up to date with the latest features and improvements, by design.
It's also the #link("https://repology.org/repositories/statistics/total")[largest package repository] in existence, both by number of total packages and by number of fresh (new) packages.
In practice, that means I have access to the largest selection of software available to anyone, anywhere, at any time in human history.

I use the #link("https://github.com/zen-kernel/zen-kernel")[`linux-zen`] kernel for access to low-level enhancements hot off the press.
It's a fork of the official Linux kernel maintained by a collective of expert low-level hackers tinkering to improve things I don't understand or have good mathematical models for.

== Foundations

Above the operating system are the core system-level tools that define what user-facing computation looks and feels like.
I'll give a brief overview of what they look like on functorOS.

The primary application that defines your #link("https://jie-fang.github.io/blog/basics-of-ricing")[Linux rice] is your window manager, so you need one with the necessary eye candy to impress.
#link("https://hypr.land/")[Hyprland] has the looks, and it's deadly fast.
I don't like tiling window managers that waste my screen space with performative binary layouts, so I use the experimental #link("https://code.hyprland.org/hyprwm/hyprland-plugins/src/branch/main/hyprscrolling")[hyprscrolling] plugin to achieve a #link("https://github.com/YaLTeR/niri")[scrollable window manager] with Hyprland.

My terminal is powered by #link("https://sw.kovidgoyal.net/kitty/")[Kitty], which is fast and feature-rich.
My default shell is the revolutionary Rust-based #link("https://www.nushell.sh/")[nushell], which is heavily scriptable and deliberately incompatible with Bash shenanigans.
It's been hacked to use the #link("https://fishshell.com/")[Fish] autocompletion engine, because it's just too good.

== Userspace

My entire userspace is of course free and open source software.
I pick tools that are well maintained, actively developed, and future-proof.
They're typically built from solid foundations---they run efficiently, cede control to users, and allow for custom hacks where needed.

I use the #link("https://zed.dev/")[Zed editor] (I know it by `zeditor`), which is a modern, blazingly fast, Rust-based text editor for collaboration and understanding.
This is of course the primary application that defines my hacking experience.

I use the #link("https://zen-browser.app/")[Zen browser] for surfing the web.
It's Firefox with the eye candy and the features the modern internet multiplexer demands.
It's extremely hackable with #link("https://zen-browser.app/mods/")[Zen mods].
This is the default browser on functorOS.
