library(plyr)
library(lubridate)

#getwd() use as appropriate. Code assumes you are in the same directory as the data file below. 
#setwd()

HPCdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

HPCdata$Date <- dmy(HPCdata$Date)
t1data <- HPCdata[HPCdata$Date == "2007-02-01",]
t2data <- HPCdata[HPCdata$Date == "2007-02-02",]
data1 <- rbind(t1data, t2data)

times <- as.character(data1$Time)
dates <- data1$Date

GAP <- as.numeric(as.character(data1[,3]))
datetime <- as.POSIXct(paste(dates,times), format="%Y-%m-%d %H:%M:%S")

plot(datetime, GAP, type = "l", main ="Global Active Power", ylab = "Global Active Power (kW)", xlab = "Day")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()