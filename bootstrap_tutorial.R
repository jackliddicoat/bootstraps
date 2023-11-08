## Bootstrap confidence interval tutorial 

# load data into R and view it
library(Stat2Data)
data("AccordPrice")
AccordPrice %>% 
  head()

# create a linear regression to predict price based on mileage
ols1 <- lm(Price ~ Mileage, data = AccordPrice)

# View the summary of the data
summary(ols1)$coef

# store the fitted values of the regression model
yhat <- ols1$fitted.values

# store the residuals of the regression model
res <- ols1$residuals

# make a new response variable based on yhat and res
Y = yhat + sample(res)

# make a new model that stores this stat in a list
list1 = list(lm(Y ~ Mileage, data = AccordPrice))

# Now we can repeat this process n number of times to get our
# bootstrapped confidence interval
# I'll do 1000 times
n = 1000

# make a new (empty) list
list2 <- list()

# run a for loop to fill the list
for (i in 1:n) {
  Y = yhat + sample(res)
  ols = lm(Y ~ Mileage, data = AccordPrice)
  list2[i] = ols$coefficients["Mileage"] # this extracts the "Mileage" coef
}

# Unlist the list and sort it
list2 = unlist(list2)
list2 = sort(list2) # this makes sure the list is in ascending order

# for a 90% CI, take the 5th and 95th percentile vals from the list
quantile(list2, probs = c(.05, .95))
# (-.142, .097) 

# for a 95% CI, take the 2.5th and 97.5th percentile vals from the list
quantile(list2, probs = c(.025, .975))
# (-.146, .093)

# for a 99% CI, take the 0.5th and 99.5th percentile vals from the list
quantile(list2, probs = c(.005, .995))
# (-.156, -.081)

# now we can compare them to the theoretical ones
confint(ols1, level = .9) # 90% CI (-.144, -.096)
confint(ols1, level = .95) # 95% CI (-.149, -.091)
confint(ols1, level = .99) # 99% CI (-.159, -.081)

# they are very similar



