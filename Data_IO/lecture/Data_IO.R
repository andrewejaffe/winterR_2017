## ---- echo = FALSE-------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")

## ----workingDirectory,eval=FALSE-----------------------------------------
## ## get the working directory
## getwd()
## setwd("~/Lectures")

## ----directoryNav--------------------------------------------------------
dir("./") # shows directory contents
dir("..")

## ---- eval = FALSE-------------------------------------------------------
## setwd("~/Lectures/Data_IO/lecture")

## ---- eval = FALSE-------------------------------------------------------
## ?dir
## help("dir")

## ----readCSV-------------------------------------------------------------
read.csv

## ----readCSV2------------------------------------------------------------
mon = read.csv("../../data/Monuments.csv", header = TRUE, as.is = TRUE)
head(mon)
class(mon)

## ----subset5-------------------------------------------------------------
colnames(mon) # column names
head(mon$zipCode) # first few rows

## ----readCSV3------------------------------------------------------------
str(mon) # structure of an R object

## ----readCSV_readr, message=FALSE----------------------------------------
library(readr)
mon_tbl = read_csv("../../data/Monuments.csv")
head(mon_tbl)
class(mon_tbl)

## ----names1--------------------------------------------------------------
names(mon)[1] = "Name"
names(mon)
names(mon)[1] = "name"
names(mon)

## ----writecsv------------------------------------------------------------
names(mon)[6] = "Location"
write.csv(mon, file="monuments_newNames.csv", row.names=FALSE)

