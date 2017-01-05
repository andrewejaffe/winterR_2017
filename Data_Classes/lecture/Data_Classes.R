## ----numChar-------------------------------------------------------------
class(c("Andrew", "Jaffe"))
class(c(1, 4, 7))

## ----seq-----------------------------------------------------------------
x = seq(from = 1, to = 5) # seq() is a function
x
class(x)

## ----seqShort------------------------------------------------------------
1:5

## ----logical1------------------------------------------------------------
x = c(TRUE, FALSE, TRUE, TRUE, FALSE)
class(x)

## ----logical2------------------------------------------------------------
z = c("TRUE", "FALSE", "TRUE", "FALSE")
class(z)

## ----factor1-------------------------------------------------------------
x = factor(c("boy", "girl", "girl", "boy", "girl"))
x 
class(x)

## ----factor2-------------------------------------------------------------
cc = factor(c("case","case","case",
        "control","control","control"))
cc
levels(cc) = c("control","case")
cc

## ----factor_cc_again-----------------------------------------------------
factor(c("case","case","case","control",
          "control","control"), 
        levels =c("control","case") )
factor(c("case","case","case","control",
            "control","control"), 
        levels =c("control","case"), ordered=TRUE)

## ----factor3-------------------------------------------------------------
x = factor(c("case","case","case","control",
      "control","control"),
        levels =c("control","case") )
as.character(x)
as.numeric(x)

## ----factorCheck---------------------------------------------------------
xCopy = x
levels(xCopy) = c("case", "control") # wrong way
xCopy        
as.character(xCopy) # labels switched
as.numeric(xCopy)

## ----rep1----------------------------------------------------------------
bg = rep(c("boy","girl"),each=50)
head(bg)
bg2 = rep(c("boy","girl"),times=50)
head(bg2)
length(bg)==length(bg2)

## ------------------------------------------------------------------------
circ = read.csv("http://www.aejaffe.com/winterR_2016/data/Charm_City_Circulator_Ridership.csv", 
            header=TRUE,as.is=TRUE)

## ----ifelse1-------------------------------------------------------------
hi_rider = ifelse(circ$daily > 10000, "high", "low")
hi_rider = factor(hi_rider, levels = c("low","high"))
head(hi_rider)
table(hi_rider)

## ----ifelse2-------------------------------------------------------------
riderLevels = ifelse(circ$daily < 10000, "low", 
                  ifelse(circ$daily > 20000,
                  "high", "med"))
riderLevels = factor(riderLevels, 
              levels = c("low","med","high"))
head(riderLevels)
table(riderLevels)

## ----cut1----------------------------------------------------------------
x = 1:100
cx = cut(x, breaks=c(0,10,25,50,100))
head(cx)  
table(cx)

## ----cut2----------------------------------------------------------------
cx = cut(x, breaks=c(0,10,25,50,100), labels=FALSE)
head(cx)  
table(cx)

## ----cut3----------------------------------------------------------------
cx = cut(x, breaks=c(10,25,50), labels=FALSE)
head(cx)  
table(cx)
table(cx,useNA="ifany")

## ----date----------------------------------------------------------------
head(sort(circ$date))
circ$newDate <- as.Date(circ$date, "%m/%d/%Y") # creating a date for sorting
head(circ$newDate)
range(circ$newDate)

## ------------------------------------------------------------------------
library(lubridate) # great for dates!
suppressPackageStartupMessages(library(dplyr))
circ = mutate(circ, newDate2 = mdy(date))
head(circ$newDate2)
range(circ$newDate2)

## ------------------------------------------------------------------------
theTime = Sys.time()
theTime
class(theTime)
theTime + 5000

## ----matrix--------------------------------------------------------------
n = 1:9 
n
mat = matrix(n, nrow = 3)
mat

## ----subset3-------------------------------------------------------------
mat[1, 1] # individual entry: row 1, column 1
mat[1, ] # first row
mat[, 1] # first columns

## ----subset4-------------------------------------------------------------
class(mat[1, ])
class(mat[, 1])

## ------------------------------------------------------------------------
library(matrixStats,quietly = TRUE)
avgs = select(circ, ends_with("Average"))
rowMins(as.matrix(avgs),na.rm=TRUE)[500:510]

## ------------------------------------------------------------------------
ar = array(1:27, c(3,3,3))
ar[,,1]
ar[,1,]

## ----makeList, comment="", prompt=TRUE-----------------------------------
mylist <- list(letters=c("A", "b", "c"), 
        numbers=1:3, matrix(1:25, ncol=5))

## ----Lists, comment="", prompt=TRUE--------------------------------------
head(mylist)

## ----Listsref1, comment="", prompt=TRUE----------------------------------
mylist[1] # returns a list
mylist["letters"] # returns a list

## ----Listsrefvec, comment="", prompt=TRUE--------------------------------
mylist[[1]] # returns the vector 'letters'
mylist$letters # returns vector
mylist[["letters"]] # returns the vector 'letters'

## ----Listsref2, comment="", prompt=TRUE----------------------------------
mylist[1:2] # returns a list

## ----Listsref3, comment="", prompt=TRUE----------------------------------
mylist$letters[1]
mylist[[2]][1]
mylist[[3]][1:2,1:2]

## ----split1, comment="", prompt=TRUE-------------------------------------
dayList = split(circ,circ$day)

## ----lapply1, comment="", prompt=TRUE------------------------------------
# head(dayList)
lapply(dayList, head, n=2)

## ----lapply2, comment="", prompt=TRUE------------------------------------
# head(dayList)
lapply(dayList, dim)

