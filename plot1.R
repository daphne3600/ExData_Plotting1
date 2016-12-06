##Get data from url and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, temp) 
unzip(temp, "household_power_consumption.txt")

##Read into R, only need top  ~100,000 rows
dataset <- read.delim("household_power_consumption.txt", nrows = 100000, sep = ";", na.strings = "?", stringsAsFactors = FALSE) 
unlink(temp)

##Format dates to Date class
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

##Extract relevant data to plot
plot1data <- dataset[dataset$Date >= "2007-02-01" & dataset$Date <= "2007-02-02",3]

##Plot to file
png(file = "plot1.png", width = 480, height = 480)
hist(plot1data, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()