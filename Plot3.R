# load the data from 1/2/2007 to 2/2/2007 without header
data <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
data3 <- data2[data2$Date == "1/2/2007" | data2$Date == "2/2/2007",]
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

# open PNG device
png(filename = "Plot3.png",width = 480, height = 480, units = "px")

# generate the plot
ylim = range(c(sm1,sm2,sm3))
plot(time, sm1, type = "l", xlab="", ylab="Energy Sub Metering", ylim = ylim, col = "gray")
lines(time, sm2, col = "red")
lines(time, sm3, col = "blue")
legend("topright", lty = 1, col = c("gray","red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# close PNG device
dev.off()
