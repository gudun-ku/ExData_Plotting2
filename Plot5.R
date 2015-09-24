## Script Name: Plot5. 

## Questions 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## 1. Set working directory
setwd("D:/bell/learn/DataScience/EDA/ExData_Plotting2")

## 2. Read in the data (suppose data file is in working directory already)

unzip("exdata-data-NEI_data.zip","summarySCC_PM25.rds")
unzip("exdata-data-NEI_data.zip","Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 3. Subset our data

SCC.mvtypes <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
SCC.mvcodes <- SCC[SCC$EI.Sector %in% SCC.mvtypes, ]["SCC"]

## subset NEI for get only the emissions from motor vehicles for Baltimore, MD.
NEI_Balt.mv <- NEI[NEI$SCC %in% SCC.mvcodes$SCC & NEI$fips == "24510",]

## 4. Aggregate data to get total emissions by years
NEI_Balt_total.mv <- aggregate(NEI_Balt.mv[c("Emissions")],
                            list(year = NEI_Balt.mv$year),
                            sum )

head(NEI_Balt_total.mv)

## 5. Plotting the data, using stats_smooth to show the trends better.
library(ggplot2)

qplot(year, Emissions, data=NEI_Balt_total.mv,  geom="line") + 
  stat_smooth(method="lm", se=FALSE, lty = 5, col = "steelblue") +
  ggtitle(expression("Motor Vehicle Emissions by Year in Baltimore, MD"))  + 
  xlab("Year") +
  ylab(expression("Total " ~ PM[2.5] ~ " Emissions (tons)"))

dev.copy(png,"Plot5.png", width = 800, height = 600)
dev.off()

## Answer: 
## From the plot, we see that total emission from motor vehicles in Baltimore County decreased in times
## during the period from 1999 to 2008,from about 350 tons in 1999 to less than 100 tons in 2008 
## Also we can see sharp downward trend in decreasing motor vehicle emissions.
