###	Exploratory Data Analysis Week 1 Assignment
###	Uses �Individual household electric power consumption Data Set� from 
###	the UC Irvine Machine Learning Repository to contruct simple plots 
###	using R base plotting system in order to examine how household energy usage 
###	varies over a 2-day period in February, 2007. 


##  Create and set working directory
if (!file.exists("hw1")) {dir.create("hw1")}
setwd("./hw1")


##  Download zipped data file from course website
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "electric.zip")
dateDownloaded <- date()

# unzip("electric.zip", list=TRUE)	    # list contents of zip folder

##  Read in data for rows corresponding to dates 2007-Feb-01 and 2007-Feb-02
df <- read.csv2(unzip("electric.zip"), header=FALSE, dec = ".", 
                na.strings = "?", skip=66637, nrows=2880, stringsAsFactors = FALSE)

str(df)

##	Name variables in dataframe                           
names(df) <- c("date_ch", "time_ch", "active", "reactive", "voltage", "intensity", 
                "submeter1", "submeter2", "submeter3")

##  Create a datetime (POSIXlt) variable
df$datetime <- strptime(paste(df$date_ch, df$time_ch), format="%d/%m/%Y %H:%M:%S")

str(df)




###	Plot 4: Multiple plots showing Global active power, Voltage, Sub-metering & Global Reactive power
par(mfrow = c(2, 2))
with(df, {
	# 1: Global Active power
	plot(datetime, active, type="l", xlab = "", ylab="Global Active Power")
	# 2: Voltage
	plot(datetime, voltage, type="l", xlab = "datetime", ylab="Voltage")
	# 3: Three sub-meters
	plot(datetime, submeter1, type="l", xlab = "", ylab="Energy sub metering")
	lines(datetime, submeter2, col="red")
	lines(datetime, submeter3, col="blue")
	leg.text <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
	leg.col <- c("black", "red", "blue")
	legend("topright", lty=1, col=leg.col, legend=leg.text, bty="n")
	# 4: Global Reactive power
	plot(datetime, reactive, type="l", xlab = "datetime", ylab="Global_reactive_power")
})

# copy plot to png device
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

