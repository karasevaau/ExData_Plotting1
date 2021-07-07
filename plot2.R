library(data.table)

# Download and unzip file

#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(url,destfile = "data.zip")
#unzip(zipfile = "data.zip")

dataraw <- fread(file.path(getwd(), "household_power_consumption.txt"))

#get tidy data

dataraw$Date <- as.Date (dataraw$Date, "%d/%m/%Y")
data <- subset(dataraw, Date == '2007-02-01' | Date == '2007-02-02')
data$timestamp <- paste(data$Date, data$Time)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Time <- as.POSIXct(data$timestamp,"%Y-%m-%d %H:%M:%S", tz = "")

png(filename = 'Plot2.png',width = 480, height = 480, units = "px", 
    pointsize = 12,
    bg = "white", res = 110)

par(mar = c(2.5,2.5,2,1))

#plot2
plot(data$Global_active_power ~ data$Time , type = 'l', 
    xlab = '', 
    ylab = 'Global Active power (kilowatts)',
    cex.axis = 0.7,
    cex.lab = 0.7,
    tcl = -0.3,
    mgp = c(1.5,0.5,0)
    )

dev.off() 

