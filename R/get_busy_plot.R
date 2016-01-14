

# end of equivalent of get_busy()
avail <- get_busy(
  filename = "NIMBioS_meeting3_conflicts.csv", 
  entity = "participant", 
  start_date = "2016-05-01", 
  end_date = "2017-01-31", 
  conflict_start = "conflict_start", 
  conflict_end = "conflict_end" # column name of end of conflict
)

monthStart <- function(x)
{
  x <- as.POSIXlt(as.Date(x))
  x$mday <- 1
  as.Date(x)
}

fotm <- unique(monthStart(rownames(avail)))

# PLOTTING
left_margin <- 6

pdf(
  file = "availability_plot.pdf", 
  width = 10, 
  height = 5
)

layout(matrix(data = c(1,2,3)), heights = c(9,1,1))
# layout.show(3)
par(mar = c(1,left_margin,3,1))
image(
  x = 1:nrow(avail), 
  y = 1:ncol(avail), 
  z = avail, 
  col = grey.colors(n = 8, start = 0, end = 1), #c("gray", "white"), 
  axes = FALSE, 
  ann = FALSE
)

axis(
  side = 2, 
  at = c(1:ncol(avail)), 
  labels = colnames(avail), 
  las = 2
)

axis(
  side = 3, 
  at = match(as.character(fotm), rownames(avail)), 
  labels = format(fotm, "%b"), 
  las = 1
)

abline(
  h = 1:nrow(avail) + 0.5
)

abline(
  v = which(rowSums(avail) == max(rowSums(avail))), 
  col = hsv(0.1, 1, 1, 0.4)
)
box()

# best days
par(mar = c(0,left_margin,0,1))
image(
  x = 1:nrow(avail), 
  y = 1, 
  z = matrix(rowSums(avail)/max(rowSums(avail))), 
  col = grey.colors(n = nrow(avail), start = 0, end = 1), #c("gray", "white"), 
  axes = FALSE, 
  ann = FALSE
)

# legend
par(mar = c(2,left_margin,1,1))
image(
  x = 1:ncol(avail), 
  y = 1, 
  z = matrix(seq(from = 0, to = 1, length.out = ncol(avail))), 
  col = grey.colors(n = ncol(avail), start = 0, end = 1), #c("gray", "white"), 
  axes = FALSE, 
  ann = FALSE
)
axis(side = 1, at = 1:ncol(avail), labels = 1:ncol(avail))
axis(side = 2, at = 1, labels = "attendees", las = 2)
box()
dev.off()
# DONE


