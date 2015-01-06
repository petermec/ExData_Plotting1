# download file if not already downloaded and assign to 'tijdelijk'
if(!file.exists("exdata-data-household_power_consumption.zip")) {
      tijdelijk <- tempfile()
      download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tijdelijk)
# unzip file 'tijdelijk' and assign to 'file'
      file <- unzip(tijdelijk)
      unlink(tijdelijk)
}

# read file 'file' & take subset with only data from 1/2/2007 & 2/2/2007
fulldata <- read.table(file, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subsetdata <- fulldata[fulldata$Date %in% c("1/2/2007","2/2/2007") ,]

# take subset of data needed (Global_active_power) for histogram & convert to numeric, assign to 'gapower'
gapower <- as.numeric(subsetdata$Global_active_power)
# set dimensions for png
png("plot1.png", width=480, height=480)
# draw histogram with needed annotations
hist(gapower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

