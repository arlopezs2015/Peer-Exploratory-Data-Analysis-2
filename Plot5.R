##PLOT_5
##Required data
setwd("./data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##To call libraries
library(plyr)
library(ggplot2)
library(data.table)

##To filter the data
NEI_Balt <- NEI[(NEI$fips == "24510" & NEI$type=="ON-ROAD"), ]
emision<-with(NEI_Balt, aggregate(NEI_Balt[,"Emissions"], by = list(year), sum,na.rm=TRUE))

## Assign name to the series
names(emision)<-c('year','emission')

##To create the graph
png("plot5.png", width=480, height=480, units="px")
ggplot(emision,aes(x=year,y=emission))+
	geom_line() +
	xlab("Year") +
        ylab("Total PM2.5 Emissions") +
        ggtitle("Total Emissions from Motor in Baltimore City")

##close the the device png 
dev.off()
