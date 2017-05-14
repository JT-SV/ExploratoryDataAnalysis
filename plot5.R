# This script is the final assignment of the Exploratory
# Data Analysis course

# This script answers the following question:
# How have emissions from motor vehicle sources changed from 
# 1999–2008 in Baltimore City?

# Assume data is in the current directory
# Read the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the codes for motor vehicles
# Pull in EI.Sector as well for inspection
motorVehicles<-SCC[grepl("^mobile",SCC$EI.Sector,ignore.case=T)
	&grepl("vehicle",SCC$EI.Sector,ignore.case=T),c("SCC","EI.Sector")]

# Subset the data using the codes found above and the fips for Baltimore
DATA<-subset(NEI,SCC %in% motorVehicles$SCC & fips=="24510") 

# Aggregate data by year and type
DATA_agg<-aggregate(Emissions ~ year,DATA,sum)

# Rename 'year' for easier plotting
names(DATA_agg)<-c("Year","Emissions") 

# Plot points using the quick ggplot2 qplot function
library(ggplot2)

png(file="plot5.png",width=480,height=480,units="px")
	
qplot(Year,Emissions,data=DATA_agg,col=Year,
	main="Baltimore Motor Vehicle Emissions")
	
dev.off()
