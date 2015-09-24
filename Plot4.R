## Script Name: Plot4. 

## Questions 4: Across the United States, how have emissions 
## from coal combustion-related sources changed from 1999–2008?

## 1. Set working directory
setwd("D:/bell/learn/DataScience/EDA/ExData_Plotting2")

## 2. Read in the data (suppose data file is in working directory already)

unzip("exdata-data-NEI_data.zip","summarySCC_PM25.rds")
unzip("exdata-data-NEI_data.zip","Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 3. subset for only coal-combustion
SCC_Coal_0 <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal",
                                         "Fuel Comb - Electric Generation - Coal",
                                         "Fuel Comb - Industrial Boilers, ICEs - Coal"))
### Add other possible coual-combustion related codes
SCC_Coal_1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

### union these subsets. Now we've got all codes related to coal combustion
SCC_Coal <- union(SCC_Coal_0$SCC, SCC_Coal_1$SCC)
NEI_Coal <- subset(NEI, SCC %in% SCC_Coal)

## 4. Get summary data to plot
NEI_Coal.types <- aggregate(NEI_Coal[c("Emissions")],
                            list(type = NEI_Coal$type, year = NEI_Coal$year),
                            sum )

head(NEI_Coal)
### let's plot emission amount in millions of tons
divider <- 1000000 
NEI_Coal.types$Emissions <- NEI_Coal.types$Emissions/divider

## 5. Plotting the data, using stats_smooth to show the trends better.
library(ggplot2)

qplot(year, Emissions, data=NEI_Coal.types, color=type, geom="line") + 
    stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "black", aes(shape="total"), geom="line") +
    geom_line(aes(size="total", shape = NA))+
    stat_smooth(method="lm", se=FALSE, lty = 5) +
    ggtitle(expression("Coal Combustion across the U.S. Emissions by Source Type and Year"))  + 
    xlab("Year") +
    ylab(expression("Total c" ~ PM[2.5] ~ "Emissions (millions of tons)"))

dev.copy(png,"Plot4.png", width = 800, height = 600)
dev.off()

## Answer: 
## From the plot, we see that total emission from coal combustion across the U.S significantly decreased ,
## during the period from 1999 to 2008, as for point sources where it was high enough as for non-point
## sources. Non-point sources are inconsistent along the period and more difficult to interpret,
## but a sharp decline since 2005 may indicate a initiated downward trend as well.




