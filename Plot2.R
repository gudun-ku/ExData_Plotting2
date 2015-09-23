## Script Name: Plot2. 

## Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, 
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
NEI_Balt_total <-tapply(NEI_Balt$Emissions, INDEX=NEI_Balt$year, sum)     

## 5. Plot and save data as picture
plot(names(NEI_Balt_total),
     NEI_Balt_total,
     type = "o",
     main = "Total PM2.5 Emissions in Baltimore County",
     xlab = "",
     ylab = "PM2.5 Emissions",
     pch = 18, col = "red",
     lty = 5,
     lwd = 2,
     sub = "Total emission level in Baltimore county have decreased in range from 1999 to 2008")

## use lm to make trend line on plot, to show it. 
lmodel <- lm(NEI_Balt_total ~ as.integer(names(NEI_Balt_total)))
abline(lmodel,col = "darkgreen", lwd = 2)

## add legend to plot
legend(2005,3325, 
       c("Emission","Trend"), 
       lty=c(5,1),
       lwd=c(2,2),
       col=c("red","darkgreen")) 


dev.copy(png,"Plot2.png", width = 800, height = 600)
dev.off()

## Answer: Yes, total emissions across the Baltimore County from PM2.5 have decreased 
## during the period since 1999 to 2008.



