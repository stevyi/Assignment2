# Project 2 – Plot2.R
 
rm(list=ls())
library("plyr")

# Initial loading take few seconds
# Load data from local working directory which have both unzip rds files
# setwd("~/Data Science/L4-Exploratory Data Analysis/Assignment2")

EmissionsIndex <- readRDS("summarySCC_PM25.rds")

# Q2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008
# To check the total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008. 
# Use the base plotting system to make a plot answering this question.

Baltimore <- EmissionsIndex[EmissionsIndex$fips == "24510",]
aggBaltimore <- aggregate(Emissions ~ year,Baltimore,sum)

png("plot2.png",width=480,height=480)
barplot(
  aggBaltimore$Emissions,
  names.arg=aggBaltimore$year,
  col="blue",
  xlab="Year",ylab=expression("Total PM"[2.5]*" Emissions (in Tons)"), 
    main=expression("Total PM"[2.5]*" Emissions from all Baltimore City Sources")
)

dev.off()
