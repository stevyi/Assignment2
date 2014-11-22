# Project 2 - Plot6.R
rm(list=ls())
library("plyr")
library(ggplot2)

# Initial loading take few seconds
# Load data from local working directory which have both unzip rds files
# setwd("~/Data Science/L4-Exploratory Data Analysis/Assignment2")
EmissionsIndex <- readRDS("summarySCC_PM25.rds")
Src_ClassC <- readRDS("Source_Classification_Code.rds")

# Q6.Compare emissions from motor VEHICLE  sources in Baltimore City with emissions from motor 
# VEHICLE  sources in Los Angeles County, California (fips == "06037")
# To find out which city has seen greater changes over time in motor vehicle emissions

# Get the SCC & NEI data for vehicles
Vehicles <- grepl("vehicle", Src_ClassC$SCC.Level.Two, ignore.case=T)
VehiclesSCC <- Src_ClassC[Vehicles,]$SCC
VehiclesNEI <- EmissionsIndex[EmissionsIndex$SCC %in% VehiclesSCC,]

# Get the vehicles NEI data by each city's fip and with city name inclusive
NEIVehiclesBaltimore <- VehiclesNEI[VehiclesNEI$fips=="24510",]
NEIVehiclesBaltimore$city <- "Baltimore City"
NEIVehiclesLA <- VehiclesNEI[VehiclesNEI$fips=="06037",]
NEIVehiclesLA$city <- "Los Angeles County"

# Combine both NEI with city name into one table
BNEI <- rbind(NEIVehiclesBaltimore,NEIVehiclesLA)
png("plot6.png",width=600,height=480)
 
# Do the GG Plotting
GGPlotting <- ggplot(BNEI, aes(factor(year), Emissions, fill=city)) +
 geom_bar(stat="identity") +
 facet_grid(.~city,scales="free", space="free") +
 labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (Kilo-Tons)")) + 
 labs(title=expression("PM"[2.5]*" Emissions from Motor Vehicle Sources in Baltimore & LA, 1999-2008"))
 
print(GGPlotting)
dev.off()
