## Script Name: Plot6. 

## Questions 6: Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

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
NEI.mv <- NEI[NEI$SCC %in% SCC.mvcodes$SCC & NEI$fips %in% c("24510","06037"),]

## 4. Aggregate data to get total emissions by years
NEI_total.mv <- aggregate(NEI.mv[c("Emissions")],
                               list(year = NEI.mv$year, city = NEI.mv$fips),
                               sum )

head(NEI_total.mv)
### change fips to city name
fipstocity <- function (x) {
  if(x == "24510")
    return("Baltimore")
  else 
    return("Los-Angeles")
}

NEI_total.mv$city <- sapply(NEI_total.mv$city,fipstocity)

## 5. Plotting the data, using stats_smooth to show the trend better.
library(ggplot2)

qplot(year, Emissions, data=NEI_total.mv, color=city, geom="line") + 
  stat_smooth(method="lm", se=FALSE, lty = 8) +
  theme_bw() +
  ggtitle(expression(atop("City Motor-Vehicle Emission Comparison", 
          atop(italic("Baltimore, MD and Los Angeles, from 1999 to 2008"))))) +   xlab("Year") +
  ylab(expression("Total " ~ PM[2.5] ~ "Emissions (tons)"))


dev.copy(png,"Plot6.png", width = 800, height = 600)
dev.off()

## Answer: 
## Los Angeles has a greater emission growth from 1999 to 2008 and despite 
## short period of decreasing emission level since 2005, the trend is still 
## upward.
## Baltimore city has had a much lover emission level since 1999 and it even
## slightly decreased by 2008 in accordance to downward trend. 
