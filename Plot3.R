##PLOT_3
setwd("./data")
##Required data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##To call libraries
library(plyr)
library(ggplot2)
library(data.table)

##To filter the data
NEI_Balt <- NEI[which(NEI$fips == "24510"), ]

emision<-with(NEI_Balt, aggregate(NEI_Balt[,"Emissions"], by = list(year), sum,na.rm=TRUE))

## Assign name to the series
names(emision)<-c('year','emission')

emision_type<-ddply(NEI_Balt,.(type,year),summarize, Emissions = sum(Emissions))
emision_type$poll_type<-emision_type$type

##To create the graph
png("plot3.png", width=480, height=480)
ggplot(data=emision_type,aes(x=year,y=Emissions, group=type, colour=type))+geom_line() +
        xlab("Year") +
        ylab("PM2.5 (tons)") +
        ggtitle("Total PM2.5 Emissions (tons) Per Year by Source Type")

##close the the device png 
dev.off()
