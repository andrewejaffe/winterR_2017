## ----readin--------------------------------------------------------------
# readin is just a "label" for this code chunk
## code chunk is just a "chunk" of code, where this code usually
## does just one thing, aka a module
### comments are still # here
### you can do all your reading in there
### let's say we loaded some packages
library(stringr)
library(plyr)
library(dplyr)
fname <- "../../data/Bike_Lanes.csv"
bike = read.csv(fname, as.is = TRUE)

## ---- echo = FALSE-------------------------------------------------------
no.missyear <- bike[ bike$dateInstalled != 0,]
plot(no.missyear$dateInstalled, no.missyear$length)
no.missyear$dateInstalled = factor(no.missyear$dateInstalled)
boxplot(no.missyear$length ~ no.missyear$dateInstalled, main="Boxplots of Bike Lenght by Year", xlab="Year", ylab="Bike Length")

## ------------------------------------------------------------------------
no.missyear$log.length <- log10(no.missyear$length)
### see here that if you specify the data argument, you don't need to do the $ 
boxplot(log.length ~ dateInstalled, data=no.missyear, main="Boxplots of Bike Lenght by Year", xlab="Year", ylab="Bike Length")

## ------------------------------------------------------------------------
boxplot(log.length ~ dateInstalled, data=no.missyear, main="Boxplots of Bike Lenght by Year", xlab="Year", ylab="Bike Length", col="red")

## ------------------------------------------------------------------------
### type is a character, but when R sees a "character" in a "formula", then it automatically converts it to factor
### a formula is something that has a y ~ x, which says I want to plot y against x
### or if it were a model you would do y ~ x, which meant regress against y
boxplot(log.length ~ type, data=no.missyear, main="Boxplots of Bike Lenght by Year", xlab="Year", ylab="Bike Length")

## ------------------------------------------------------------------------
### tapply takes in vector 1, then does a function by vector 2, and then you tell what 
### that function is
tapply(no.missyear$log.length, no.missyear$type, mean)

## aggregate
aggregate(x=no.missyear$log.length, by=list(no.missyear$type), FUN=mean)
### now let's specify the data argument and use a "formula" - much easier to read and 
## more "intuitive"
aggregate(log.length ~ type, data=no.missyear, FUN=mean)

## ddply is from the plyr package
##takes in a data frame, (the first d refers to data.frame) 
## splits it up by some variables (let's say type)
## then we'll use summarise to summarize whatever we want
## then returns a data.frame (the second d) - hence why it's ddply
## if we wanted to do it on a "list" thne return data.frame, it'd be ldply
ddply(no.missyear, .(type), plyr::summarise,
      mean=mean(log.length)
      )

no.missyear %>% group_by(type) %>% 
  dplyr::summarise(mean=mean(log.length))

## ------------------------------------------------------------------------
### For going over 2 variables, we need to do it over a "list" of vectors
tapply(no.missyear$log.length, 
       list(no.missyear$type, no.missyear$dateInstalled), 
       mean)

tapply(no.missyear$log.length, 
       list(no.missyear$type, no.missyear$dateInstalled), 
       mean, na.rm=TRUE)

## aggregate - looks better
aggregate(log.length ~ type + dateInstalled, data=no.missyear, FUN=mean)

## ddply is from the plyr package
ddply(no.missyear, .(type, dateInstalled), summarise,
      mean=mean(log.length),
      median=median(log.length),
      Mode=mode(log.length),
      Std.Dev=sd(log.length)
      )

## ------------------------------------------------------------------------
### type is a character, but when R sees a "character" in a "formula", then it automatically converts it to factor
### a formula is something that has a y ~ x, which says I want to plot y against x
### or if it were a model you would do y ~ x, which meant regress against y
mod.type = lm(log.length ~ type, data=no.missyear)
mod.yr = lm(log.length ~ factor(dateInstalled), data=no.missyear)
mod.yrtype = lm(log.length ~ type + factor(dateInstalled), data=no.missyear)
summary(mod.type)

## ------------------------------------------------------------------------
### DON'T DO THIS.  YOU SHOULD ALWAYS DO library() statements in the FIRST code chunk.
### this is just to show you the logic of a report/analysis.
require(xtable)
# smod <- summary(mod.yr)
xtab <- xtable(mod.yr)

## ---- results='asis'-----------------------------------------------------
print.xtable(xtab, type="html")

## ------------------------------------------------------------------------
require(stargazer)

## ---- results='markup', comment=""---------------------------------------
stargazer(mod.yr, mod.type, mod.yrtype, type="text")

## ---- results='asis', comment=""-----------------------------------------
stargazer(mod.yr, mod.type, mod.yrtype, type="html")

## ----computes------------------------------------------------------------
### let's get number of bike lanes installed by year
n.lanes = ddply(no.missyear, .(dateInstalled), nrow)
names(n.lanes) <- c("date", "nlanes")
n2009 <- n.lanes$nlanes[ n.lanes$date == 2009]
n2010 <- n.lanes$nlanes[ n.lanes$date == 2010]
getwd()

## ------------------------------------------------------------------------
fname <- "../../data/Charm_City_Circulator_Ridership.csv"
# fname <- file.path(data.dir, "Charm_City_Circulator_Ridership.csv")
## file.path takes a directory and makes a full name with a full file path
charm = read.csv(fname, as.is=TRUE)

library(chron)
days = levels(weekdays(1, abbreviate=FALSE))
charm$day <- factor(charm$day, levels=days)
charm$date <- as.Date(charm$date, format="%m/%d/%Y")
cn <- colnames(charm)
daily <- charm[, c("day", "date", "daily")]


## ------------------------------------------------------------------------
charm$daily <- NULL
require(reshape)
long.charm <- melt(charm, id.vars = c("day", "date"))
long.charm$type <- "Boardings"
long.charm$type[ grepl("Alightings", long.charm$variable)] <- "Alightings"
long.charm$type[ grepl("Average", long.charm$variable)] <- "Average"

long.charm$line <- "orange"
long.charm$line[ grepl("purple", long.charm$variable)] <- "purple"
long.charm$line[ grepl("green", long.charm$variable)] <- "green"
long.charm$line[ grepl("banner", long.charm$variable)] <- "banner"
long.charm$variable <- NULL

long.charm$line <-factor(long.charm$line, levels=c("orange", "purple", 
                                                   "green", "banner"))

head(long.charm)

### NOW R has a column of day, the date, a "value", the type of value and the 
### circulator line that corresponds to it
### value is now either the Alightings, Boardings, or Average from the charm dataset

## ----plots---------------------------------------------------------------
require(ggplot2)
### let's make a "ggplot"
### the format is ggplot(dataframe, aes(x=COLNAME, y=COLNAME))
### where COLNAME are colnames of the dataframe
### you can also set color to a different factor
### other options in AES (fill, alpha level -which is the "transparency" of points)
g <- ggplot(long.charm, aes(x=date, y=value, color=line)) 
### let's change the colors to what we want- doing this manually, not letting it choose
### for me
g <- g + scale_color_manual(values=c("orange", "purple", "green", "blue"))
### plotting points
g + geom_point()
### Let's make Lines!
g + geom_line()
### let's make a new plot of poitns
gpoint <- g + geom_point()
### let's plot the value by the type of value - boardings/average, etc
gpoint + facet_wrap(~ type)

## ---- warning=FALSE------------------------------------------------------
## let's compare vertically 
gpoint + facet_wrap(~ type, ncol=1)

gfacet = g + facet_wrap(~ type, ncol=1)

## ---- warning=FALSE------------------------------------------------------
## let's smooth this - get a rough estimate of what's going on
gfacet + geom_smooth(se=FALSE)

## ---- echo=FALSE, warning=FALSE, fig.width=10, fig.height=5--------------
#### COMBINE! - let's make the line width bigger (lwd)
### also making the "alpha level" (transparency) low for the point sos we can see the lines
g + geom_point(alpha=0.2) +  geom_smooth(se=FALSE, lwd=1.5) + facet_wrap( ~ type)

## ---- echo=FALSE, warning=FALSE, message = FALSE, fig.width=10, fig.height=5----
g + geom_point(alpha=0.2) +  geom_smooth(se=FALSE, lwd=1.5) + facet_wrap( ~ type)

