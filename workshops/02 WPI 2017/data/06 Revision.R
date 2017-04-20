library(ggplot2)
library(tidyr)
library(dplyr)
library(gdata)


dt <- ggplot2::mpg

# plot x, y graph of cyl vs cty

ggplot(data = dt) +
  geom_point(mapping = aes(x=cyl,y=cty))


ggplot(data = dt) +
  geom_point(mapping = aes(x=cyl,y=hwy,colour=class))


data <- as_data_frame(read.xls("data/energy/SalesData.xlsx"),stringsAsFactors=F)


# Add a new column

data <- mutate(data,Revenue=Units.Sold * Unit.Price)

# Calculate total sales per year 
tsales <- group_by(data,Year) %>% summarise(TotalSales=sum(Revenue))

# Calculate total sales per product by year sort by year (desc)
tsales_by_p <- group_by(data,Year,Product) %>% summarise(TotalSales=sum(Revenue)) %>%
                 arrange(desc(Year))






