# script for downloading and unzipping file in a separate script

# read the data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(SCC)
head(NEI)

# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to
# 2008? Use the base plotting system to make a plot answering this question.

# filter data for baltimore and find total emission for each year
baltimore <- NEI %>% 
                filter(fips == "24510") %>% 
                group_by(year) %>% 
                summarise(total_emission = sum(Emissions))


#make plot
png("plot2.png")
plot(baltimore$year, baltimore$total_emission/1000, type = "l",
     xaxt = "n",
     xlab = "Year",
     ylab = expression("Total Tons of PM"[2.5]*" Emissions"),
     main = expression("Total Tons of PM"[2.5]*" Emissions in Baltimore"))

x_points <- unique(baltimore$year)
axis(1, at = x_points)

dev.off()
