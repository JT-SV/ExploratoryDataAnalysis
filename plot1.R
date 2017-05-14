# This script is part of the final assignment of the Exploratory
# Data Analysis course

# Question answered:
# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Assume data is in the current directory
# Read the data

NEI <- readRDS("summarySCC_PM25.rds")

DATA<-NEI

# Aggregate data by year
DATA_agg<-aggregate(Emissions ~ year,DATA,sum)

# Pick basic colors 1 onwards
colors<-as.integer(as.factor(DATA_agg$year))

# Plot points - base plotting 

png(file="plot1.png",width=480,height=480,units="px")

with(DATA_agg,plot(year,Emissions,pch=19,col=colors,xlab="Year"))

# Reduced size legend, out of the way
with(DATA_agg,legend("topright",legend=year,bty="n",cex=0.6,pch=19,col=colors))

# Add connecting lines for effect
with(DATA_agg,lines(year,Emissions))

# Add title
title(main="USA PM2.5 Emissions")

dev.off()
