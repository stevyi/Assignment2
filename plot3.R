# Project 2 – Plot3.R
 
rm(list=ls())
library("plyr")
library(ggplot2)

# Initial loading take few seconds
# Load data from local working directory which have both unzip rds files
# setwd("~/Data Science/L4-Exploratory Data Analysis/Assignment2")

EmissionsIndex <- readRDS("summarySCC_PM25.rds")
Src_ClassC <- readRDS("Source_Classification_Code.rds")

# Question 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases or increases in
# emissions from 1999 to 2008 for Baltimore City?
# Use the ggplot2 plotting system to make a plot answer this question.

Baltimore <- subset(EmissionsIndex, fips == "24510")

aggregate(Emissions ~ year,Baltimore,sum)
png("plot3.png",width=720,height=480)
 
# Do the GG Plotting
GGPlotting <- ggplot(Baltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City by Source Type, 1999-2008"))

print(GGPlotting)

dev.off()