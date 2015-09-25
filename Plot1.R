## Script Name: Plot1. 

## Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5

## 1. Set working directory
setwd("D:/bell/learn/DataScience/EDA/ExData_Plotting2")

## 2. Read in the data (suppose data file is in working directory already)

unzip("exdata-data-NEI_data.zip","summarySCC_PM25.rds")
unzip("exdata-data-NEI_data.zip","Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 3. Get summary data to plot
NEI_TOTAL <-tapply(NEI$Emissions, INDEX=NEI$year, sum)     
divider <- 1000000 ### let's plot emission amount in millions of tons
NEI_TOTAL <- NEI_TOTAL/divider

## 4. Plot and save data as picture
barplot(NEI_TOTAL, 
        main = "Total amount of Emissions across the U.S. by Year",
        xlab="",
        ylab="" ~ PM[2.5] ~ " Emissions amount, millions of tons", 
        col = "steelblue",
        space = 0.1, 
        sub = "Total emissions across the U.S from PM2.5 have decreased during the period since 1999 to 2008")

dev.copy(png,"Plot1.png", width = 800, height = 600)
dev.off()

## Answer: Yes, total emissions across the U.S from PM2.5 have decreased 
## during the period since 1999 to 2008.


