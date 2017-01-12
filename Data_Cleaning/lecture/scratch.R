NA


x = c(0, NA, 2, 3, 4)

x = c(5,5,0,NA,0, 0, 1,2,2,2,2,4)
unique(x)
table(x)

## white space
y = c("Male", "Male ", " Male")
y
table(y)
library(stringr)
str_trim(y)


table(x,useNA="ifany")
table(x[!is.na(x)],useNA="always")

tab <- table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
             c(0, 1, 2, 3, 2, 3, 3, 4, 4, 3), 
             useNA = "ifany")
Sal = read.csv("https://data.baltimorecity.gov/api/views/nsfe-bg53/rows.csv", 
            as.is = TRUE)
