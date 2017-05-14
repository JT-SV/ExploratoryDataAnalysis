# This script is the final assignment of the Exploratory
# Data Analysis course

# This script answers the following question:
# Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999–2008?

# Assume data is in the current directory
# Read the data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the codes where both coal and combustion appear in the sector
# Pull in EI.Sector as well for inspection
coalCombustion<-SCC[grepl("comb",SCC$EI.Sector,ignore.case=T)
	&grepl("coal",SCC$EI.Sector,ignore.case=T),c("SCC","EI.Sector")]

# Subset the data using the codes found above
DATA<-subset(NEI,SCC %in% coalCombustion$SCC) 

# Aggregate data by year and type
DATA_agg<-aggregate(Emissions ~ year,DATA,sum)

# Rename 'year' for easier plotting
names(DATA_agg)<-c("Year","Emissions") 

# Plot points using the quick ggplot2 qplot function
library(ggplot2)

png(file="plot4.png",width=480,height=480,units="px")
	
qplot(Year,Emissions,data=DATA_agg,col=Year,
	main="USA Coal Combustion Emissions")
	
dev.off()
