#plot2 --> line plot of Global Active Power over 
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

#convert plot column from character to numeric
cs$Global_active_power<-as.numeric(cs$Global_active_power)
#check for non-numeric entries in plot data (returns FALSE)
any(is.na(cs$Global_active_power))

#plot to PNG
png(filename = "plot2.png", width = 480, height = 480)
with(cs, plot(datetime, Global_active_power, type="n", xlab="",
               ylab="Global Active Power (kilowatts)"))
with(cs, lines(datetime, Global_active_power))
dev.off()
