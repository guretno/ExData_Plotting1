
# -- prepare the raw data

# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# download the file & unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "./data/exdata-data-household_power_consumption.zip")
unzip("./data/exdata-data-household_power_consumption.zip", exdir = "./data/household_power_consumption")

textdata <- file("./data/household_power_consumption/household_power_consumption.txt", "r");

# read in the data from the dates 2007-02-01 and 2007-02-02. In this dataset, missing values are coded as ?.
household_data <- read.table(text = grep("^[1,2]/2/2007", readLines(textdata), value = TRUE), sep = ";", skip = 0, na.strings = "?", stringsAsFactors = FALSE)

# rename the columns
names(household_data) <- c("date", "time", "global_active_power", "global_reactive_power", "voltage",
                  "global_intensity", "sub_metering_1", "sub_metering_2", 
                  "sub_metering_3")

# add a new date-time formated column
household_data$new_time <- as.POSIXct(paste(household_data$date, household_data$time), format = "%d/%m/%Y %T")

# plot 1 - histogram
par(mfrow = c(1, 1))
hist(household_data$global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red",
     freq = TRUE)

# copy plot to png file
dev.copy(png, file = "./data/plot1.png")

# close connection to png device
dev.off()