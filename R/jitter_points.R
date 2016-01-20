# jitter points in R

N <- 100

x <- rep(1:4, each = 25)

errors <- rnorm(n = N, mean = 0, sd = 2)

slope <- 3

intercept <- 2

y <- x * slope + intercept + errors

plot(x, y)

plot(jitter(x), y)

# the argument 'factor' controls the degree of jitter (default = 1)
plot(jitter(x, factor = 1), y)

plot(jitter(x, factor = 0.2), y)
