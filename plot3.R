#plot3 --> line plots of Sub metering data sets over 
#               2-day period (2017-02-01/2017-02-02)

#clear workspace and set working directory
rm(list=(ls()))
#assumes data source "household_power_consumption.txt" in working directory
setwd("C:/Users/Phil/gitreps/ExData_Plotting1")
library(dplyr)

#load data, convert to tbl
consumption<-read.table("household_power_consumption.txt", sep=";",header=TRUE, 
                        stringsAsFactors = FALSE)
consum<-tbl_df(consumption)
rm(consumption)
names(consum)

#select subset of data for 2 days of interest
cs<-filter(consum, Date %in% c("1/2/2007", "2/2/2007"))
rm(consum)
#paste date and time information together
# format is "%d/%m/%Y %H:%M:%S"
cs$datetime<-paste(cs$Date, "",cs$Time)
#convert to POSIXlt format
cs$datetime<-strptime(cs$datetime, format="%d/%m/%Y %H:%M:%S")

#convert plot columns from character to numeric
cs$Sub_metering_1<-as.numeric(cs$Sub_metering_1)
cs$Sub_metering_2<-as.numeric(cs$Sub_metering_2)
cs$Sub_metering_3<-as.numeric(cs$Sub_metering_3)
#check for non-numeric entries in plot data (returns FALSE)
any(is.na(cs$Sub_metering_1))
any(is.na(cs$Sub_metering_2))
any(is.na(cs$Sub_metering_3))

#plot to PNG
png(filename = "plot3.png", width = 480, height = 480)
#initialize with data set with highest value for correct axis scale
with(cs, plot(datetime, Sub_metering_1, type="n", xlab="",
              ylab="Energy sub metering"))
with(cs, lines(datetime, Sub_metering_1, col="black"))
with(cs, lines(datetime, Sub_metering_2, col="red"))
with(cs, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1),  col=c("black", "red","blue"))
dev.off()
