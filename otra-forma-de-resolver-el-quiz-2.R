## Exploratory Data Analysis, Course Project 2, Question 1

## The two files are in our working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
options(scipen=999)

png(filename = 'plot1.png', width = 480, height = 480, units = 'px')

## 1. Have TOTAL emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission
## from all sources for each of the years 1999, 2002, 2005, and 2008.

TotEmi <- data.frame()
TotEmi <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
names(TotEmi) <- c("Year", "PM2.5 Emissions (in Tons)")
plot(TotEmi, pch=20, type="l", main="1. Total PM2.5 Emissions in the United States", lwd=2)

dev.off()

## Exploratory Data Analysis, Course Project 2, Question 2

## The two files are in our working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
options(scipen=999)

png(filename = 'plot2.png', width = 480, height = 480, units = 'px')

## 2. Have total emissions from PM2.5 decreased in the BALTIMORE City, Maryland from 1999 to 2008?
## Baltimore : fips == "24510"
BalNEI <- NEI[(NEI$fips=="24510"),]
BalEmi <- data.frame()
BalEmi <- aggregate(BalNEI$Emissions, by=list(BalNEI$year), FUN=sum)
names(BalEmi) <- c("Year", "PM2.5 Emissions (in Tons)")
plot(BalEmi, pch=20, type="l", main="2. PM2.5 Emissions in Baltimore City", lwd=2)

dev.off()

## Exploratory Data Analysis, Course Project 2, Question 3

## The two files are in our working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
options(scipen=999)

## 3. Of the four types of SOURCES indicated by the type variable,
## which of these four sources have seen decreases in emissions from 1999-2008 for BALTIMORE City?
## Which have seen increases in emissions from 1999-2008?
## Use the ggplot2 plotting system
library(ggplot2)
BalSou <- data.frame()
BalSou <- aggregate(BalNEI$Emissions, by=list(BalNEI$year,BalNEI$type), FUN=sum)
names(BalSou) <- c("Year", "Type", "Emissions")
g <- ggplot(BalSou, aes(Year,Emissions))
p <- g + geom_point() + geom_line() + facet_grid(. ~ Type) + labs(title="3. PM2.5 Emissions by Type in Baltimore City") + labs(y=expression("PM2.5 Emissions (in Tons)"))

ggsave("plot3.png", width=8, height=4)

## Exploratory Data Analysis, Course Project 2, Question 4

## The two files are in our working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
options(scipen=999)

png(filename = 'plot4.png', width = 480, height = 480, units = 'px')

## 4. Across the United States, how have emissions from COAL-COMBUSTION RELATED (Ccr) sources changed from 1999-2008?
sub1 <- grep('Coal',SCC$Short.Name, ignore.case = FALSE)  ## dim: 230
## There are 9 occurrences of "Charcoal".
## sub2 <- grep('harcoal',SCC$Short.Name). We do not want to select those.
## sub5 <- grep('coal',SCC$Short.Name, ignore.case = FALSE) also selects the 9 occurrences of Charcoal
## So, our selection sub1 is fine.
## SCC[sub1,1] returs all the 230 SCC names (e.g. 10100101) which Short names includes "Coal".
CcrCodes <- SCC[sub1,1]
CcrData <- subset(NEI, NEI$SCC %in% CcrCodes)
CcrEmi <- data.frame()
CcrEmi <- aggregate(CcrData$Emissions, by=list(CcrData$year), FUN=sum)
names(CcrEmi) <- c("Year", "PM2.5 Emissions (in Tons)")
plot(CcrEmi, pch=20, type="l", main="4. Coal Combustion-Related PM2.5 Emissions in the United States", lwd=2)

dev.off()

## Exploratory Data Analysis, Course Project 2, Question 5

## The two files are in our working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
options(scipen=999)

png(filename = 'plot5.png', width = 480, height = 480, units = 'px')

## 5. How have emissions from MOTOR VEHICLE sources changed from 1999-2008 in BALTIMORE City?
## We select the SCC$EI.Sector which contain the word 'Vehicle'.
sub55 <- grep('Vehicle',SCC$EI.Sector, ignore.case = TRUE) ## dim: 1138

MotorCodes <- SCC[sub55,1]
MotorData <- subset(BalNEI, BalNEI$SCC %in% MotorCodes)

MotorEmi <- data.frame()
MotorEmi <- aggregate(MotorData$Emissions, by=list(MotorData$year), FUN=sum)
names(MotorEmi) <- c("Year", "PM2.5 Emissions (in Tons)")
plot(MotorEmi, pch=20, type="l", main="5. Motor Vehicles PM2.5 Emissions in Baltimore City", lwd=2)

dev.off()

## Exploratory Data Analysis, Course Project 2, Question 6

## The two files are in our working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
options(scipen=999)

## 6. Compare emissions from motor vehicle sources in BALTIMORE City
## with emissions from motor vehicle sources in LOS ANGELES County, California.
## Which city has seen greater changes over time in motor VEHICLE emissions?
## Baltimore : fips == "24510" ; Los Angeles : fips == "06037"
BalLosNEI <- NEI[(NEI$fips=="24510" | NEI$fips=="06037" ),]   ## Dim : 11416 x 6
BalLosMotor <- data.frame()
BalLosMotor <- aggregate(BalLosNEI$Emissions, by=list(BalLosNEI$year,BalLosNEI$fips), FUN=sum)
names(BalLosMotor) <- c("Year", "City", "Emissions")
BalLosMotor$City[(BalLosMotor$City=="06037")] <- "Baltimore City"
BalLosMotor$City[(BalLosMotor$City=="24510")] <- "Los Angeles County"
g6 <- ggplot(BalLosMotor, aes(Year,Emissions))
p6 <- g6 + geom_point() + geom_line() + facet_grid(. ~ City) + labs(title="6. PM2.5 Motor Vehicle PM2.5 Emissions in Baltimore City and Los Angeles County") + labs(y=expression("PM2.5 Emissions (in Tons)"))
ggsave("plot6.png", width=8.5, height=4)


