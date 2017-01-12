## example of taking only columns that end in average
circ2 = select(circ, day, date, ends_with("Average"))
long2 = gather(circ2, key = "var", value = "number", 
              ends_with("Average"))

## paste versus unite
reunited2 = long
reunited2$var = paste(reunited2$line, reunited2$type, sep=".")
reunited2$line = NULL
reunited2$type = NULL

## figuring out how to separate w/ period
##  e.g. fixed(".") vs ".", vs "\\."
long2 = separate(long, var, into = c("line", "type"), 
                sep = "\\.")
long = separate(long, var, into = c("line", "type"), 
                sep = "[.]")

### other merging examples
base <- data.frame(id = 1:10, Age= seq(55,60, length=10))
visits <- data.frame(id = rep(1:8, 3), visit= rep(1:3, 8),
                     Outcome = seq(10,50, length=24))
visits2 = rbind(visits, c(11,1,23))

merge(base, visits2, by="id") #
merge(base, visits2, by="id", all=TRUE)
merge(base, visits2, by="id", all.x=TRUE)
merge(base, visits2, by="id", all.y=TRUE)

left_join(base, visits2) # merge(...,all.x=TRUE)
right_join(base, visits2) # merge(...,all.y=TRUE)
inner_join(base, visits2) # merge(...,all=FALSE)
full_join(base, visits2) # merge(..., all=TRUE)

base2 = mutate(base, ID = id) %>% select(ID, Age)
inner_join(base2, visits2)
tail(inner_join(base2, visits2,
            by = c("ID" = "id")))
