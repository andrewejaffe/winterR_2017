## ---- echo = FALSE, message=FALSE, error = FALSE-------------------------
library(knitr)
opts_chunk$set(comment = "")
library(dplyr)

## ------------------------------------------------------------------------
head(mtcars)

## ------------------------------------------------------------------------
mean(mtcars$hp)
quantile(mtcars$hp)

## ------------------------------------------------------------------------
median(mtcars$wt)
quantile(mtcars$wt, probs = 0.6)

## ------------------------------------------------------------------------
t.test(mtcars$wt) 

## ------------------------------------------------------------------------
x = c(1,5,7,NA,4,2, 8,10,45,42)
mean(x)
mean(x,na.rm=TRUE)
quantile(x,na.rm=TRUE)

## ------------------------------------------------------------------------
circ = read.csv("http://www.aejaffe.com/summerR_2016/data/Charm_City_Circulator_Ridership.csv", 
            header=TRUE,as.is=TRUE)

## ---- message=FALSE------------------------------------------------------
library(dplyr)
circ2 = select(circ, date, day, ends_with("Average"))
head(circ2, 4)

## ----colMeans------------------------------------------------------------
avgs = select(circ2, ends_with("Average"))
colMeans(avgs,na.rm = TRUE)
circ2$daily = rowMeans(avgs,na.rm=TRUE)
head(circ2$daily)

## ----summary1------------------------------------------------------------
summary(circ2)

## ----apply1--------------------------------------------------------------
apply(avgs,2,mean,na.rm=TRUE) # column means
apply(avgs,2,sd,na.rm=TRUE) # columns sds
apply(avgs,2,max,na.rm=TRUE) # column maxs

## ----tapply1-------------------------------------------------------------
tapply(circ2$daily, circ2$day, max, na.rm = TRUE)

## ----scatter1------------------------------------------------------------
plot(mtcars$mpg, mtcars$disp)

## ----hist1---------------------------------------------------------------
hist(circ2$daily)

## ----hist_date-----------------------------------------------------------
library(lubridate)
circ2$date = mdy(circ2$date)
plot(circ2$date, circ2$daily, type = "l")

## ----dens1,fig.width=5,fig.height=5--------------------------------------
## plot(density(circ2$daily))
plot(density(circ2$daily,na.rm=TRUE))

## ----box1----------------------------------------------------------------
boxplot(circ2$daily ~ circ2$day)

## ----box2----------------------------------------------------------------
boxplot(daily ~ day, data=circ2)

## ----matplot1------------------------------------------------------------
pairs(avgs)

