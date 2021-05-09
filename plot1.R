library("data.table")

setwd("C:/Users/SUNEEKSHA/Desktop/EDAprojectweek1")

#Reads the specific data from file 
pwrdeetee <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)
# Histogram is prevented from printing
pwrdeetee[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Changeing date column
pwrdeetee[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
pwrdeetee <- pwrdeetee[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(pwrdeetee[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
