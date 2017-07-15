test <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

test$Date <- as.Date(test$Date, "%d/%m/%Y")

test <- subset(test,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

test <- test[complete.cases(test),]

dateTime <- paste(test$Date, test$Time)

dateTime <- setNames(dateTime, "DateTime")

test <- test[ ,!(names(test) %in% c("Date","Time"))]

test <- cbind(dateTime, test)

test$dateTime <- as.POSIXct(dateTime)

# Creating Plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(test, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
