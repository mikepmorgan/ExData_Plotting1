#first graph 

data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", stringsAsFactors = FALSE)
library(dplyr)
library(tidyr)
subs <- data[which(data$Date == "2/2/2007" | data$Date == "1/2/2007"),]
z <- mutate(subs, timestamp = paste(Date, Time))
strptime(z$timestamp, format = "%d/%m/%Y %H:%M:%S")
subs2 <- strptime(z$timestamp, format = "%d/%m/%Y %H:%M:%S")
subs2 <- as.data.frame(subs2)
z <- cbind(z, subs2)
z <- subset(z, select = -c(timestamp))
names(z)[names(z)=="subs2"] <- "timestamp"
names(z)[names(z)=="Sub_metering_1"] = "sub1"
names(z)[names(z)=="Sub_metering_2"] = "sub2"
names(z)[names(z)=="Sub_metering_3"] = "sub3"
subs2 <- mutate(subs, Date2 = as.Date(Date, "%d/%m/%Y"))
graph3 <- select(z, sub1:timestamp)
g3 <- gather(graph3, subtype, energy, -timestamp)

png(file="graph1.png")

hist(subs$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = paste("Global Active Power"))

dev.off()