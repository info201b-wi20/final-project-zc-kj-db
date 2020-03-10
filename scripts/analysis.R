library("dplyr")
library("tidyr")
library("plotly")
library("stringr")

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
all_prices <- rbind(reg_prices, mid_prices, prem_prices)
#########

# make aggregate table to display

#########

# make car sales df to graph

#########

