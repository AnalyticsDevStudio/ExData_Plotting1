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

# get the Global_active_powe data
gap <- data$Global_active_power

# open PNG device
png(filename = "Plot2.png",width = 480, height = 480, units = "px")

# generate the plot
plot(time, gap, type = "l", xlab="", ylab="Global Active Power (kilowatts)")

# close PNG device
dev.off()
