#last plot:

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

png(file="graph4.png")

par(mfrow = c(2, 2))

##(1st paste) upperleft

with(z, plot(Global_active_power ~ timestamp, type = "l", ylab = "Global Active Power", xlab = ""))

##(2nd paste) upperright

with(z, plot(Voltage ~ timestamp, type = "l", ylab = "Voltage", xlab = "datetime"))

##3rd paste

with(g3, plot(energy ~ timestamp, type = "n", ylab = "Energy sub metering", xlab ="", col=as.factor(g3$subtype)))
with(subset(g3, subtype == "sub2"), lines(timestamp, energy, col = "red"))
with(subset(g3, subtype == "sub1"), lines(timestamp, energy, col = "black"))
with(subset(g3, subtype == "sub3"), lines(timestamp, energy, col = "blue"))
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##(4th paste) lower right:

with(z, plot(Global_reactive_power ~ timestamp, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

dev.off()