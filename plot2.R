library(data.table)

#Download file if does not exist
if(!file.exists("household_power_consumption.txt")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_electricity_consumption.zip")
    unzip("household_electricity_consumption.zip")    
}

#Read into data.table and subset by date
hec = fread("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")
hec = subset(hec, hec$Date == "1/2/2007" | hec$Date == "2/2/2007")

#Create new POSIXct Datetime column
hec[, Datetime := as.POSIXct(paste(hec$Date, hec$Time), format = "%d/%m/%Y %H:%M:%S")]
str(hec)

#Plot2 created using lines to form continuous plot
png("plot2.png", 480, 480)
plot(hec$Datetime, hec$Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)", pch="")
lines(hec$Datetime, hec$Global_active_power)
dev.off()
