##PLOT_2
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

##To create the graph
png("plot2.png", width=480, height=480)
plot(emision$year,emision$emission, type="b", pch=18, col = "green", ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")
dev.off()
