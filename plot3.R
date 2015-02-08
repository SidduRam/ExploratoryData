# File: Plot2 - Global Active Power plotting (PNG format)
# Input : Electric power consumption from  UC Irvine Machine Learning Repository
# Output: Draw a PNG format image for 2007/2/1 - 2007/2/2 data only

# Set the working directory
# Make sure both this Plot1.R file and Household data files in the same folder
setwd("Data-Science/Working/Exploratory-Data")

#Download the 'Electric power consumption' data set 
desturl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- file.path(getwd(), "household_power_consumption.zip")
download.file(desturl, file)

# Set the required referenec library
require(data.table)

# Read data set after unzipping the data file
powerConsumption <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"),
                               header=T, sep=";")

# Subset the power consumption data - Only Feb. 1 and 2, 2007 
powerCon2007 <- powerConsumption[as.character(powerConsumption$Date) %in% c("1/2/2007", "2/2/2007"),]

# combine both Date and Time variables & Value
powerCon2007$dateTime = paste(powerCon2007$Date, powerCon2007$Time)

# Convert to Date Time class
powerCon2007$dateTime <- strptime(powerCon2007$dateTime, "%d/%m/%Y %H:%M:%S")
attach(powerCon2007)

# Creatr PNG image
png("plot3.png", width=480, height=480, units="px")

#  Plot Energy sub metering - Thursday to Fridat
#  Set the legend w/ color
plot(dateTime, as.numeric(as.character(Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40))
lines(dateTime, as.numeric(as.character(Sub_metering_2)), col="red")
lines(dateTime, as.numeric(as.character(Sub_metering_3)), col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))


# Shut down the graphic device 
dev.off()
