
test <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

test$Date <- as.Date(test$Date, "%d/%m/%Y")

test <- subset(test,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

test <- test[complete.cases(test),]

dateTime <- paste(test$Date, test$Time)

dateTime <- setNames(dateTime, "DateTime")

test <- test[ ,!(names(test) %in% c("Date","Time"))]

test <- cbind(dateTime, test)

test$dateTime <- as.POSIXct(dateTime)


# Creating Plot 3

with(test, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
