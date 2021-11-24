# script for downloading and unzipping file in a separate script

# read the data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 5: Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County, California
# (\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen
# greater changes over time in motor vehicle emissions?

SCC_vehicle <- SCC[grep("*Mobile.*Vehicles", SCC$EI.Sector), ]
SCC_vehicle_list <- unique(SCC_vehicle$SCC)

NEI_vehicle <- subset(NEI, SCC %in% SCC_vehicle_list)

# subset data for Baltimore and add city name column
NEI_Baltimore <- NEI_vehicle[NEI_vehicle$fips == "24510", ]
NEI_Baltimore$city <- "Baltimore City"

# subset data for Los Angeles and add city name column
NEI_Los_Angeles <- NEI_vehicle[NEI_vehicle$fips == "06037", ]
NEI_Los_Angeles$city <- "Los Angeles County"

# combine to one dataset
NEI_vehicle_2cities <- rbind(NEI_Baltimore, NEI_Los_Angeles)

# group by year and city, sum Emissions
NEI_vehicle_2cities_sum <- NEI_vehicle_2cities %>% 
                            group_by(year, city) %>% 
                            summarise(total_emissions = sum(Emissions))

# make plot
png("plot6.png")
ggplot(NEI_vehicle_2cities_sum, aes(x = factor(year), y = total_emissions)) +
        geom_bar(stat = "identity", aes(fill = year)) +
        facet_grid(~city) +
        labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA"),
             x = "year",
             y = expression("Total Tons PM"[2.5]*" Emissions"))
dev.off()