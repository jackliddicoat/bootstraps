### Bootstrapped CIs with "boot"

library(Stat2Data)
library(boot)

# load the data in
data("AccordPrice")
View(AccordPrice)

# lets look at the histograms
hist(AccordPrice$Age, breaks = 20)
hist(AccordPrice$Mileage, breaks = 20)

# visually, they are both not normally distributed
# we can check this statistically using the shapiro-wilkes test from the stats lib
shapiro.test(AccordPrice$Age); shapiro.test(AccordPrice$Mileage)
# p < .05 for both, so we reject the null hypothesis that they are normally distributed

# in that case, we should use a spearman correlation
cor(AccordPrice$Age, AccordPrice$Mileage, method = "spearman")
# .858

# plot
plot(AccordPrice$Age, AccordPrice$Mileage)

reg.fun <- function(data, ind) {
  df <- data[ind,]
  c(cor(df[,1], df[,2], method = "spearman"))
}

# lets do 1000 trials
trials <- 1000
bootstrap <- boot(AccordPrice, statistic = reg.fun, R = trials)
bootstrap # here are our bootstrap stats

# we can display these visually
plot(bootstrap)

# 4 different types of confidence intervals
boot.ci(boot.out = bootstrap, type = c("norm", "basic", "perc", "bca"))





