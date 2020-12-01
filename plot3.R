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


#Plot3 created using scatterplot and lines function to form continuous plot
png("plot3.png", 480, 480)
plot(hec$Datetime, hec$Sub_metering_1, xlab="", ylab = "Energy sub metering", pch="")
lines(hec$Datetime, hec$Sub_metering_1)
lines(hec$Datetime, hec$Sub_metering_2, col="red")
lines(hec$Datetime, hec$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1)
dev.off()
