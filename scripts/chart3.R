library(plotly)

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
  data = us_prem_gas_prices,      # pass in the data to be visualized
  x = ~year, # use a formula to specify the column for the x-axis
  y = ~prices, # use a formula to specify the column for the y-axis
  # use a formula to specify the color encoding
  type = "scatter", # specify the type of plot to create
  mode = "line"  # determine the "drawing mode" for the scatter (points)
) %>%
  layout(
    title = "Premium Gas Prices Through the Years",                  # plot title
    xaxis = list(title = "year"), # axis label + format
    yaxis = list(title = "Price", ticksuffix = "$")  # axis label + format
  )
