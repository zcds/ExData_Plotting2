# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

# load the required libraries and sources
source('./prepareData.R')

# prepare data
print("Preparing data...")
data <- prepareData()

# Since we want to plot total emissions only for Baltimore City, Maryland (fips == "24510"), get the subset
dataForBaltimore <- subset(data, data$fips == '24510')
totalEmissionsInBaltimore <- tapply(dataForBaltimore$Emissions, dataForBaltimore$year, sum)
totalEmissionsInKiloTonnes <- totalEmissionsInBaltimore/10^3

# Plot the data as required
print("Plotting data...")

# Plot on the PNG file device
png("plot2.png", width = 480, height = 480)

# Ensure the correct layout
par(mfrow = c(1,1))

barplot(totalEmissionsInKiloTonnes, main = 'PM2.5 emissions in Baltimore, MD from 1999 to 2008', col = 'grey', xlab = 'Year', ylab = 'PM2.5 Emissions (Kilo Tons)')

dev.off()

print("plot2.png is generated!")
