## ---- dataImport---------------------------------------------------------
death = read.csv("http://www.aejaffe.com/winterR_2016/data/indicatordeadkids35.csv",
                 as.is=TRUE,header=TRUE, row.names=1)

## ---- question1----------------------------------------------------------
library(dplyr)
library(stringr)
year = names(death) %>% str_replace("X","") %>% as.integer
head(year)
class(year)

## ---- question2----------------------------------------------------------
deathT = as.data.frame(t(death))
colnames(deathT) = colnames(deathT) %>% 
                    str_replace_all(" ","_")
colnames(deathT) = sapply(str_split(colnames(deathT), 
                                      fixed(" (")), first)
colnames(deathT) = sapply(str_split(colnames(deathT), 
                                      fixed(",")), first)    
rownames(deathT) = year
deathT$year= year
deathT[1:5,1:5]

## ---- question3----------------------------------------------------------
pop = read.delim("http://www.aejaffe.com/winterR_2016/data/country_pop.txt",
  as.is=TRUE)
colnames(pop)[c(2,5)] = c("Country", "percWorldPop")
pop$Country = pop$Country  %>% 
                    str_replace_all(" ","_")
pop$Country  = sapply(str_split(pop$Country , 
                                      fixed(" (")), first)
pop$Country  = sapply(str_split(pop$Country , 
                                      fixed(",")), first)  
pop$Country = str_trim(pop$Country)

pop$Population = pop$Population %>% 
    str_replace_all(",","") %>%
    as.integer
library(lubridate)
pop$Date = dmy(pop$Date)
pop$percWorldPop = pop$percWorldPop %>% 
  str_replace_all("%","") %>% as.numeric
head(pop)

## ----question4-----------------------------------------------------------
mm = match(pop$Country, names(deathT))
sorted = deathT[,mm[!is.na(mm)]]
sorted[1:5,1:5]

## ---- question 5a--------------------------------------------------------
library(tidyr)
aCountry = death[grep("^A", rownames(death)), year %in% 1840:1900]
aCountry$Country = rownames(aCountry)
aLong = aCountry %>% gather(year, deaths, -Country)
aLong$year = aLong$year %>% str_replace("^X", "") %>% as.numeric

library(ggplot2)
qplot(x = year, y = Country, colour = deaths, 
    data = aLong, geom = "tile") + guides(colour = FALSE)

## ------------------------------------------------------------------------
NC = ncol(sorted)
smallAndLarge = as.data.frame(t(sorted[rownames(sorted) %in% 1950:1975, 
                        c(1:10, (NC-9):NC)]))
smallAndLarge$Country = rownames(smallAndLarge)
slLong = smallAndLarge %>% gather(year, deaths, -Country)
slLong$year = slLong$year %>% as.character %>% 
    str_replace("^X", "") %>% as.numeric

qplot(x = year, y = Country, colour = deaths, 
    data = slLong, geom = "tile") + guides(colour = FALSE)

## ------------------------------------------------------------------------
whichCountry = which(nchar(rownames(death)) >= 7 &
                  nchar(rownames(death)) <= 10)
stDeath = death[whichCountry, year %in% 1975:2010]
stDeath$Country = rownames(stDeath)
stLong = stDeath %>% gather(year, deaths, -Country)
stLong$year = stLong$year %>% str_replace("^X", "") %>% as.numeric

NC = ncol(sorted)
smallAndLarge = as.data.frame(t(sorted[rownames(sorted) %in% 1950:1975, 
                        c(1:10, (NC-9):NC)]))
smallAndLarge$Country = rownames(smallAndLarge)
slLong = smallAndLarge %>% gather(year, deaths, -Country)
slLong$year = slLong$year %>% as.character %>% 
    str_replace("^X", "") %>% as.numeric

qplot(x = year, y = deaths, colour = Country, 
    data = slLong, geom = "line")

