// Adds support for HTML-based math rendering

#let html-math(body) = {
  show math.equation.where(block: true): it => context {
    if target() == "html" {
      html.elem(
        "div",
        attrs: (role: "math", class: "math block-math inline-block"),
        html.frame(it),
      )
    } else {
      it
    }
  }
  show math.equation.where(block: false): it => context {
    if target() == "html" {
      html.elem(
        "span",
        attrs: (role: "math", class: "math inline-math"),
        html.frame(it),
      )
    } else {
      it
    }
  }
  
  body
}

#let math-figure(body) = {
  show figure: it => context {
    if target() == "html" {
      html.elem(
        "figure",
        {
          html.frame(it.body)
          it.caption
        }
      )
    } else {
      it
    }
  }
  
  body
}
