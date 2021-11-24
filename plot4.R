# script for downloading and unzipping file in a separate script

# read the data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 4: Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999–2008?

# in column 'EI.Sector' find all that has expression "Fuel Comb", followed by
# any number of characters, followed by "Coal"
SCC_coal <- SCC[grep("Fuel Comb.*Coal", SCC$EI.Sector), ]
SCC_coal_list <- unique(SCC_coal$SCC)

# subset NEI dataset to only include coal-combustion related sources
NEI_coal <- subset(NEI, SCC %in% scc_coal_list)

# group dataset by year, calculate total emission each source
NEI_coal1 <- NEI_coal %>%
                 group_by(year) %>% 
                 summarise(total_emissions = sum(Emissions)/1000)


#make plot
png("plot4.png")
plot(NEI_coal1$year, NEI_coal1$total_emissions, type = "l", lwd = 2, 
     xaxt = "n",
     xlab = "year",
     ylab = expression("Total Tons of PM"[2.5]*" Emissions"),
     main = expression("Total Tons of PM"[2.5]*" Emissions from Coal Combustion-related Sources"))

x_points <- unique(NEI_coal1$year)
axis(1, at = x_points)

dev.off()
