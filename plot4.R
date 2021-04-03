library("data.table")

setwd("C:/Users/SUNEEKSHA/Desktop/EDAprojectweek1")

#Reads data frm file 
pwrdeetee <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Sci no
pwrdeetee[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date 
pwrdeetee[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates 
pwrdeetee <- pwrdeetee[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(pwrdeetee[, dateTime], pwrdeetee[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(pwrdeetee[, dateTime],pwrdeetee[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(pwrdeetee[, dateTime], pwrdeetee[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(pwrdeetee[, dateTime], pwrdeetee[, Sub_metering_2], col="red")
lines(pwrdeetee[, dateTime], pwrdeetee[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(pwrdeetee[, dateTime], pwrdeetee[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()