#Construct some data and start the plot
x <- 0:64/64
y <- sin(3*pi*x)
plot(x, y, type="l", col="blue")
points(x, y, pch=21, bg="white")

#Grab the plotting region dimensions
rng <- par("usr")

#Call your legend with plot = FALSE to get its dimensions
lg <- legend(rng[1],rng[2], "sin(c x)", pch=21, 
            pt.bg="white", lty=1, col = "blue",plot = FALSE)

#Once you have the dimensions in lg, use them to adjust
# the legend position
#Note the use of xpd = NA to allow plotting outside plotting region             
legend(rng[1],rng[4] + lg$rect$h, "sin(c x)", pch=21, 
            pt.bg="white", lty=1, col = "blue",plot = TRUE, xpd = NA)
            