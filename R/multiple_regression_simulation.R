# simulate some data to practice multiple regression in R

# 1. start by setting up some predictors, x1x1, x2x2, ...
x1 <- 11:30
x2 <- runif(n = 20, min = 5, max = 95)
x3 <- rbinom(n = 20, size = 1, prob = 0.5)

# 2. Choose the population ('true') coefficients of your predictors, the βi's (beta), including β0 (beta naught), the intercept.
b0 <- 17
b1 <- 0.5
b2 <- 0.037
b3 <- -5.2

# 3. Choose the error variance, σ2 (sigma squared) or equivalently its square root, σ (sigma)
sigma <- 1.4

# 4. generate the error term, ε (epsilon), as an independent random normal vector, with mean 0 and variance σ2 (sigma squared)
epsilon <- rnorm(n = x1, mean = 0, sd = sigma)

# 5. Let y = β0 + β1x1 + β2x2 + ... + βkxk + ε
y <- b0 + b1*x1  + b2*x2  + b3*x3 + epsilon
# produces a single simulation of y from the model. Then running

# then you can regress the y on your x's
summary(lm(y~x1+x2+x3))

# plot it up
plot(
  y ~ x1, 
  pch = 21, 
  col = hsv(x3 * 0.6, 1, 1), # point border color: scale the x3 variable to 0.6 because 0 = 1 on hsv wheel
  bg = hsv(x3 * 0.6, 1, 1, alpha = x2/max(x2)) # point fill color: scale x2 to influence alpha (transparency)
  )
legend(
  "bottomright", 
  legend = c(
    paste("x2 = ", round(range(x2))), 
    paste("x3 = ", levels(as.factor(as.character(x3))))), 
  pch = c(
    19, 19, 
    1, 1), 
  col = c(
    hsv(c(0, 0.6), 1, 1, alpha = c(0,1)), 
    hsv(x3 * 0.6, 1, 1)) 
)


