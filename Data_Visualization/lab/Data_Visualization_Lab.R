### Data Visualization Lab
# 6/16/2016

## you will need the charm city circulator dataset:
# circ = read.csv("http://www.aejaffe.com/summerR_2016/data/Charm_City_Circulator_Ridership.csv", 
#            header=TRUE,as.is=TRUE)

# Using ggplot2:

# 1. plot average ridership  by date.
# 	a. Color the points by route (orange, purple, green, banner)
#	b. Color the points by day of the week

# 2. Replot 1a where the colors of the points are the
#	name of the route (with banner --> blue)

# 3. plot average ridership  by date with one panel per route

# 4. plot average ridership by date with separate panels
#		by day of the week, colored by route

# Using base R graphics:

# 5. plot average ridership on the orange route versus date
#		as a solid line, and add dashed "error" lines based 
#		on the boardings and alightings. 
#	the line colors should be orange.