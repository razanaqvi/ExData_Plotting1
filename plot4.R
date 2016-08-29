library(readr)
#Check if the zip file exists in the working directory
if(!file.exists("exdata_data_household_power_consumption.zip"))
{
        #Download the zip file
        download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                      destfile =  "./exdata_data_household_power_consumption.zip")
}

#Check if the file has been unzipped before in the working directory
if(!file.exists("exdata_data_household_power_consumption"))
{
        #Unzip the file
        unzip("exdata_data_household_power_consumption.zip", exdir = "./exdata_data_household_power_consumption")
}

#Rows 66638-69517 contain the data corresponding to dates 2007-02-01 to 2007-02-02
#Read from the beginning to row 69516
power <- read_delim("./exdata_data_household_power_consumption/household_power_consumption.txt", delim = ";", n_max = 69516, na = c("?")
                    , col_types = cols(Date = col_character(), Time = col_character()))

#Subset to only 2/1/2007 and 2/2/2007 dates
power <- power[66638:69516,]

#Create a date time column by combining the Date and Time variable
power$time <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")

#Open the file for plotting
png(filename = "plot4.png")

#Set up a 2x2 plotting area by row
par(mfrow=c(2,2))
par(cex = 0.75)
#Draw the first plot
with(power, {
        time <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")
        plot(time, Global_active_power, type="l", ylab="Global Active Power", xlab="")
})

#Draw the second plot
with(power, {
        time <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")
        plot(time, Voltage, type="l", ylab="Voltage", xlab="datetime")
})

#Draw the third plot
with(power, plot(time, Sub_metering_1 , type = "n", ylab = "Energy sub metering", xlab =""))
points(power$time, power$Sub_metering_1, type = "l")
points(power$time, power$Sub_metering_2, type = "l", col = "red")
points(power$time, power$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

#Draw the fourth plot
with(power, {
        time <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")
        plot(time, Global_reactive_power, type="l", xlab="datetime")
})

dev.off()
