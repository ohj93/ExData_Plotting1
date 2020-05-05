##0. Get data

workingdirectory <- getwd()
filedirectory <- "Exdata_Plotting1"

if (!file.exists("Exdata_Plotting1")) {
        dir.create("Exdata_Plotting1")
}

setwd(filedirectory)

fileUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"

download.file(fileUrl, destfile="household_power_consumption.zip", method="curl")
unzip("household_power_consumption.zip")
file.remove("household_power_consumption.zip")


##1. Load the data

hpc <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
hpcd <- subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")
rm(hpc)

hpcd$Time <- paste(hpcd$Date, hpcd$Time, sep=" ")
hpcd$Date <- as.Date(hpcd$Date, "%e/%m/%Y")
hpcd$Time <- strptime(hpcd$Time, "%e/%m/%Y %H:%M:%S")

##2. Plot 4
png(file="plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4,4,1,2))

with(hpcd, plot(Time, Global_active_power, 
                type = "l",
                cex.axis = 0.7,
                xlab = "", 
                ylab = "Global Active Power"))

with(hpcd, plot(Time, Voltage, type = "l", 
                cex.axis = 0.7,
                xlab = "datetime", 
                ylab = "Voltage"))

with(hpcd, plot(Time, Sub_metering_1, 
                type = "l", 
                cex.axis = 0.7,
                xlab = "", 
                ylab = "Energy sub metering"))
with(hpcd, points(Time, Sub_metering_2, type = "l", col = "red"))
with(hpcd, points(Time, Sub_metering_3, type = "l", col = "blue"))
with(hpcd, legend("topright", 
                  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                  bty = "n",
                  cex = 0.7,
                  lwd = c(1,1,1), 
                  col = c("black", "red", "blue")))

with(hpcd, plot(Time, Global_reactive_power, 
                type = "l", 
                cex.axis = 0.7,
                yaxp = c(0.0,0.5,5), 
                xlab = "datetime"))

dev.off()