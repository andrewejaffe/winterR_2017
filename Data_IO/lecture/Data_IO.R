## ---- echo = FALSE-------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")

## ----workingDirectory,eval=FALSE-----------------------------------------
## ## get the working directory
## getwd()
## # setwd("~/summerR_2016/Lectures")

## ----directoryNav--------------------------------------------------------
dir("./") # shows directory contents
dir("..")

## ----readCSV-------------------------------------------------------------
read.csv

## ----readCSV2------------------------------------------------------------
mon = read.csv("../../data/Monuments.csv",header=TRUE,as.is=TRUE)
head(mon)

## ----subset5-------------------------------------------------------------
colnames(mon) # column names
head(mon$zipCode) # first few rows

## ----readCSV3------------------------------------------------------------
str(mon) # structure of an R object

## ----names1--------------------------------------------------------------
names(mon)[1] = "Name"
names(mon)
names(mon)[1] = "name"
names(mon)

## ----writecsv------------------------------------------------------------
names(mon)[6] = "Location"
write.csv(mon, file="monuments_newNames.csv", row.names=FALSE)

