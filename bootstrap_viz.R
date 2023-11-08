# we can visualize it here
vec <- c(list2) # create a vector from our list

hist(vec, breaks = 30, main = "Confidence Intervals for Mileage",
     xlab = "Beta coefficient", font.main = 1)
# lines for 90% CI
abline(v = -.144, lwd = 2, col = "red", lty = 2)
abline(v = -.096, lwd = 2, col = "red", lty = 2)
# lines for 95% CI
abline(v = -.149, lwd = 2, col = "blue", lty = 2)
abline(v = -.091, lwd = 2, col = "blue", lty = 2)
legend("topright", legend = c("90% CI", "95% CI"),
       lty = 2, col = c("red", "blue"))