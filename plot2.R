###	Exploratory Data Analysis Week 1 Assignment
##	Uses “Individual household electric power consumption Data Set” from 
##	the UC Irvine Machine Learning Repository to contruct simple plots 
##	using R base plotting system in order to examine how household energy usage 
##	varies over a 2-day period in February, 2007. 


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

# str(df)

##	Name variables                           
names(df) <- c("date_ch", "time_ch", "active", "reactive", "voltage", "intensity", 
                "submeter1", "submeter2", "submeter3")

##  Create a datetime (POSIXlt) variable
df$datetime <- strptime(paste(df$date_ch, df$time_ch), format="%d/%m/%Y %H:%M:%S")

# str(df)





###	Plot 2: Time-series plot of Global Active Power over 2 days

with(df, plot(datetime, active, type="l", xlab = "", ylab="Global Active Power (kilowatts)"))

# copy plot to png device
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
