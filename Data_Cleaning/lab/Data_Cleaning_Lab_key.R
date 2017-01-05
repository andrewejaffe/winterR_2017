#################
# Data Cleaning and Plotting
##############
# 6/15/2016

## Download the "Real Property Taxes" Data from my website (via OpenBaltimore):
# www.aejaffe.com/summerR_2016/data/real_property_tax.csv.gz
## note you don't need to unzip it to read it into R
rm( list = ls() ) # clear the workspace
library(stringr)
library(dplyr)

# 1. Read the Property Tax data into R and call it the variable `tax`
tax = read.csv( "~/GitHub/summerR_2016/data/real_property_tax.csv.gz", 
               stringsAsFactors = FALSE)
# write.csv(tax, file=gzfile("file.csv.gz"))

# 2. How many addresses pay property taxes? 
nrow(tax)
dim(tax)

# 3. What is the total city and state tax paid?
head(tax$cityTax)
cityTax = tax$cityTax %>% 
  str_replace(fixed("$"), "") %>%
  as.numeric
stateTax = tax$stateTax %>% 
  str_replace(fixed("$"), "") %>%
  as.numeric
head(cityTax)

head(tax$cityTax[ is.na(cityTax) ])
table(tax$cityTax[ is.na(cityTax) ])

head(tax$stateTax[ is.na(stateTax) ])
table(tax$stateTax[ is.na(stateTax) ])

tax$cityTax = cityTax
tax$stateTax = stateTax

sum(tax$cityTax, na.rm = TRUE)
sum(tax$cityTax, na.rm = TRUE)/1e6

sum(tax$stateTax, na.rm = TRUE)
sum(tax$stateTax, na.rm = TRUE)/1e6

# 4. What is the 75th percentile of city and state tax paid by address type?
head(tax$propertyAddress)
tax$propertyAddress = str_trim(tax$propertyAddress)
head(tax$propertyAddress)

tax$street = str_detect(tax$propertyAddress, "ST$")
tax$street = str_detect(tax$propertyAddress, "STREET$") | tax$street

ss = str_split(tax$propertyAddress," ")
tab = table(sapply(ss, last))

# 5. Split the data by ward into a list: 
### tax_list = split(tax, tax$street)

# Using `tapply()` and `table()`
#	a. how many observations are in each address type?
### sapply(tax_list, nrow)
sum(tax$street)
table(tax$street)
tapply(tax$propertyAddress, 
        tax$street, length)

#	b. what is the mean state tax per address type?
tax %>% 
  group_by(street) %>% 
  summarize(mean_state = mean(stateTax, na.rm = TRUE))

tapply(tax$stateTax, tax$street, mean, na.rm=TRUE)

## 75th percentile
tapply(tax$stateTax, tax$street,
       quantile, prob = 0.75, na.rm=TRUE)
tapply(tax$stateTax, tax$street,
       quantile, na.rm=TRUE)

# 6. Make boxplots using base graphics showing cityTax 
#	 	by whether the property	is a principal residence or not.
tax$resCode = str_trim(tax$resCode)
boxplot(log(cityTax+1) ~ resCode, data = tax)
# 7. Subset the data to only retain those houses that are principal residences. 
pres = tax %>% filter( resCode %in% "PRINCIPAL RESIDENCE")
pres = tax %>% filter( resCode == "PRINCIPAL RESIDENCE")
#	a) How many such houses are there?
dim(pres)
#	b) Describe the distribution of property taxes on these residences.
hist(log2(pres$cityTax+1))

# 8. Convert the 'lotSize' variable to a numeric square feet variable. 
#	Tips: - 1 acre = 43560 square feet
#		    - The hyphens represent inches (not decimals)
# 		  - Don't spend more than 5-10 minutes on this; stop and move on

tax$lotSize = str_trim(tax$lotSize) # trim to be safe
lot = tax$lotSize # for checking later

# first lets take care of acres
aIndex= c(grep("ACRE.*", tax$lotSize),
            grep(" %", tax$lotSize, fixed=TRUE))
head(aIndex)
head(lot[aIndex])

acre = tax$lotSize[aIndex] # temporary variable
## find and replace character strings
acre = gsub(" ACRE.*","",acre)
acre = gsub(" %","",acre)
table(!is.na(as.numeric(acre)))

head(acre[is.na(as.numeric(acre))],50)

## lets clean the rest
acre = gsub("-",".",acre,fixed=TRUE) # hyphen instead of decimal
head(acre[is.na(as.numeric(acre))])
table(!is.na(as.numeric(acre)))

acre = gsub("ACRES","", acre, fixed=TRUE)
head(acre[is.na(as.numeric(acre))])

# take care of individual mistakes
acre = gsub("O","0", acre, fixed=TRUE) # 0 vs O
acre = gsub("Q","", acre, fixed=TRUE) # Q, oops
acre = gsub(",.",".", acre, fixed=TRUE) # extra ,
acre = gsub(",","", acre, fixed=TRUE) # extra ,
acre = gsub("L","0", acre, fixed=TRUE) # leading L
acre[is.na(as.numeric(acre))]

acre2 = as.numeric(acre)*43560 
sum(is.na(acre2)) # all but one

#######################
## now square feet:
fIndex = grep("X", tax$lotSize)
ft = tax$lotSize[fIndex]

ft = gsub("&", "-", ft, fixed=TRUE)
ft = gsub("IMP ONLY ", "", ft, fixed=TRUE)
ft = gsub("`","1",ft,fixed=TRUE)

ft= sapply(str_split(ft, " "), first)

# wrapper for string split and sapply
#### ss = function(x, pattern, slot=1,...) sapply(strsplit(x,pattern,...), "[", slot)

width = sapply(str_split(ft,"X"), first)
length = sapply(str_split(ft,"X"), nth, 2) 

## width
widthFeet = as.numeric(sapply(str_split(width, "-"), first))
widthInch = as.numeric(sapply(str_split(width, "-"),nth,2))/12
widthInch[is.na(widthInch)] = 0 # when no inches present
totalWidth = widthFeet + widthInch # add together

# length
lengthFeet = as.numeric(sapply(str_split(length, "-"),first))
lengthInch = as.numeric(sapply(str_split(length, "-",2),nth,2))/12
lengthInch[is.na(lengthInch)] = 0 # when no inches present
totalLength = lengthFeet + lengthInch

# combine together for square feet
sqrtFt = totalWidth*totalLength 
ft[is.na(sqrtFt)] # what is left?

### combine together
tax$sqft = rep(NA)
tax$sqft[aIndex] = acre2
tax$sqft[fIndex] = sqrtFt
mean(!is.na(tax$sqft))

# already in square feet, easy!!
sIndex=c(grep("FT", tax$lotSize), 
         grep("S.*F.", tax$lotSize))
sf = tax$lotSize[sIndex] # subset temporary variable

sqft2 = sapply(str_split(sf,"( |SQ|SF)"),first)
sqft2 = as.numeric(gsub(",", "", sqft2)) # remove , and convert
tax$sqft[sIndex] = sqft2
table(is.na(tax$sqft)) 
## progress!

#what remains?
lot[is.na(tax$sqft)]
