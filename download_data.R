
filename <- "Data for Peer Assessment.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"


# download data
if (!file.exists(filename)) {
    download.file(fileURL, filename, method = "curl")
}

# unzip file
if (!file.exists("Data for Peer Assessment")) {
    unzip(filename)
}


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
