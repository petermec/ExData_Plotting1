# download file & assign to 'tijdelijk'
tijdelijk <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tijdelijk)

# unzip file 'tijdelijk' and assign to 'file'
file <- unzip(tijdelijk)
unlink(tijdelijk)

# read file 'file' & take subset with only data from 1/2/2007 & 2/2/2007
fulldata <- read.table(file, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subsetdata <- fulldata[fulldata$Date %in% c("1/2/2007","2/2/2007") ,]

# convert to numeric
subsetdata$Sub_metering_1 <- as.numeric(as.character(subsetdata$Sub_metering_1))
subsetdata$Sub_metering_2 <- as.numeric(as.character(subsetdata$Sub_metering_2))
subsetdata$Sub_metering_3 <- as.numeric(as.character(subsetdata$Sub_metering_3))

# convert DateTime to timestamp, having this format: 2007-02-01 00:00:00
subsetdata$DateTime <- as.POSIXct(paste(subsetdata$Date, subsetdata$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# open png
png(filename='plot3.png')

# plot with annotations
plot(subsetdata$DateTime,subsetdata$Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
lines(subsetdata$DateTime,subsetdata$Sub_metering_2, col='red')
lines(subsetdata$DateTime,subsetdata$Sub_metering_3, col='blue')

# add legend
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),col=c('black', 'red', 'blue'))

dev.off()
