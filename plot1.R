#rm(list=ls())
library(plyr)
library(lubridate)

#getwd() use as appropriate. Code assumes you are in the same directory as the data file below. 
#setwd()

HPCdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

HPCdata$Date <- dmy(HPCdata$Date)
t1data <- HPCdata[HPCdata$Date == "2007-02-01",]
t2data <- HPCdata[HPCdata$Date == "2007-02-02",]
data1 <- rbind(t1data, t2data)

GAP <- as.numeric(as.character(data1[,3]))

hist(GAP, main = "Global Active Power", xlab = "Global Active Power (kW)", col = "red", ylab = "Frequency")
 
dev.copy(png,'plot1.png',  width = 480, height = 480)
dev.off() 

