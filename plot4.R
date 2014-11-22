# Project 2 - Plot4.R

rm(list=ls())
library("plyr")
library(ggplot2)

# Initial loading take few seconds
# Load data from local working directory which have both unzip rds files
# setwd("~/Data Science/L4-Exploratory Data Analysis/Assignment2")

EmissionsIndex <- readRDS("summarySCC_PM25.rds")
Src_ClassC <- readRDS("Source_Classification_Code.rds")
 
# Q4.Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999-2008

# Get the coal combustion related SCC & NEI data
Combustion <- grepl("comb", Src_ClassC$SCC.Level.One, ignore.case=T)
CoalR <- grepl("coal", Src_ClassC$SCC.Level.Four, ignore.case=T) 

SCC_Combustion <- Src_ClassC[Combustion & CoalR,]$SCC
NEI_Combustion <- EmissionsIndex[EmissionsIndex$SCC %in% SCC_Combustion,]

png("plot4.png",width=540,height=480)
 
# Do the GG Plotting
GGPlotting <- ggplot(NEI_Combustion,aes(factor(year),Emissions/1000)) +
  geom_bar(stat="identity",fill="blue",width=0.6) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (in Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions from Coal-combustion Sources across the US, 1999 - 2008"))

print(GGPlotting)

dev.off()
