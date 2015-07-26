# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# load the required libraries and sources
source('./prepareData.R')

# prepare data
print("Preparing data...")
data <- prepareData()
code <- readRDS('Source_Classification_Code.rds')

# Since we want to plot only motor vehicle sources-related data do a subset.
motorVehicleSCC <- code[grep("vehicle", code$SCC.Level.Two, ignore.case=TRUE), 'SCC']   
dataForMotorVehicle <- data[data$SCC %in% motorVehicleSCC,]

# We also want to filter just for Baltimore city
dataForMotorVehicleForBaltimore <- dataForMotorVehicle[dataForMotorVehicle$fips == '24510',]

# Calculate the yearly sums
totalEmissions <- tapply(dataForMotorVehicleForBaltimore$Emissions, dataForMotorVehicleForBaltimore$year, sum)
totalEmissionsInKiloTonnes <- totalEmissions/10^3

# Plot the data as required
print("Plotting data...")

# Plot on the PNG file device
png("plot5.png", width = 480, height = 480)

# Ensure the correct layout
par(mfrow = c(1,1))

barplot(totalEmissionsInKiloTonnes, main = 'Motor Vehicle-related PM2.5 emissions in Baltimore, MD', col = 'grey', xlab = 'Year', ylab = 'PM2.5 Emissions (Kilo Tons)')

dev.off()

print("plot5.png is generated!")
