library(tidyverse)

# script for downloading and unzipping file in a separate script

# read the data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# view structure of data
str(NEI)

# Question 1: Have total emissions from PM2.5 decreased in the United States
# from 1999 to 2008? Using the base plotting system, make a plot showing the
# total PM2.5 emission from all sources for each of the years 1999, 2002, 2005,
# and 2008.

# summarize total emission for each year
annual_pm2.5 <- NEI %>%
                group_by(year) %>%
                summarise(total_emission = sum(Emissions))

# make plot
png("plot1.png")
plot(annual_pm2.5$year, annual_pm2.5$total_emission/1000, type = "l",
     xaxt = "n",
     xlab = "year",
     ylab = expression("Total Tons of PM"[2.5]*" Emissions"),
     main = expression("Total Tons of PM"[2.5]*" Emissions in the United States"))

# change values at x-axis so they show the years we have data for
years <- unique(NEI$year)     
axis(1, at = years)
dev.off()