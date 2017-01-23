#!/usr/bin/env Rscript

# source: http://bxhorn.com/r-color-tables/#table-code

EXPORT <- FALSE

color_vector <- colors() # original

# omit all of the grays + greys
omit_i <- grep("^gray|^grey", colors())
color_vector <- colors()[ - omit_i ]

# add back in "gray" and 10 representative numbered grays
gray_num <- c("gray", paste0("gray", seq(0, 100, by = 10)))
color_vector <- c(color_vector, gray_num)

# 1.Define R Color Data ----
# RGB codes
color.rgb <- t(col2rgb(color_vector))
# Hexadecimal codes
color.hex <- rgb(color.rgb[,1], color.rgb[,2], color.rgb[,3], maxColorValue = 255)
# Text highlighting
color.text <- ifelse(apply(color.rgb, 1, mean) > 127, "black", "white")
# Consolidate
color.df <- data.frame(name = color_vector,
                       red = color.rgb[, "red"],
                       green = color.rgb[, "green"],
                       blue = color.rgb[, "blue"],
                       hex = color.hex,
                       text = color.text)


# configure graphical device
n.col <- 10
n.row <- ceiling(length(color_vector)/n.col)

# 2.Plot R Colors By Name ----
if(EXPORT){
  pdf("color_name.pdf", width = 10, height = 10)
}

par(pin = c(11.692, 6.267), mai=c(0.5, 0.5, 0.5, 0.5))

# create plot
plot(c(0, n.col), c(0, n.row),
     type = "n",
     bty = "n",
     ylab = "",
     xlab = "",
     axes = FALSE)
title("R Colors By Name")

for(i in 1:n.col){
   color.count <- (i-1) * n.row
   color.mod <- length(color_vector) - color.count
   y.val <- ifelse(color.mod < n.row, n.row - color.mod + 1, 1)
   color.names <- as.character(color.df[color.count + 1:n.row, "name"])
   rect(i - 1, y.val - 0.5, i, n.row:y.val + 0.5, border = "black", col = color.names)
   text.color <- as.character(color.df[color.count + 1:n.row, "text"])
   text(i-0.5, n.row:y.val, labels = color.names, cex = 0.5, col = text.color)
}
if(EXPORT){
  dev.off()
}

# 3.Plot R Colors By Hex Code ----
# create plot
if(EXPORT){
  pdf("color_hex.pdf", width = 10, height = 10)
}
plot(c(0, n.col), c(0, n.row),
     type = "n",
     bty = "n",
     ylab = "",
     xlab = "",
     axes = FALSE)
title("R Colors By Hex Code")

for(i in 1:n.col){
   color.count <- (i-1) * n.row
   color.mod <- length(color_vector) - color.count
   y.val <- ifelse(color.mod < n.row, n.row-color.mod + 1, 1)
   color.names <- as.character(color.df[color.count + 1:n.row, "hex"])
   rect(i - 1, y.val - 0.5, i, n.row:y.val + 0.5, border = "black", col = color.names)
   text.color <- as.character(color.df[color.count + 1:n.row, "text"])
   text(i-0.5, n.row:y.val, labels = color.names, cex = 0.5, col = text.color)
}
# reset graphical device
par(op)
if(EXPORT){
  dev.off()
}
