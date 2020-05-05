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

##2. Plot 2
png(file="plot2.png", width = 480, height = 480)
par(mar = c(4,4,1,2))
with(hpcd, plot(Time, Global_active_power, 
                type = "l", 
                xlab = "", 
                ylab = "Global Active Power (kilowatts)"))
dev.off()