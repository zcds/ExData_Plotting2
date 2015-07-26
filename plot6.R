# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

# load the required libraries and sources
library(ggplot2)
source('./prepareData.R')

# prepare data
print("Preparing data...")
data <- prepareData()
code <- readRDS('Source_Classification_Code.rds')

# Since we want to plot only motor vehicle sources-related data do a subset.
motorVehicleSCC <- code[grep("vehicle", code$SCC.Level.Two, ignore.case=TRUE), 'SCC']   
dataForMotorVehicle <- data[data$SCC %in% motorVehicleSCC,]

# We also want to filter just for Baltimore and Los Angeles
dataForMotorVehicleForBaltimore <- dataForMotorVehicle[dataForMotorVehicle$fips == '24510',]
dataForMotorVehicleForBaltimore$City <- c('Baltimore')
dataForMotorVehicleForLA <- dataForMotorVehicle[dataForMotorVehicle$fips == '06037',]
dataForMotorVehicleForLA$City <- c('Los Angeles')

# Combine the data for Baltimore and LA
dataForBaltimoreAndLA <- rbind(dataForMotorVehicleForBaltimore, dataForMotorVehicleForLA)

# Plot the data as required
print("Plotting data...")

# Plot on the PNG file device
png("plot6.png", width = 480, height = 480)

# Ensure the correct layout
par(mfrow = c(1,1))

gp <- ggplot(dataForBaltimoreAndLA, aes(x = factor(year), y = Emissions, fill = City)) +
  labs(title = 'Motor Vehicle-related PM2.5 emissions in Baltimore and LA', x = "Year", y = 'PM2.5 Emissions (Tons)') +
  geom_bar(aes(fill = year), stat = 'identity') +
  facet_grid(scales = 'free', space = 'free', . ~ City) +
  theme(legend.position = "top")

print(gp)

dev.off()

print("plot6.png is generated!")
