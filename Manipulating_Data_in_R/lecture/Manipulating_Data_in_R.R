## ---- echo = FALSE-------------------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")

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

## ---- message = FALSE----------------------------------------------------
circ = read_csv(
  paste0("http://www.aejaffe.com/winterR_2017/",
         "data/Charm_City_Circulator_Ridership.csv")
)
head(circ, 2)

## ---- message = FALSE----------------------------------------------------
library(lubridate) # great for dates!
library(dplyr) # mutate/summarise functions

## ---- message= FALSE-----------------------------------------------------
sum(is.na(circ$date))
sum( circ$date == "")
circ = mutate(circ, date = mdy(date))
sum( is.na(circ$date) ) # all converted correctly
head(circ$date, 3)
class(circ$date)

## ------------------------------------------------------------------------
library(tidyr)
long = gather(circ, key = "var", value = "number", 
              starts_with("orange"), starts_with("purple"),
              starts_with("green"), starts_with("banner"))
head(long, 4)

## ------------------------------------------------------------------------
table(long$var)

## ------------------------------------------------------------------------
library(stringr)
long = long %>% mutate(
  var = var %>% str_replace("Board", ".Board") %>% 
    str_replace("Alight", ".Alight") %>% 
    str_replace("Average", ".Average") 
)
table(long$var)

## ------------------------------------------------------------------------
long = separate(long, var, into = c("line", "type"), 
                 sep = "[.]")
head(long, 2)
unique(long$line)
unique(long$type)

## ------------------------------------------------------------------------
reunited = long %>% 
  unite(col = var, line, type, sep = ".")  
reunited %>% select(day, var) %>% head(3) %>% print

## ---- eval = FALSE-------------------------------------------------------
## cn = colnames(circ)
## cn = cn %>%
##   str_replace("Board", ".Board") %>%
##   str_replace("Alight", ".Alight") %>%
##   str_replace("Average", ".Average")
## colnames(circ) = cn # then reshape using gather!

## ------------------------------------------------------------------------
# have to remove missing days
wide = filter(long, !is.na(date))
wide = spread(wide, type, number)
head(wide)

## ------------------------------------------------------------------------
# wide = wide %>%
#     select(Alightings, Average, Boardings) %>%
#     mutate(good = rowSums(is.na(.)) > 0)
not_namat = !is.na(select(wide, Alightings, Average, Boardings))
head(not_namat, 2)
wide$good = rowSums(not_namat) > 0

## ------------------------------------------------------------------------
wide = filter(wide, good) %>% select(-good)
head(wide)

## ------------------------------------------------------------------------
long = long %>% filter(!is.na(number) & number > 0)
first_and_last = long %>% arrange(date) %>% # arrange by date
  filter(type %in% "Boardings") %>% # keep boardings only
  group_by(line) %>% # group by line
  slice( c(1, n())) # select ("slice") first and last (n() command) lines
first_and_last %>%  head(4)

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
library(ggplot2)
ggplot(aes(x = date, y = Average, colour = line), data = wide) + geom_line()

## ------------------------------------------------------------------------
wide %>% 
  ggplot(aes(x = date, y = Average, colour = line)) + geom_line()

## ------------------------------------------------------------------------
mon = wide %>% 
  mutate(month = month(date), year = year(date)) %>%   
  dplyr::group_by(line, month, year) %>%
  dplyr::summarise(mean_avg = mean(Average))
mon = mutate(mon, mid_month = dmy(paste0("15-", month, "-", year)))
head(mon)

## ------------------------------------------------------------------------
ggplot(aes(x = mid_month,
               y = mean_avg, 
               colour = line), data = mon) + geom_line()

## ------------------------------------------------------------------------
ggplot(aes(x = date, y = Average, colour = line), 
           data = wide) + geom_smooth(se = FALSE) + 
  geom_point(size = .5)

