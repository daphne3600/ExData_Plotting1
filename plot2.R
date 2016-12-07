library(lubridate); library(plyr); library(dplyr)
##Read into R, only need top  ~100,000 rows since data is by date from Dec 2006
dataset <- read.delim("./dataset/household_power_consumption.txt", nrows = 100000, sep = ";", na.strings = "?", stringsAsFactors = FALSE) 
unlink(temp)

##Format dates to Date class
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

##Extract relevant data to plot
plot2data <- dataset[dataset$Date >= "2007-02-01" & dataset$Date <= "2007-02-02",1:3]

##Combine Date and Time and convert to POSIXlt format
x <- paste(plot2data$Date, plot2data$Time)
DateTime <- strptime(x, format = "%Y-%m-%d %H:%M:%S")

##Plot to file
png(file = "plot2.png", width = 480, height = 480)
plot(DateTime,plot2data$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
dev.off()