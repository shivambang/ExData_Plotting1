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

png("plot4.png", 480, 480)
#Create a 2x2 canvas
par(mfrow=c(2,2))

#Top Left Plot
plot(hec$Datetime, hec$Global_active_power, xlab="", ylab = "Global Active Power", pch="")
lines(hec$Datetime, hec$Global_active_power)

#Top Right Plot
with(hec, plot(Datetime, Voltage, pch=""))
lines(hec$Datetime, hec$Voltage)

#Bottom Left Plot
plot(hec$Datetime, hec$Sub_metering_1, xlab="", ylab = "Energy sub metering", pch="")
lines(hec$Datetime, hec$Sub_metering_1)
lines(hec$Datetime, hec$Sub_metering_2, col="red")
lines(hec$Datetime, hec$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, bty = "n")

#Bottom Right Plot
with(hec, plot(Datetime, Global_reactive_power, pch=""))
lines(hec$Datetime, hec$Global_reactive_power)
dev.off()
