prepareData <- function() {
  # Download the data if not already download. 
  if (!file.exists('./summarySCC_PM25.rds') && !file.exists('./Source_Classification_Code.rds')) {
    print("  Downloading data...")
    download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip', destfile = 'EPA_NEI_PM25.zip', method = 'curl')
    
    # Since the data is in a zipfile, unzip it
    unzip('EPA_NEI_PM25.zip')
  }
  
  # Load the data
  print("  Reading data into memory...")
  data <- readRDS(file = 'summarySCC_PM25.rds')
  
  # Transform the data to our desire
  print("  Transforming data...")
  data$fips <- as.factor(data$fips)
  data$SCC <- as.factor(data$SCC)
  data$Pollutant <- as.factor(data$Pollutant)
  data$type <- as.factor(data$type)
  data$year <- as.factor(data$year)
  
  data
}