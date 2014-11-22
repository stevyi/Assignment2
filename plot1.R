# Project 2 – Plot1.R
 
rm(list=ls())
library("plyr")

# Initial loading take few seconds
# Load data from local working directory which have both unzip rds files
# setwd("~/Data Science/L4-Exploratory Data Analysis/Assignment2")

EmissionsIndex <- readRDS("summarySCC_PM25.rds")

# Q1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Plot data showing the total PM 2.5 emission index from all sources
# for these 4 years: 1999, 2002, 2005 and 2008
TotalEmissions <- aggregate(Emissions ~ year,EmissionsIndex, sum)

png("plot1.png",width=480,height=480)
barplot(
  (TotalEmissions$Emissions)/10^3,
  names.arg=TotalEmissions$year,
  col="blue",
  xlab="Year",ylab=expression("PM"[2.5]*" Emissions (in Kilo-Tons)"),
  main=expression("Total PM"[2.5]*" Emissions from All US Sources")
)

dev.off()
