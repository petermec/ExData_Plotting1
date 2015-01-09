# download file & assign to 'tijdelijk'
tijdelijk <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tijdelijk)

# unzip file 'tijdelijk' and assign to 'file'
file <- unzip(tijdelijk)
unlink(tijdelijk)

# read file 'file' & take subset with only data from 1/2/2007 & 2/2/2007
fulldata <- read.table(file, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subsetdata <- fulldata[fulldata$Date %in% c("1/2/2007","2/2/2007") ,]

# convert DateTime to timestamp, having this format: 2007-02-01 00:00:00
subsetdata$DateTime <- as.POSIXct(paste(subsetdata$Date, subsetdata$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# set dimensions for png
png("plot2.png", width=480, height=480)

# plot data with needed annotations
plot(subsetdata$DateTime, subsetdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", main="")
dev.off()

