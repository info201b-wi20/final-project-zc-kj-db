#Line graph 
library(plotly)

us_reg_gas_prices <- read.csv("../data/U.S._Regular_Gasoline_Prices_Annual.csv",
                              stringsAsFactors = FALSE)
us_reg_gas_prices <- us_reg_gas_prices[-c(182:354), ]
us_reg_gas_prices <- us_reg_gas_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
us_reg_gas_prices$year <- str_pad(us_reg_gas_prices$year, 
                                  width=2, 
                                  side="left", 
                                  pad="0")
us_reg_gas_prices$year <- paste0(20, us_reg_gas_prices$year)

us_mid_gas_prices <- read.csv("../data/U.S._Midgrade_Gasoline_Prices_Monthly.csv",
                              stringsAsFactors = FALSE)
us_mid_gas_prices <- us_mid_gas_prices[-c(182:354), ]
us_mid_gas_prices <- us_mid_gas_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
us_mid_gas_prices$year <- str_pad(us_mid_gas_prices$year, 
                                  width=2, 
                                  side="left", 
                                  pad="0")
us_mid_gas_prices$year <- paste0(20, us_mid_gas_prices$year)

us_prem_gas_prices <- read.csv("../data/U.S._Premium_Gasoline_Prices_Monthly.csv",
                              stringsAsFactors = FALSE)
us_prem_gas_prices <- us_prem_gas_prices[-c(182:354), ]
us_prem_gas_prices <- us_prem_gas_prices %>% 
  separate(date, sep = "-", into = c("year", "month"))
us_prem_gas_prices$year <- str_pad(us_prem_gas_prices$year, 
                                  width=2, 
                                  side="left", 
                                  pad="0")
us_prem_gas_prices$year <- paste0(20, us_prem_gas_prices$year)


# Create a plot, then pipe that plot into the `layout()` function to modify it
# (Example adapted from the Plotly documentation)
plot_ly(
  data = us_reg_gas_prices,      # pass in the data to be visualized
  x = ~year, # use a formula to specify the column for the x-axis
  y = ~price, # use a formula to specify the column for the y-axis
 # use a formula to specify the color encoding
  type = "scatter", # specify the type of plot to create
  mode = "line"  # determine the "drawing mode" for the scatter (points)
) %>%
  layout(
    title = "Regular Gas Prices Through the Years",                  # plot title
    xaxis = list(title = "year"), # axis label + format
    yaxis = list(title = "Price", ticksuffix = "$")  # axis label + format
  )
