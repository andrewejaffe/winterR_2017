## ---- echo = FALSE-------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")

## ------------------------------------------------------------------------
library(dplyr)
library(tidyr)

## ------------------------------------------------------------------------
ex_data = read.csv("http://www.aejaffe.com/winterR_2016/data/Charm_City_Circulator_Ridership.csv", as.is = TRUE)
head(ex_data, 2)

## ------------------------------------------------------------------------
library(lubridate) # great for dates!
ex_data = mutate(ex_data, date = mdy(date))
nrow(ex_data[ is.na(ex_data$date), ])
head(ex_data$date)
class(ex_data$date)

## ------------------------------------------------------------------------
library(stringr)
cn = colnames(ex_data)
cn = cn %>% 
  str_replace("Board", ".Board") %>% 
  str_replace("Alight", ".Alight") %>% 
  str_replace("Average", ".Average") 
colnames(ex_data) = cn

## ------------------------------------------------------------------------
ex_data$daily = NULL

## ------------------------------------------------------------------------
long = gather(ex_data, "var", "number", 
              starts_with("orange"),
              starts_with("purple"), 
              starts_with("green"),
              starts_with("banner"))
head(long)
table(long$var)

## ------------------------------------------------------------------------
long = separate_(long, "var", 
                 into = c("line", "type"), 
                 sep = "[.]")
head(long)
table(long$line)
table(long$type)

## ------------------------------------------------------------------------
# have to remove missing days
wide = filter(long, !is.na(date))
wide = spread(wide, type, number)
head(wide)

## ------------------------------------------------------------------------
# wide = wide %>%
#     select(Alightings, Average, Boardings) %>%
#     mutate(good = rowSums(is.na(.)) > 0)
namat = !is.na(select(wide, Alightings, Average, Boardings))
head(namat)
wide$good = rowSums(namat) > 0
head(wide, 3)

## ------------------------------------------------------------------------
wide = filter(wide, good) %>% select(-good)
head(wide)

## ----merging-------------------------------------------------------------
base <- data.frame(id = 1:10, Age= seq(55,60, length=10))
base[1:2,]
visits <- data.frame(id = rep(1:8, 3), visit= rep(1:3, 8),
                    Outcome = seq(10,50, length=24))
visits[1:2,]

## ----merging2------------------------------------------------------------
merged.data <- merge(base, visits, by="id")
merged.data[1:5,]
dim(merged.data)

## ----mergeall------------------------------------------------------------
all.data <- merge(base, visits, by="id", all=TRUE)
tail(all.data)
dim(all.data)

## ----left_join-----------------------------------------------------------
lj = left_join(base, visits)
dim(lj)
tail(lj)

## ----right_join----------------------------------------------------------
rj = right_join(base, visits)
dim(rj)
tail(rj)

## ----full_join-----------------------------------------------------------
fj = full_join(base, visits)
dim(fj)
tail(fj)

## ------------------------------------------------------------------------
args(tapply)

## ------------------------------------------------------------------------
rest = tapply(wide$Average, wide$line, mean, na.rm = TRUE)

## ------------------------------------------------------------------------
gb = group_by(wide, line)
ress = summarize(gb, mean_avg = mean(Average))

ss = wide %>% 
    group_by(line) %>% 
    summarize(mean_boarding = mean(Boardings, na.rm = TRUE),
              mean_alight = mean(Alightings, na.rm = TRUE))

## ------------------------------------------------------------------------
wide %>% 
  group_by(line) %>%
  summarise(mean_avg = mean(Average))

## ------------------------------------------------------------------------
wide = wide %>% mutate(year = year(date),
                       month = month(date))
ss = wide %>% 
  group_by(line, year) %>%
  summarise(
    mean_boardings = mean(Boardings, na.rm = TRUE),
    num_na = sum(is.na(Boardings)))


all_years = expand.grid(
  line = c("banner", "green"),  
  year = 2010:2015)

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(aes(x = date, y = Average, 
               colour = line), data = wide) + geom_line()

## ------------------------------------------------------------------------
mon = wide %>% 
  dplyr::group_by(line, month, year) %>%
  dplyr::summarise(mean_avg = mean(Average))
mon = mutate(mon, 
             mid_month = dmy(paste0("15-", month, "-", year)))
head(mon)

## ------------------------------------------------------------------------
ggplot(aes(x = mid_month,
               y = mean_avg, 
               colour = line), data = mon) + geom_line()

## ------------------------------------------------------------------------
ggplot(aes(x = date, y = Average, colour = line), 
           data = wide) + geom_smooth(se = FALSE) + 
  geom_point(size = .5)

