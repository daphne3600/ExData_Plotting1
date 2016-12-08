library(lubridate); library(plyr); library(dplyr)
##Read into R, only need top  ~100,000 rows since data is by date from Dec 2006
dataset <- read.delim("./dataset/household_power_consumption.txt", nrows = 100000, sep = ";", na.strings = "?", stringsAsFactors = FALSE) 

##Format dates to Date class
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

##Extract relevant rows to plot
plot4data <- dataset[dataset$Date >= "2007-02-01" & dataset$Date <= "2007-02-02", ]

##Combine Date and Time and convert to POSIXlt format
x <- paste(plot4data$Date, plot4data$Time)
datetime <- strptime(x, format = "%Y-%m-%d %H:%M:%S")

##Plot to file
png(file = "plot4.png", width = 480, height = 480)
##Set up 2x2 plot area and plot by row first
par(mfrow = c(2,2))
##First plot is almost the same as Plot2
plot(datetime,plot4data$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")
##Second plot is new
plot(datetime,plot4data$Voltage, ylab = "Voltage", type = "l")
##Third plot is almost the same as Plot3
plot(datetime, plot4data$Sub_metering_1, col = "black", type = "l", ylab = "Energy sub metering", xlab = "")
lines(datetime, plot4data$Sub_metering_2, col = "red")
lines(datetime, plot4data$Sub_metering_3, col = "blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, bty = "n")
##Forth plot is new
plot(datetime, plot4data$Global_reactive_power, ylab = "Global_reactive_power", type = "l")
dev.off()