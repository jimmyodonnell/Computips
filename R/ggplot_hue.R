# emulate ggplot's color picking function (chose colors evenly spaced from the color wheel)

ggplot_hue <- function(n) {
  hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}
