# TODO: Add comment
# 
# Author: pacha
###############################################################################

#QUESTION1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
#Upload a PNG file containing your plot addressing this question.

setwd("/Users/pacha/Dropbox/R/exdata/course-project-2")

library(plyr)
library(ggplot2)
library(data.table)
library(grid)
library(scales)
library(httr) 

direccion <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
datos <- "datos"
if(!file.exists(datos)){
	dir.create(datos)
} 
graficos <- "graficos" 
if(!file.exists(graficos)){
	dir.create(graficos)
}
archivo <- paste(getwd(), "/datos/exdata_data_NEI_data.zip", sep = "")
if(!file.exists(archivo)){
	download.file(direccion, archivo, method="curl", mode="wb")
}
archivo1 <- paste(getwd(), "/datos/Source_Classification_Code.rds", sep = "")
if(!file.exists(archivo1)){
	unzip(archivo, list = FALSE, overwrite = FALSE, exdir = datos)
}
archivo2 <- paste(getwd(), "/datos/summarySCC_PM25.rds", sep = "")
if(!file.exists(archivo2)){
	unzip(archivo, list = FALSE, overwrite = FALSE, exdir = datos)
}

clasificacion <- readRDS("datos/Source_Classification_Code.rds")
datos <- readRDS("datos/summarySCC_PM25.rds")

clasificacion = data.table(clasificacion)
datos = data.table(datos)

contaminacion <- with(datos, aggregate(Emissions, by = list(year), sum))

png("graficos/plot1.png", width = 480, height = 480)
plot(contaminacion, type = "b", pch = 25, col = "blue", ylab = "Emissions", xlab = "Year", main = "Annual Emissions")
dev.off()

#QUESTION2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

baltimore <- datos[which(datos$fips == "24510"), ]
baltimore2 <- with(baltimore, aggregate(Emissions, by = list(year), sum))
colnames(baltimore2) <- c("year", "Emissions")

png("graficos/plot2.png", width = 480, height = 480)
plot(baltimore2$year, baltimore2$Emissions, type = "b", pch = 25, col = "red", 
		ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")
dev.off()

#QUESTION3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources 
#have seen decreases in emissions from 1999Ð2008 for Baltimore City? Which have seen increases in emissions from 1999Ð2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

baltimore3 <- ddply(baltimore, .(type, year), summarize, Emissions = sum(Emissions))

png("graficos/plot3.png", width = 480, height = 480)
qplot(year, Emissions, data = baltimore3, group = type, 
		color = type, geom = c("point", "line"), ylab = expression("Total Emissions of PM"[2.5]), 
		xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")
dev.off()

#QUESTION4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999Ð2008?

coal1 = clasificacion[grep("Coal", SCC.Level.Three), SCC]
coal2 = datos[SCC %in% coal1, sum(Emissions), by = "year"]
setnames(coal2, c("year", "Emissions"))

png("graficos/plot4.png", width = 480, height = 480)
g = ggplot(coal2, aes(year, Emissions))
g + geom_point(color = "black") + geom_line(color = "blue") + labs(x = "Year") + 
		labs(y = expression("Total Emissions of PM"[2.5])) + labs(title = "Emissions from Coal Combustion for the US")
dev.off()

#QUESTION5
#How have emissions from motor vehicle sources changed from 1999Ð2008 in Baltimore City? 

motor1 = clasificacion[grep("[Mm]obile|[Vv]ehicles", EI.Sector), SCC]
motor2 = datos[SCC %in% motor1, sum(Emissions), by = c("year", "fips")][fips == "24510"]
setnames(motor2, c("year", "fips", "Emissions"))

png("graficos/plot5.png", width = 480, height = 480)
g = ggplot(motor2, aes(year, Emissions))
g + geom_point(color = "black") + geom_line(color = "red") + labs(x = "Year") + 
		labs(y = expression("Total Emissions of PM"[2.5])) + 
		labs(title = "Total Emissions from Motor Vehicle Sources in Baltimore City")
dev.off()

#QUESTION6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?

baltimore4 <- datos[(datos$fips=="24510"), ]
baltimore4 <- aggregate(Emissions ~ year, data = baltimore4, FUN = sum)
losangeles <- datos[(datos$fips=="06037"),]
losangeles <- aggregate(Emissions ~ year, data = losangeles, FUN = sum)
baltimore4$County <- "Baltimore"
losangeles$County <- "Los Angeles"
ambasciudades <- rbind(baltimore4, losangeles)

fmt <- function(){
	f <- function(x) as.character(round(x,2))
	f
}

png("graficos/plot6.png", width = 480, height = 480)
ggplot(ambasciudades, aes(x=factor(year), y=Emissions, fill=County)) +
		geom_bar(aes(fill = County), position = "dodge", stat="identity") +
		labs(x = "Year") + labs(y = expression("Total Emissions (in log scale) of PM"[2.5])) +
		xlab("year") +
		ggtitle(expression("Motor vehicle emission in Baltimore and Los Angeles")) +
		scale_y_continuous(trans = log_trans(), labels = fmt())
dev.off()