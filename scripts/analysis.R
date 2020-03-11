library("dplyr")
library("tidyr")
library("plotly")
library("stringr")
library("zoo")

# Makes combined gas price from each dataset into one data set to graph it.
prem_prices <- read.csv("../data/U.S._Premium_Gasoline_Prices_Monthly.csv",
                        stringsAsFactors = FALSE)
prem_prices <- prem_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
prem_prices$year <- str_pad(prem_prices$year, 
                            width = 2, 
                            side = "left", 
                            pad = "0")
prem_prices$year <- paste0(20, prem_prices$year)
prem_prices <- prem_prices %>% mutate(type = "Premium")
prem_prices$year <- as.numeric(prem_prices$year)
mid_prices <- read.csv("../data/U.S._Midgrade_Gasoline_Prices_Monthly.csv",
                       stringsAsFactors = FALSE)
mid_prices <- mid_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
mid_prices$year <- str_pad(mid_prices$year, 
                           width = 2, 
                           side = "left", 
                           pad = "0")
mid_prices$year <- paste0(20, mid_prices$year)
mid_prices <- mid_prices %>% mutate(type = "Mid")
mid_prices$year <- as.numeric(mid_prices$year)
reg_prices <- read.csv("../data/U.S._Regular_Gasoline_Prices_Monthly.csv",
                       stringsAsFactors = FALSE)
reg_prices <- reg_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
reg_prices$year <- str_pad(reg_prices$year, 
                           width = 2, 
                           side = "left", 
                           pad = "0")
reg_prices$year <- paste0(20, reg_prices$year)
reg_prices <- reg_prices %>% mutate(type = "Regular")
reg_prices$year <- as.numeric(reg_prices$year)
all_prices <- rbind(reg_prices, mid_prices, prem_prices)

# sorts all gas prices from old to new
all_prices$x_axis <- as.yearmon(paste(all_prices$month, all_prices$year)) 
all_prices <- all_prices[order(all_prices$x_axis), ]


reg_data <- subset(all_prices, type == "Regular")
mid_data <- subset(all_prices, type == "Mid")
prem_data <- subset(all_prices, type == "Premium")

# function to get selected df by year
get_df_by_year <- function(df, selected_year) {
  if(selected_year == "All Years"){
    return(df)
  } else {
    df <- subset(df, year == selected_year)
    return(df)
  }
}


# gets correct x axis
x_axis_order <- list(categoryorder = "array",
                     categoryarray = c("Jan", "Feb", "Mar", "Apr", "May",
                                       "Jun", "Jul", "Aug", "Sep", "Oct",
                                       "Nov", "Dec"))
get_x_axis <- function(df, selected_year) {
  if(selected_year == "All Years"){
    return(df$x_axis)
  } else {
    df <- subset(df, year == selected_year)
    return(df$month)
  }
}

# makes list of choices by year
year_choices <- c("All Years", 2005:2019)

#########

# sets up car sales df to graph
car_sales <- read.csv("../data/US_Vehicle_Sales_Monthly.csv",
                      stringsAsFactors = FALSE,
                      fileEncoding = "UTF-8-BOM")
car_sales <- car_sales %>% gather(key = month, value = volume, -year)
car_sales$x_axis <- as.yearmon(paste(car_sales$month, car_sales$year)) 
car_sales <- car_sales[order(car_sales$x_axis), ]
#########

# make aggregate table to display, each df combined
aggregate_table <- left_join(reg_prices[,-4], 
                             mid_prices[,-4], 
                             by = c("year", "month")) %>% 
  left_join(prem_prices[,-4], by = c("year", "month")) %>% 
  left_join(car_sales, by = c("year", "month"))
aggregate_table <- aggregate_table %>% 
  rename(
    "Year" = year,
    "Month" = month,
    "Regular-Grade Price" = price.x,
    "Mid-Grade Price" = price.y,
    "Premium-Grade Price" = price,
    "Car Sales Volume" = volume
  )
aggregate_table <- aggregate_table[order(aggregate_table$x_axis), ]
aggregate_table <- aggregate_table[,-7]