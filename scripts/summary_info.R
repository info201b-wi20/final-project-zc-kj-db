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



get_df_summary1 <- function(df) {
  output <- list()
  output$num_columns <- length(df)
  output$num_rows <- df %>% nrow()
  output$start_year <- df %>% 
    filter(year == min(year)) %>% 
    pull(year) %>% 
    unique()
  output$end_year <- df %>%
    filter(year == max(year)) %>% 
    pull(year) %>% 
    unique()
  output$most_volume_ever <- df %>% 
    filter(volume == max(volume)) %>% 
    pull(volume)
  output$most_volume_year <- df %>% 
    filter(volume == max(volume)) %>% 
    pull(year)
  output$most_volume_month <- df %>% 
    filter(volume == max(volume)) %>% 
    pull(month)
  output$num_best_year_volume <- car_sales %>% 
    group_by(year) %>% 
    summarize(total_volume = sum(volume)) %>% 
    filter(total_volume == max(total_volume)) %>% 
    pull(total_volume)
  output$best_year_volume <- car_sales %>% 
    group_by(year) %>% 
    summarize(total_volume = sum(volume)) %>% 
    filter(total_volume == max(total_volume)) %>% 
    pull(year)
  output
} 
test_summary1 <- get_df_summary1(car_sales)

get_df_summary2 <- function(df) {
  output <- list()
  output$num_columns <- length(df)
  output$num_rows <- df %>% nrow()
  output$start_year <- df %>% 
    filter(year == min(year)) %>% 
    pull(year) %>% 
    unique()
  output$end_year <- df %>%
    filter(year == max(year)) %>% 
    pull(year) %>% 
    unique()
  output$num_highest_price <- df %>% 
    filter(price == max(price)) %>% 
    pull(price)
  output$month_highest_price <- us_reg_gas_prices %>% 
    filter(price == max(price)) %>% 
    pull(month)
  output$year_highest_price <- us_reg_gas_prices %>% 
    filter(price == max(price)) %>% 
    pull(year)
  output
}
test_summary2 <- get_df_summary2(us_reg_gas_prices)
