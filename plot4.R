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
datetime <- as.POSIXct(paste(dates,times), format="%Y-%m-%d %H:%M:%S")

#Sub metering:

one <- as.numeric(as.character(data1$Sub_metering_1))
two <- as.numeric(as.character(data1$Sub_metering_2))
three <- as.numeric(as.character(data1$Sub_metering_3))

#Global active power: 

GAP <- as.numeric(as.character(data1[,3]))
datetime <- as.POSIXct(paste(dates,times), format="%Y-%m-%d %H:%M:%S")

#voltage 

voltage <- as.numeric(as.character(data1$Voltage))

#Global reactive power

Global_reactive_power <- as.numeric(as.character(data1$Global_reactive_power))

par(mfrow=c(2,2))

hist(GAP, main = "Global Active Power", xlab = "Global Active Power (kW)", col = "red", ylab = "Frequency")

plot(datetime, voltage, type ="l", main = "Voltage", xlab = "Day")
plot(datetime, GAP, type = "l", main ="Global Active Power", ylab = "Global Active Power (kW)", xlab = "Day")

plot(datetime, one, type = "l",col = "black", ylab = "Energy sub metering", xlab = "Day", 
     main = "Sub metering ")
lines(datetime, two, type = "l", col = "blue")
lines(datetime, three, type = "l", col = "red")

legend('topright', c("sub metering 1", "sub metering 2", "sub metering 3"), lty=1, col=c('black', 'blue', 'red'), bty='n', cex=.75)

dev.copy(png, file='plot4.png', height=480, width=480)
dev.off()
