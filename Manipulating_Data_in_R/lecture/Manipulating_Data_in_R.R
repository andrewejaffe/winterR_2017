## ---- echo = FALSE-------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")

## ------------------------------------------------------------------------
circ = read.csv("http://www.aejaffe.com/summerR_2016/data/Charm_City_Circulator_Ridership.csv", as.is = TRUE)
head(circ, 2)

## ---- message= FALSE-----------------------------------------------------
library(lubridate) # great for dates!
library(dplyr) # mutate/summarise functions
circ = mutate(circ, date = mdy(date))
sum( is.na(circ$date) ) # all converted correctly
head(circ$date)
class(circ$date)

## ------------------------------------------------------------------------
library(stringr)
cn = colnames(circ)
cn = cn %>% 
  str_replace("Board", ".Board") %>% 
  str_replace("Alight", ".Alight") %>% 
  str_replace("Average", ".Average") 
colnames(circ) = cn
cn

## ------------------------------------------------------------------------
circ$daily = NULL

## ---- echo = FALSE-------------------------------------------------------
ex_wide = data.frame(id = 1:2,
                     visit1 = c(10, 5),
                     visit2 = c(4, 6),
                     visit3 = c(3, NA)
                     )
ex_long = data.frame(id = c(rep(1, 3), rep(2, 2)),
                     visit = c(1:3, 1:2),
                     value = c(10, 4, 3, 5, 6))

## ---- echo = FALSE-------------------------------------------------------
ex_wide

## ---- echo = FALSE-------------------------------------------------------
ex_long

## ------------------------------------------------------------------------
library(tidyr)
long = gather(circ, key = "var", value = "number", 
              starts_with("orange"),
              starts_with("purple"), 
              starts_with("green"),
              starts_with("banner"))
head(long, 2)
table(long$var)

## ------------------------------------------------------------------------
long = separate_(long, "var", 
                 into = c("line", "type"), 
                 sep = "[.]")
head(long, 3)
unique(long$line)
unique(long$type)

## ------------------------------------------------------------------------
long = long %>% filter(!is.na(number) & number > 0)
first_and_last = long %>% arrange(date) %>% # arrange by date
  filter(type %in% "Boardings") %>% # keep boardings only
  group_by(line) %>% # group by line
  slice( c(1, n())) # select ("slice") first and last (n() command) lines
first_and_last %>%  head(4)

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
gb = group_by(wide, line)
summarize(gb, mean_avg = mean(Average))

## ------------------------------------------------------------------------
wide %>% 
  group_by(line) %>%
  summarise(mean_avg = mean(Average))

## ------------------------------------------------------------------------
wide = wide %>% mutate(year = year(date),
                       month = month(date))
wide %>% 
  group_by(line, year) %>%
  summarise(mean_avg = mean(Average))

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

## ------------------------------------------------------------------------
bike = read.csv(
  "http://www.aejaffe.com/summerR_2016/data/Bike_Lanes.csv",
  as.is = TRUE)

## ---- message = FALSE----------------------------------------------------
bike %>% 
  group_by(project) %>% 
  summarise(mean(length)) # get the average length

## ---- message = FALSE----------------------------------------------------
bike %>% 
  group_by(project) %>% 
  summarize(mean_length = mean(length)) %>% 
  head(4) # head ONLY for slide printing

