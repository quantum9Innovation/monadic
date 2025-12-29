---
title: Math
---

#import "@preview/html-math:1.0.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#show: html-math

Here's some math.

Inline equations look like this: $f(x) = integral_(-infinity)^infinity hat(f)(xi) e^(tau i xi x) d xi$.

Here are two block equations, one after the other:

$ A = U Sigma V^* => A^+ = V Sigma^+ U^* $
$ (partial^2 f)/(partial x partial y) = (partial^2 f)/(partial y partial x) $

Here's a multi-line one:
$
  delta_x (t) &:= cases(
    0 quad t eq.not x,
    1 quad t eq x
  ) \
  f(t) &= sum_(i=1)^infinity delta_i (t)
$

Ok how about a longer line block equation:
$
  sin(x) = x - x^3/3! + x^5/5! - x^7/7! + x^9/9! - x^11/11! + x^13/13! - x^15/15! + x^17/17! - x^19/19!
$

Finally, a diagram for good measure:

#math-figure(figure(
  diagram(
    cell-size: 15mm,
    $
      cal("B") 2 cal("B") edge(->) edge("d", pi, ->>) & cal("S") a a cal("S") \
        "AI" edge("ur", tilde("slop"), "hook-->")
    $,
  ),
  caption: [There is also the belief $cal("B") 2 cal("B") -> cal("S") a a cal("S")$],
))

By the way, that figure appeared in pg. 40 in the PDF of my first #link("https://code.functor.systems/q9i/urop-zardini/src/commit/d08ccd9f419115cd590a1c60f0f4a24b36603761/present/fa25/main.pdf")[UROP presentation].
