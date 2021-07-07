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

png(filename = 'Plot4.png',width = 480, height = 480, units = "px", 
    pointsize = 12,
    bg = "white", res = 110)

par(mar = c(2.5,2.5,2,1))

#plot4
par(mfrow=c(2,2))
plot(data$Global_active_power ~ data$Time , type = 'l', 
     xlab = '', 
     ylab = 'Global Active power (kilowatts)',
     cex.axis = 0.6,
     cex.lab = 0.6,
     tcl = -0.3,
     mgp = c(1.4,0.4,0))
plot(data$Voltage ~ data$Time, 
     xlab = 'datetime', 
     ylab = 'Voltage',
     type = 'l',
     cex.axis = 0.6,
     cex.lab = 0.6,
     tcl = -0.3,
     mgp = c(1.4,0.4,0))
plot(data$Sub_metering_1 ~ data$Time, 
     type = 'n', 
     xlab = '', 
     ylab = 'Energy sub metering',
     cex.axis = 0.6,
     cex.lab = 0.6,
     tcl = -0.3,
     mgp = c(1.4,0.4,0))
lines(data$Time,data$Sub_metering_1)
lines(data$Time,data$Sub_metering_2, col = 'red')
lines(data$Time,data$Sub_metering_3, col = 'blue')

legend("topright", 
       c("sub_metering_1", "sub_metering_2", "sub_metering_3"), 
       col = c("black", "red","blue"),
       lty = c(1, 1, 1), 
       x.intersp = 0.6,
       y.intersp = 0.6,
       cex = 0.7,
       seg.len = 0.7 ,
       bty = 'n',
       text.width = strwidth("sub_metering")
)
plot(data$Global_reactive_power ~ data$Time, xlab = 'datetime', ylab = 'Global_reactive_power', 
     type = 'l', 
     cex.axis = 0.6,
     cex.lab = 0.6,
     tcl = -0.3,
     mgp = c(1.4,0.4,0))



dev.off() 
