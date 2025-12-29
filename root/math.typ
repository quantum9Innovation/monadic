---
title: Math
---

#import "@preview/html-math:1.0.0": *
#import "@preview/cetz:0.4.2": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#show: html-math

Here's some math.

Inline $2x+3$

$ 2x+3 2x+3 2x+3 2x+3 2x+3 2x+3 2x+3 2x+3 2x+3 2x+3 2x+3 $

#figure(
  diagram(
    cell-size: 15mm,
    $
      cal("B") 2 cal("B") edge(->) edge("d", pi, ->>) & cal("S") a a cal("S") \
            "AI" edge("ur", tilde("slop"), "hook-->")
    $,
  ),
  caption: [There is also the belief $cal("B") 2 cal("B") -> cal("S") a a cal("S")$],
)
