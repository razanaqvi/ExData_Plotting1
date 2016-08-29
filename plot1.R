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

#plot the histogram of Global_active_power, with appropriate x-axis label and red color
png(filename = "plot1.png")
hist(power$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()
