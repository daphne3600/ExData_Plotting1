library(lubridate); library(plyr); library(dplyr)
##Read into R, only need top  ~100,000 rows since data is by date from Dec 2006
dataset <- read.delim("./dataset/household_power_consumption.txt", nrows = 100000, sep = ";", na.strings = "?", stringsAsFactors = FALSE) 
unlink(temp)

##Format dates to Date class
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

##Extract relevant data to plot
plot3data <- dataset[dataset$Date >= "2007-02-01" & dataset$Date <= "2007-02-02", c(1,2,7:9)]

##Combine Date and Time and convert to POSIXlt format
x <- paste(plot3data$Date, plot3data$Time)
DateTime <- strptime(x, format = "%Y-%m-%d %H:%M:%S")

##Plot to file
png(file = "plot3.png", width = 480, height = 480)
plot(DateTime, plot3data$Sub_metering_1, col = "black", type = "l", ylab = "Energy sub metering", xlab = "")
lines(DateTime, plot3data$Sub_metering_2, col = "red")
lines(DateTime, plot3data$Sub_metering_3, col = "blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1)
dev.off()