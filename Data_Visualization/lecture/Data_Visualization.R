## ----knit-setup, echo=FALSE----------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, 
               message = FALSE, 
               warning = FALSE,
               fig.height = 3.5,
               fig.width = 3.5, 
               comment = "")

## ----seed, comment="",echo=FALSE,prompt=TRUE-----------------------------
set.seed(3) 

## ----plotEx,  fig.align='center',cache=FALSE-----------------------------
death = read.csv("http://www.aejaffe.com/summerR_2016/data/indicatordeadkids35.csv",
                 as.is=TRUE,header=TRUE, row.names=1)
death[1:2, 1:5]

## ------------------------------------------------------------------------
library(stringr)
year = names(death) %>% str_replace("X","") %>% as.integer
head(year)

## ----plot1, comment="",prompt=TRUE,  fig.align='center',cache=TRUE-------
plot(as.numeric(death["Sweden",]) ~ year)

## ----plotEx2, comment="",prompt=TRUE,  fig.align='center',cache=TRUE-----
plot(as.numeric(death["Sweden",]) ~ year,
      ylab = "# of deaths per family", main = "Sweden")

## ----plotEx3, fig.align='center', cache=TRUE-----------------------------
plot(as.numeric(death["Sweden",])~year,
      ylab = "# of deaths per family", main = "Sweden",
     xlim = c(1760,2012), pch = 19, cex=1.2,col="blue")

## ----plotEx_sub, fig.align='center', cache=TRUE--------------------------
plot(as.numeric(death["Sweden",])~year,
      ylab = "# of deaths per family", main = "Sweden",
     subset = year < 2015, pch = 19, cex=1.2,col="blue")

## ----plotEx4, comment="",prompt=TRUE, fig.align='center', cache=TRUE-----
scatter.smooth(as.numeric(death["Sweden",])~year,span=0.2,
      ylab="# of deaths per family", main = "Sweden",lwd=3,
     subset = year < 2015, pch = 19, cex=0.9,col="grey")

## ----plotEx5, comment="",prompt=TRUE, fig.width=8,fig.height=4,fig.align='center', cache=TRUE----
par(mfrow=c(1,2))
scatter.smooth(as.numeric(death["Sweden",])~year,span=0.2,
      ylab="# of deaths per family", main = "Sweden",lwd=3,
     xlim = c(1760,2012), pch = 19, cex=0.9,col="grey")
scatter.smooth(as.numeric(death["United Kingdom",])~year,span=0.2,
      ylab="# of deaths per family", main = "United Kingdom",lwd=3,
     xlim = c(1760,2012), pch = 19, cex=0.9,col="grey")

## ----plotEx6, fig.width=8,fig.height=4,fig.align='center', cache=TRUE----
par(mfrow=c(1,2))
yl = range(death[c("Sweden","United Kingdom"),])
scatter.smooth(as.numeric(death["Sweden",])~year,span=0.2,ylim=yl,
      ylab="# of deaths per family", main = "Sweden",lwd=3,
     xlim = c(1760,2012), pch = 19, cex=0.9,col="grey")
scatter.smooth(as.numeric(death["United Kingdom",])~year,span=0.2,
      ylab="", main = "United Kingdom",lwd=3,ylim=yl,
     xlim = c(1760,2012), pch = 19, cex=0.9,col="grey")

## ----barplot2, fig.align='center', cache=TRUE----------------------------
## Stacked Bar Charts
cars = read.csv("http://www.aejaffe.com/summerR_2016/data/kaggleCarAuction.csv",as.is=TRUE)
counts <- table(cars$IsBadBuy, cars$VehicleAge)
barplot(counts, main="Car Distribution by Age and Bad Buy Status",
  xlab="Vehicle Age", col=c("darkblue","red"),
    legend = rownames(counts))

## ----barplot2a, fig.align='center', cache=TRUE---------------------------
## Use percentages (column percentages)
barplot(prop.table(counts, 2), main="Car Distribution by Age and Bad Buy Status",
  xlab="Vehicle Age", col=c("darkblue","red"),
    legend = rownames(counts))

## ----barplot3, fig.align='center', cache=TRUE----------------------------
# Stacked Bar Plot with Colors and Legend    
barplot(counts, main="Car Distribution by Age and Bad Buy Status",
  xlab="Vehicle Age", col=c("darkblue","red"),
    legend = rownames(counts), beside=TRUE)

## ----boxplots, comment="",prompt=TRUE, fig.align='center', cache=FALSE----
boxplot(weight ~ Diet, data=ChickWeight, outline=FALSE)
points(ChickWeight$weight ~ jitter(as.numeric(ChickWeight$Diet),0.5))

## ----box_ex, eval=FALSE--------------------------------------------------
## boxplot(weight ~ Diet, data=ChickWeight, outline=FALSE)

## ----pal, fig.align='center', cache=TRUE---------------------------------
palette("default")
plot(1:8, 1:8, type="n")
text(1:8, 1:8, lab = palette(), col = 1:8)

## ----pal2, fig.align='center', cache=TRUE--------------------------------
palette(c("darkred","orange","blue"))
plot(1:3,1:3,col=1:3,pch =19,cex=2)

## ----pal3, fig.align='center', cache=FALSE-------------------------------
palette("default")
plot(weight ~ Time, data= ChickWeight, pch = 19, col = Diet)

## ----pal4, fig.align='center', cache=FALSE-------------------------------
library(RColorBrewer)
palette(brewer.pal(5,"Dark2"))
plot(weight ~ Time, data=ChickWeight, pch = 19,  col = Diet)

## ----pal5, fig.align='center', cache=FALSE-------------------------------
library(RColorBrewer)
palette(brewer.pal(5,"Dark2"))
plot(weight ~ jitter(Time,amount=0.2),data=ChickWeight,
     pch = 19,  col = Diet,xlab="Time")

## ----leg1, fig.align='center', cache=FALSE-------------------------------
palette(brewer.pal(5,"Dark2"))
plot(weight ~ jitter(Time,amount=0.2),data=ChickWeight,
                pch = 19,  col = Diet,xlab="Time")
legend("topleft", paste("Diet",levels(ChickWeight$Diet)), 
        col = 1:length(levels(ChickWeight$Diet)),
       lwd = 3, ncol = 2)

## ----circ, comment="",prompt=TRUE, fig.align='center', cache=FALSE-------
circ = read.csv("http://www.aejaffe.com/summerR_2016/data/Charm_City_Circulator_Ridership.csv", 
            header=TRUE,as.is=TRUE)
palette(brewer.pal(7,"Dark2"))
dd = factor(circ$day)
plot(orangeAverage ~ greenAverage, data=circ, 
     pch=19, col = as.numeric(dd))
legend("bottomright", levels(dd), col=1:length(dd), pch = 19)

## ----circ2, comment="",prompt=TRUE, fig.align='center', cache=FALSE------
dd = factor(circ$day, levels=c("Monday","Tuesday","Wednesday",
            "Thursday","Friday","Saturday","Sunday"))
plot(orangeAverage ~ greenAverage, data=circ,
     pch=19, col = as.numeric(dd))
legend("bottomright", levels(dd), col=1:length(dd), pch = 19)

## ----geoboxplot, comment="",prompt=TRUE, fig.align='center', cache=FALSE----
library(ggplot2)
qplot(factor(Diet), y = weight, 
      data = ChickWeight, geom = "boxplot")

## ----geoboxplot_g, comment="",prompt=TRUE, fig.align='center', cache=FALSE----
g = ggplot(aes(x = Diet, y = weight), data = ChickWeight)
g + geom_boxplot()

## ----geoboxpoint, comment="",prompt=TRUE, fig.align='center', cache=TRUE----
qplot( factor(Diet), y = weight, data = ChickWeight, 
       geom = c("boxplot", "jitter"))

## ----geoboxplot_add, comment="",prompt=TRUE, fig.align='center', cache=FALSE----
g + geom_boxplot() + geom_point(position = "jitter")

## ----geoboxplot_addjitter, fig.align='center', cache=FALSE---------------
g + geom_boxplot() + geom_jitter()

## ----hist, comment="",prompt=TRUE, fig.align='center', cache=FALSE-------
hist(ChickWeight$weight, breaks = 20)

## ----ghist, comment="",prompt=TRUE, fig.align='center', cache=TRUE-------
qplot(x = weight, 
      fill = factor(Diet),
      data = ChickWeight, 
      geom = c("histogram"))

## ----ghist_alpha, comment="",prompt=TRUE, fig.align='center', cache=TRUE----
qplot(x = weight, fill = Diet, data = ChickWeight, 
      geom = c("histogram"), alpha=I(.7))

## ----gdens, comment="",prompt=TRUE, fig.align='center', cache=TRUE-------
qplot(x= weight, fill = Diet, data = ChickWeight, 
      geom = c("density"), alpha=I(.7))

## ----gdens_alpha, comment="",prompt=TRUE, fig.align='center', cache=TRUE----
qplot(x= weight, colour = Diet, data = ChickWeight, 
      geom = c("density"), alpha=I(.7))

## ----gdens_alpha_gg, comment="",prompt=TRUE, fig.align='center', cache=TRUE----
ggplot(aes(x= weight, colour = Diet), 
  data = ChickWeight) + geom_density(alpha=I(.7))

## ----gdens_line_alpha, comment="",prompt=TRUE, fig.align='center', cache=TRUE----
ggplot(aes(x = weight, colour = Diet), data = ChickWeight) + 
  geom_line(stat = "density")

## ----spaghetti, comment="",prompt=TRUE, fig.align='center', cache=FALSE----
qplot(x=Time, y=weight, colour = Chick, 
      data = ChickWeight, geom = "line")

## ----fac_spag, comment="",prompt=TRUE, fig.align='center', cache=FALSE----
qplot(x = Time, y = weight, colour = Chick, 
      facets = ~Diet, data = ChickWeight, geom = "line")

## ----fac_spag_noleg, comment="",prompt=TRUE, fig.align='center', cache=FALSE----
qplot(x=Time, y=weight, colour = Chick, 
      facets = ~ Diet,  data = ChickWeight, 
        geom = "line") + guides(colour=FALSE)

## ----fac_spag2, comment="",prompt=TRUE, fig.align='center', cache=FALSE----
ggplot(aes(x = Time, y = weight, colour = Chick), 
    data = ChickWeight) + geom_line() + 
    facet_wrap(facets = ~Diet) + guides(colour = FALSE)

## ------------------------------------------------------------------------
library(tidyr)
long = death
long$state = rownames(long)
long = long %>% gather(year, deaths, -state)
head(long, 2)

## ------------------------------------------------------------------------
library(stringr)
library(dplyr)
long$year = long$year %>% str_replace("^X", "") %>% as.numeric
long = long %>% filter(!is.na(deaths))

## ----geom_line, comment="",prompt=TRUE, fig.align='center', cache=FALSE----
qplot(x = year, y = deaths, colour = state, 
    data = long, geom = "line") + guides(colour = FALSE)

## ----geom_tile-----------------------------------------------------------
qplot(x = year, y = state, colour = deaths, 
    data = long, geom = "tile") + guides(colour = FALSE)

