rm(list= ls())
library(dplyr)
n = 100
df = data.frame(
  age = rnorm(n, mean = 50, sd = 5),
  var1 = rbinom(n, prob = 0.5, size = 8),
  var2 = rbinom(n, prob = 0.5, size = 1)
)
df = df %>% mutate(
  y = var1 * 0.2 + var2 * 0.8 + var1*var2 * 0.1 + age * 0.6
)

mod = lm(y ~ age * var1 * var2, data = df)

age = c(30, 50, 60)
# age = unique(age)
var1 = unique(df$var1)
var2 = unique(df$var2)

eg = expand.grid(age = age, var1 = var1, var2 = var2)

eg$est = predict(mod, newdata = eg)

g = ggplot(aes(x = age, y = est,
               colour = factor(var1)), 
           data = eg) + geom_point() + geom_line()
g
g + facet_wrap( ~ var2)

library(multcomp)
mod = lm(y ~ age * var1, data = df)

ht = multcomp::glht(mod, linfct = "var1 + age:var1 = 0")
# mm = model.matrix(y ~ age * var1, data = df)
# lht(mod, c("age:var1" = 1, var1 = 0 , age = 0, 
#            "(Intercept)" =0))
