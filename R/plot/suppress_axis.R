# Remove numbering on x-axis or y-axis:

plot(1:10, xaxt='n')
plot(1:10, yaxt='n')

# If you want to remove the labels as well:

plot(1:10, xaxt='n', ann=FALSE)
plot(1:10, yaxt='n', ann=FALSE)

