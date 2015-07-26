# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?

# load the required libraries and sources
library(ggplot2)
source('./prepareData.R')

# prepare data
print("Preparing data...")
data <- prepareData()

# Since we want to plot total emissions only for Baltimore City, Maryland (fips == "24510") for 1999 to 2008, 
# get the subsets by sourceType and Yes.
dataForBaltimore <- subset(data, data$fips == '24510')
dataForBaltimoreFor1999 <- subset(dataForBaltimore, dataForBaltimore$year == '1999')
dataForBaltimoreFor2008 <- subset(dataForBaltimore, dataForBaltimore$year == '2008')

dataForBaltimoreFor1999BySourceType <- tapply(dataForBaltimoreFor1999$Emissions, dataForBaltimoreFor1999$type, sum)
dataForBaltimoreFor2008BySourceType <- tapply(dataForBaltimoreFor2008$Emissions, dataForBaltimoreFor2008$type, sum)

dataForBaltimoreFor1999And2008BySourceType <- rbind(dataForBaltimoreFor1999BySourceType, dataForBaltimoreFor2008BySourceType)

rownames(dataForBaltimoreFor1999And2008BySourceType) <- c('1999', '2008')

dataForPlot <- as.data.frame(t(dataForBaltimoreFor1999And2008BySourceType))
dataForPlot$SourceType <- as.character(rownames(dataForPlot))

# Plot the data as required
print("Plotting data...")

# Plot on the PNG file device
png("plot3.png", width = 480, height = 480)

# Ensure the correct layout
par(mfrow = c(1,1))

gp <- ggplot(dataForPlot, aes(x = SourceType, y = Emissions)) + 
  labs(title = 'Motor Vehicle-related PM2.5 emissions in Baltimore', x = "Source Type", y = 'PM2.5 Emissions (Tons)') +
  geom_segment(aes(x = SourceType, y = dataForPlot$"1999", xend = SourceType, yend = dataForPlot$"2008"), size = 1) +
  geom_point(aes(y = dataForPlot$"1999", color = "1999"), size = 4) +
  geom_point(aes(y = dataForPlot$"2008", color = "2008"), size = 4) +
  scale_color_discrete(name = "Year") +
  theme(legend.position = "top")

print(gp)

dev.off()

print("plot3.png is generated!")
