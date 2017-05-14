# This script is the final assignment of the Exploratory
# Data Analysis course

# This script answers the following question:
# Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037")
# has seen greater changes over time in motor vehicle emissions?

# Assume data is in the current directory
# Read the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the codes for motor vehicles
# Pull in the EI.Sector as well for inspection
motorVehicles<-SCC[grepl("^mobile",SCC$EI.Sector,ignore.case=T)
	&grepl("vehicle",SCC$EI.Sector,ignore.case=T),c("SCC","EI.Sector")]

# Subset the data using the motor vehicle codes and the fips for Baltimore, LA county
DATA<-subset(NEI,SCC %in% motorVehicles$SCC & (fips=="24510"|fips=="06037")) 

# Aggregate data by year and type
DATA_agg<-aggregate(Emissions ~ year+fips,DATA,sum)

# Pretty-up DATA_agg for straightforward plotting
DATA_agg[DATA_agg$fips=="06037","fips"]="LA"
DATA_agg[DATA_agg$fips=="24510","fips"]="Baltimore"
names(DATA_agg)<-c("Year","Location","Emissions") 

# Plot points using the quick ggplot2 qplot function
library(ggplot2)

png(file="plot6.png",width=480,height=480,units="px")
	
qplot(Year,Emissions,data=DATA_agg,col=Year, facets = .~ Location,
	main="Baltimore vs LA Motor Vehicle Emissions")
	
dev.off()
