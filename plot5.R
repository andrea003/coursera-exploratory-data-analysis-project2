# script for downloading and unzipping file in a separate script

# read the data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Question 5: How have emissions from motor vehicle sources changed from
# 1999–2008 in Baltimore City?

SCC_vehicle <- SCC[grep("*Mobile.*Vehicles", SCC$EI.Sector), ]
SCC_vehicle_list <- unique(SCC_vehicle$SCC)

NEI_vehicle <- subset(NEI, SCC %in% SCC_vehicle_list)

# filter for Baltimore
NEI_vehicle_baltimore <- NEI_vehicle %>% 
                             filter(fips == "24510") %>% 
                             group_by(year) %>% 
                             summarise(total_emissions = sum(Emissions))

# make plot
png("plot5.png")
ggplot(NEI_vehicle_baltimore, aes(x = factor(year), y = total_emissions)) +
    geom_bar(stat = "identity") +
    labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore"),
         x = "year",
         y = expression("Total Tons PM"[2.5]*" Emissions"))

dev.off()