# script for downloading and unzipping file in a separate script

# read the data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)

# Question 3: Of the four types of sources indicated by the
# \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use
# the ggplot2 plotting system to make a plot answer this question.

# filter data for Baltimore, group by type of source and year, calculate total
# emissions
baltimore_sources <- NEI %>% 
                      filter(fips == "24510") %>% 
                      group_by(type, year) %>% 
                      summarise(total_emission = sum(Emissions))
#view data
str(baltimore_sources)

# change type and year to factor variables 
baltimore_sources$type <- factor(baltimore_sources$type)
baltimore_sources$year <- factor(baltimore_sources$year)

# make bar plots, faceted by type of course
png("plot3.png")
ggplot(baltimore_sources, aes(x = year, y = total_emission, fill = type)) +
        geom_bar(stat = "identity") + 
        facet_grid(~type) +
        labs(title = expression("Total PM"[2.5]*" Emissions by Source Type"),
             y = expression("Total PM"[2.5]*" Emissions"))

dev.off()