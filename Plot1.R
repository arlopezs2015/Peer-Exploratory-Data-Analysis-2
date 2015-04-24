##PLOT_1
##Required data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##To call libraries
library(plyr)
library(ggplot2)
library(data.table)

##To filter the data
emision<-with(NEI, aggregate(NEI[,"Emissions"], by = list(year), sum,na.rm=TRUE))

## Assign name to the series
names(emision)<-c('year','emission')

##To create the graph
png("plot1.png", width=480, height=480)
plot(emision, type="l", xlab=" ", ylab="Anual Emission")

##close the the device png 
dev.off()
