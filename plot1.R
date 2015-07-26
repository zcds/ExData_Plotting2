# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

# load the required libraries and sources
source('./prepareData.R')

# prepare data
print("Preparing data...")
data <- prepareData()

# Since we want to plot total emissions across the years, we do a sum for each year.
totalEmissions <- tapply(data$Emissions, data$year, sum)
totalEmissionsInMegaTonnes <- totalEmissions/10^6

# Plot the data as required
print("Plotting data...")

# Plot on the PNG file device
png("plot1.png", width = 480, height = 480)

# Ensure the correct layout
par(mfrow = c(1,1))

barplot(totalEmissionsInMegaTonnes, main = 'PM2.5 emissions in the United States from 1999 to 2008', col = 'grey', xlab = 'Year', ylab = 'PM2.5 Emissions (Mega Tons)')

dev.off()

print("plot1.png is generated!")
