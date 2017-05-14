# This script is part of the final assignment of the Exploratory
# Data Analysis course

# Question answered:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the 
# ggplot2 plotting system to make a plot answer this question.

# Assume data is in the current directory
# Read the data

NEI <- readRDS("summarySCC_PM25.rds")

# Baltimore only 
DATA<-subset(NEI,fips=="24510")

# Aggregate data by year and type (point, nonpoint, ...)
DATA_agg<-aggregate(Emissions ~ year+type,DATA,sum)

# Plot points using ggplot2 basic qplot, four plots (facets)
library(ggplot2)

png(file="plot3.png",width=480,height=480,units="px")

with(DATA_agg,qplot(year,Emissions,facets = .~type, xlab="Year",
			main="Baltimore Emissions by Type"))

dev.off()
