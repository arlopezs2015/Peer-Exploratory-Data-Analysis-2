##PLOT_4
##Required data
setwd("./data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##To call libraries
library(plyr)
library(ggplot2)
library(data.table)

##To filter the data
coal_data <-SCC[grep("^Coal ", SCC$SCC.Level.Three),"SCC"]
coal_emision <- NEI[NEI$SCC %in% coal_data,]
emision<-with(coal_emision, aggregate(coal_emision[,"Emissions"], by = list(year), sum,na.rm=TRUE))

## Assign name to the series
names(emision)<-c("year","emission")

##To create the graph
png("plot4.png", width=480, height=480, units="px")
ggplot(emision,aes(x=year,y=emission))+
	geom_line() +
        xlab("Year") +
        ylab("Total PM2.5 Emissions") +
        ggtitle("Emissions from Coal Combustion for the US")

##close the the device png 
dev.off()

