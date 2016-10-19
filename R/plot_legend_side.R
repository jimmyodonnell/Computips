# put a legend outside of a plot

color_switch <- sapply(
list(
c(255,   0, 128),
c(246, 223,  14),
c(140,  19, 251),
c( 53, 226, 242)),
function(x) rgb(x[1], x[2], x[3], maxColorValue = 255)
)

N_points <- 40

par(mar = c(4,4,1,1))

plot_layout <- layout(matrix(c(1,2), ncol = 2), widths = c(10,1))
layout.show(plot_layout)

plot(rnorm(N_points), rnorm(N_points), 
  xlab = "", ylab = "",
  pch = 19, col = color_switch)

par(mar=c(0, 0, 0, 0))
plot.new()
legend("left", legend = LETTERS[1:length(color_switch)], 
  pch = 19, 
  col = color_switch, 
  bty = "n")

