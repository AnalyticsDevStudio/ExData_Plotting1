# load the data from 1/2/2007 to 2/2/2007 without header
data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
# read the header from the raw data
cnames <- readLines("household_power_consumption.txt",1)
cnames <- strsplit(cnames, ";", fixed = TRUE)
# add the header on the set of data 
names(data) <- make.names(cnames[[1]])

# format the date/time data
d <- as.Date(data$Date, "%d/%m/%Y")
t <- data$Time
dt <- paste(d, t)
time <- strptime(dt, "%Y-%m-%d %H:%M:%S")

# get the data
sm1 <- data$Sub_metering_1
sm2 <- data$Sub_metering_2
sm3 <- data$Sub_metering_3
v <- data$Voltage
grp <- data$Global_reactive_power
gap <- data$Global_active_power

# open PNG device
png(filename = "Plot4.png",width = 480, height = 480, units = "px")

par(mfrow = c(2,2), mar = c(4,4,2,1))

# generate the plot
plot(time, gap, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
plot(time, v, type = "l", xlab="Date Time", ylab="Voltage")
ylim = range(c(gap,sm1,sm2,sm3))
plot(time, sm1, type = "l", xlab="", ylab="Energy Sub Metering", ylim = ylim, col = "gray")
lines(time, sm2, col = "red")
lines(time, sm3, col = "blue")
plot(time, grp, type = "l", xlab="Date Time", ylab="Global Reactive Power")

# close PNG device
dev.off()
