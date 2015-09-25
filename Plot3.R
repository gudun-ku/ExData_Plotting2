## Script Name: Plot3. 
## Fluctuations in PM2.5 Emissions in Baltimore County

## Questions 3: Of the four types of sources indicated by the type 
##(point, nonpoint, onroad, nonroad) variable, which of these four sources
## have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008?

## Question 3: Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == “24510”) from 1999 to 2008?


## 1. Set working directory
setwd("D:/bell/learn/DataScience/EDA/ExData_Plotting2")

## 2. Read in the data (suppose data file is in working directory already)

unzip("exdata-data-NEI_data.zip","summarySCC_PM25.rds")
unzip("exdata-data-NEI_data.zip","Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



## 3. Subsetting the data to get only Baltimore County emissions
NEI_Balt <- subset(NEI, fips == "24510")

## 4. Get summary data to plot

NEI_Balt.types <- aggregate(NEI_Balt[c("Emissions")],
                          list(type = NEI_Balt$type, year = NEI_Balt$year),
                          sum )

## 5. Plotting the data
library(ggplot2)
qplot(year,
      Emissions,
      data = NEI_Balt.types,
      color = type, 
      geom= "line"
      ) + 
  theme_bw() +
  ggtitle("Emissions in Baltimore County by Source Type") + 
  xlab("Year") + ylab(" " ~ PM[2.5] ~ " Emissions, tons")                     


dev.copy(png,"Plot3.png", width = 800, height = 600)
dev.off()

## Answer: 
## From the plot, we see that emissions from nonpoint, off-road and on-road 
## sources have consistently decreaded over the period from 1999 to 2008. 
## Point emissions are inconsistent over the time period and had a local 
## peak in 2005.




