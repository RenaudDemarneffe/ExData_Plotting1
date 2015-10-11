###################################################################
##
## Course: Exploratory Data Analysis
## Project: Project 1 - Making Plots - Plot 2
## Project instructions: see README.md
##
## Author: DEMARNEFFE Renaud
##
## This script will compute the plot2 asked in the instructions
## file.
##
###################################################################
##
## Logic of this script:
##   1. Download and unzip the input data.
##   2. Read the data, convert time and date columns from text to
##      time/date and select data from the dates 2007-02-01 and 2007-02-02.
##      Remarks: During file read, missing values (?) are replaced with NA.
##               For information, this script compute and print the  
##               size of the input data set. The memory of my computer
##               is big enough to read the full data set.
##  3. Build the graphic Global Active Power vs day-time.
##
###################################################################



## 1. Download and unzip the input data.

# This section downloads the source data "Individual household 
# electric power consumption Data Set" directly from the
# "UC Irvine Machine Learning Repository" if they aren't 
# present inside the working directory.
# After, unzip data if not already done.
if (!file.exists("Electric power consumption.zip"))
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                "Electric power consumption.zip")

if (!file.exists("household_power_consumption.txt"))
  unzip("Electric power consumption.zip")



##   2. Read the data, convert time and date columns from text to
##      time/date and select data from the dates 2007-02-01 and 2007-02-02.
##      Remarks: During file read, missing values (?) are replaced with NA.
##               For information, this script compute and print the  
##               size of the input data set. The memory of my computer
##               is big enough to read the full data set.

# Read input file as a table.
hhpc <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = c("?"),
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Print the size of the object.
message(paste("The memory size allocated for the input data set is", 
              format(object.size(hhpc), units = "Mb")))

# Select data for dates 2007-02-01 and 2007-02-02.
hhpc$Date <- as.Date(hhpc$Date,"%d/%m/%Y")
hhpc <- hhpc[hhpc$Date == as.Date("01/02/2007","%d/%m/%Y") | hhpc$Date == as.Date("02/02/2007","%d/%m/%Y"),]

# Convert Date and Time columns (factors) to Date and Time class.
hhpc$DateTime <- strptime(paste(hhpc$Date, hhpc$Time), "%Y-%m-%d %H:%M:%S")



##  3. Build the graphic Global Active Power vs day-time.

# Load a png device.
png(file = "plot2.png", width=480, height=480)

# Change language to english.
oldLoc <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","English")

# Build the plot.
plot(hhpc$DateTime, hhpc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# REstore old language.
Sys.setlocale("LC_TIME", oldLoc)

# Close the device.
dev.off()
message("\"plot2.png\" file generated.")