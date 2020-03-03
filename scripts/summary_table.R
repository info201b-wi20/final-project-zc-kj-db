library("dplyr")
library("tidyr")
library("stringr")


# following lines rearrange chart on import for better organization and access
car_sales <- read.csv("../data/US_Vehicle_Sales_Monthly.csv",
                      stringsAsFactors = FALSE)
car_sales <- car_sales %>% gather(key = month, value = volume, -year)

# following lines modify chart on import so data can be accessed easier:
# imports regular teir gas prices
us_reg_gas_prices <- read.csv("../data/U.S._Regular_Gasoline_Prices_Monthly.csv",
                              stringsAsFactors = FALSE)
us_reg_gas_prices <- us_reg_gas_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
us_reg_gas_prices$year <- str_pad(us_reg_gas_prices$year, 
                                  width=2, 
                                  side="left", 
                                  pad="0")
us_reg_gas_prices$year <- paste0(20, us_reg_gas_prices$year)
# imports mid teir gas prices
us_mid_gas_prices <- read.csv("../data/U.S._Midgrade_Gasoline_Prices_Monthly.csv",
                              stringsAsFactors = FALSE)
us_mid_gas_prices <- us_mid_gas_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
us_mid_gas_prices$year <- str_pad(us_mid_gas_prices$year, 
                                  width=2, 
                                  side="left", 
                                  pad="0")
us_mid_gas_prices$year <- paste0(20, us_mid_gas_prices$year)
# imports premium teir gas prices
us_prem_gas_prices <- read.csv("../data/U.S._Premium_Gasoline_Prices_Monthly.csv",
                              stringsAsFactors = FALSE)
us_prem_gas_prices <- us_prem_gas_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
us_prem_gas_prices$year <- str_pad(us_prem_gas_prices$year, 
                                  width=2, 
                                  side="left", 
                                  pad="0")
us_prem_gas_prices$year <- paste0(20, us_prem_gas_prices$year)

get_aggregate_table <- function() {
  # summarizes total car sales volume by year
  car_sales_summary <- car_sales %>% 
    group_by(year) %>% 
    summarize(total_volume = sum(volume))
  car_sales_summary$year <- as.numeric(car_sales_summary$year)
  # summarized regular gas prices by year
  us_reg_gas_prices_summary <- us_reg_gas_prices %>% 
    group_by(year) %>% 
    summarize(reg_average_price = round(mean(price), 3))
  us_reg_gas_prices_summary$year <- as.numeric(us_reg_gas_prices_summary$year)
  # summarized midgrade gas prices by year
  us_mid_gas_prices_summary <- us_mid_gas_prices %>% 
    group_by(year) %>% 
    summarize(mid_average_price = round(mean(price), 3))
  us_mid_gas_prices_summary$year <- as.numeric(us_mid_gas_prices_summary$year)
  # summarized premium gas prices by year
  us_prem_gas_prices_summary <- us_prem_gas_prices %>% 
    group_by(year) %>% 
    summarize(prem_average_price = round(mean(price), 3))
  us_prem_gas_prices_summary$year <- as.numeric(us_prem_gas_prices_summary$year)
  # combines all columns into one table
  aggregate_table <- left_join(car_sales_summary, 
                               us_reg_gas_prices_summary,
                               by = "year") %>% 
    left_join(us_mid_gas_prices_summary, by = "year") %>% 
    left_join(us_prem_gas_prices_summary, by = "year")
  # formats column names nicely
  aggregate_table <- aggregate_table %>% 
    rename(
    "Year" = year,
    "Car Sales Volume" = total_volume,
    "Average Regular-Grade Price" = reg_average_price,
    "Average Mid-Grade Price" = mid_average_price,
    "Average Premium-Grade Price" = prem_average_price,
    )
  aggregate_table
}