##PLOT_6
##Required data
setwd("./data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##To call libraries
library(plyr)
library(ggplot2)
library(data.table)

##To filter the data
##emision<-aggregate(NEI_Veh$Emissions, list(NEI_Veh$year,NEI_Veh$fips), sum,na.rm=TRUE)
NEI_Veh1 <- NEI[(NEI$type=="ON-ROAD") & (NEI$fips %in% c("24510")),]
NEI_Veh1$fips<-"Baltimore"
NEI_Veh2 <- NEI[(NEI$type=="ON-ROAD") & (NEI$fips %in% c("06037")),]
NEI_Veh2$fips<-"LA"

emision1<-aggregate(NEI_Veh1$Emissions, list(NEI_Veh1$year,NEI_Veh1$fips), sum,na.rm=TRUE)
emision2<-aggregate(NEI_Veh2$Emissions, list(NEI_Veh2$year,NEI_Veh2$fips), sum,na.rm=TRUE)

emision_1y2<-rbind(emision1,emision2)

## Assign name to the series
names(emision_1y2)<-c('year','city','emission')

##To create the graph
png("plot6.png", width=480, height=480, units="px")

ggplot(emision_1y2,aes(x=year,y=emission,fill=city))+
	geom_bar(aes(fill=year),stat="identity") +
	facet_grid(.~city) +
	labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
	labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

##close the the device png 
dev.off()

