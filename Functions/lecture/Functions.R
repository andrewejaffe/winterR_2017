## ----return2, comment="",prompt=TRUE-------------------------------------
return2 = function(x) {
  return(x[2])
}
return2(c(1,4,5,76))

## ----return2a, comment="",prompt=TRUE------------------------------------
return2a = function(x) {
  x[2]
}
return2a(c(1,4,5,76))

## ----return2b, comment="",prompt=TRUE------------------------------------
return2b = function(x) x[2]
return2b(c(1,4,5,76))

## ----return2c, comment="",prompt=TRUE------------------------------------
return2c = function(x,n) x[n]
return2c(c(1,4,5,76), 3)

## ----sqdif, comment="",prompt=TRUE---------------------------------------
sqdif <- function(x=2,y=3){
     (x-y)^2
}

sqdif()
sqdif(x=10,y=5)
sqdif(10,5)

## ----top, comment="",prompt=TRUE-----------------------------------------
top = function(mat,n=5) mat[1:n,1:n]
my.mat = matrix(1:1000,nr=100) 
top(my.mat) #note that we are using the default value for n 

## ----top2, comment="",prompt=TRUE----------------------------------------
circ = read.csv("http://www.aejaffe.com/winterR_2016/data/Charm_City_Circulator_Ridership.csv", 
            header=TRUE,as.is=TRUE)
dayList = split(circ, circ$day)
lapply(dayList, top, n = 2)

## ----top3, comment="",prompt=TRUE----------------------------------------
lapply(dayList, function(x) x[1:2,1:2])

## ----sapply1, comment="", prompt=TRUE------------------------------------
sapply(dayList, dim)
sapply(circ, class)

## ----sapply2, comment="", prompt=TRUE------------------------------------
myList = list(a=1:10, b=c(2,4,5), c = c("a","b","c"),
                d = factor(c("boy","girl","girl")))
tmp = lapply(myList,function(x) x[1])
tmp
sapply(tmp, class)

## ----sapply3, comment="", prompt=TRUE------------------------------------
sapply(myList,function(x) x[1])
sapply(myList,function(x) as.character(x[1]))

