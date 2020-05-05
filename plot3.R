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

##2. Plot 3
png(file="plot3.png", width = 480, height = 480)
par(mar = c(4,4,1,2))
with(hpcd, plot(Time, Sub_metering_1, 
                type = "l", 
                xlab = "", 
                ylab = "Energy sub metering"))
with(hpcd, points(Time, Sub_metering_2, type = "l", col = "red"))
with(hpcd, points(Time, Sub_metering_3, type = "l", col = "blue"))
with(hpcd, legend("topright", 
                  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                  lwd = c(1,1,1),
                  cex = 0.9,
                  col = c("black", "red", "blue")))
dev.off()