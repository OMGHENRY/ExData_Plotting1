
test <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

test$Date <- as.Date(test$Date, "%d/%m/%Y")

test <- subset(test,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

test <- test[complete.cases(test),]

dateTime <- paste(test$Date, test$Time)

dateTime <- setNames(dateTime, "DateTime")

test <- test[ ,!(names(test) %in% c("Date","Time"))]

test <- cbind(dateTime, test)

test$dateTime <- as.POSIXct(dateTime)

# Creating Plot 2

plot(test$Global_active_power~test$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
