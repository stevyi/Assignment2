# Project 2 - Plot5.R

rm(list=ls())
library("plyr")
library(ggplot2)

# Initial loading take few seconds
# Load data from local working directory which have both unzip rds files
# setwd("~/Data Science/L4-Exploratory Data Analysis/Assignment2")

EmissionsIndex <- readRDS("summarySCC_PM25.rds")
Src_ClassC <- readRDS("Source_Classification_Code.rds")

# Q5.How have emissions from motor VEHICLE  sources 
# changed from 1999-2008 in Baltimore City?

# Get the SCC & NEI data for vehicles
Vehicles <- grepl("vehicle", Src_ClassC$SCC.Level.Two, ignore.case=T)
VehiclesSCC <- Src_ClassC[Vehicles,]$SCC
VehiclesNEI <- EmissionsIndex[EmissionsIndex$SCC %in% VehiclesSCC,]

# Subset the vehicles NEI data to Baltimore's fip
VehiclesNEI_Baltimore <- VehiclesNEI[VehiclesNEI$fips=="24510",]

png("plot5.png",width=600,height=480)

# Do the GG Plotting
GGPlotting <- ggplot(VehiclesNEI_Baltimore,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="blue",width=0.6) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (in Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions from Motor Vehicle Source in Baltimore, 1999-2008"))

print(GGPlotting)
dev.off()
