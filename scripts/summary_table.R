library("dplyr")
library("tidyr")
library("stringr")


# following lines rearrange chart for better organization and access
car_sales <- read.csv("../data/US_Vehicle_Sales_Monthly.csv",
                      stringsAsFactors = FALSE)
car_sales <- car_sales %>% gather(key = month, value = volume, -year)

# following lines modify chart so data can be accessed easier
us_reg_gas_prices <- read.csv("../data/U.S._Regular_Gasoline_Prices_Monthly.csv",
                              stringsAsFactors = FALSE)
us_reg_gas_prices <- us_reg_gas_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
us_reg_gas_prices$year <- str_pad(us_reg_gas_prices$year, 
                                  width=2, 
                                  side="left", 
                                  pad="0")
us_reg_gas_prices$year <- paste0(20, us_reg_gas_prices$year)

car_sales_summary <- car_sales %>% 
  group_by(year) %>% 
  summarize(total_volume = sum(volume))


us_reg_gas_prices_summary <- us_reg_gas_prices %>% 
  group_by(year) %>% 
  summarize(average_price = round(mean(price), 3))
