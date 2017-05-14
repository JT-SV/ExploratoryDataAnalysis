# This script is part of the final assignment of the Exploratory
# Data Analysis course

# Question answered:
# Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland (fips=="25410")
# from 1999 to 2008? Use the base plotting system to 
# make a plot answering this question.

# Assume data is in the current directory
# Read the data

NEI <- readRDS("summarySCC_PM25.rds")

# Baltimore only 
DATA<-subset(NEI,fips=="24510")

# Aggregate data by year
DATA_agg<-aggregate(Emissions ~ year,DATA,sum)

# Pick basic colors 1 onwards
colors<-as.integer(as.factor(DATA_agg$year))

# Plot points - base color system
png(file="plot2.png",width=480,height=480,units="px")

with(DATA_agg,plot(year,Emissions,pch=19,col=colors))

# Reduced-size legend, out of the way
with(DATA_agg,legend("topright",legend=year,cex=0.75,pch=19,col=colors))

# Add connecting lines for effect
with(DATA_agg,lines(year,Emissions))

# Add title
title(main="Baltimore PM2.5 Emissions")

dev.off()
