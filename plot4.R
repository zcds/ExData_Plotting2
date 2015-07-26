# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# load the required libraries and sources
source('./prepareData.R')

# prepare data
print("Preparing data...")
data <- prepareData()
code <- readRDS('Source_Classification_Code.rds')

# Since we want to plot only coal combustion-related data do a subset.
coalCombustionSCC <- code[grepl("comb", code$SCC.Level.One, ignore.case=TRUE) & grepl("coal", code$SCC.Level.Four, ignore.case=TRUE), 'SCC']   
dataForCoalCombustion <- data[data$SCC %in% coalCombustionSCC,]

# Calculate the yearly sums
totalEmissions <- tapply(dataForCoalCombustion$Emissions, dataForCoalCombustion$year, sum)
totalEmissionsInMegaTonnes <- totalEmissions/10^6

# Plot the data as required
print("Plotting data...")

# Plot on the PNG file device
png("plot4.png", width = 480, height = 480)

# Ensure the correct layout
par(mfrow = c(1,1))

barplot(totalEmissionsInMegaTonnes, main = 'Coal Combustion-related PM2.5 emissions in the United States', col = 'grey', xlab = 'Year', ylab = 'PM2.5 Emissions (Mega Tons)')

dev.off()

print("plot4.png is generated!")
