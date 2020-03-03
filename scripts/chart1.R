# Line graph for regular gas prcies throughout the years
library(plotly)

get_reg_gas_chart <- function() {

  # Pull the data from our csv and convert it into a dataframe
  us_reg_gas_prices <- read.csv(
    "../data/U.S._Regular_Gasoline_Prices_Annual.csv",
    stringsAsFactors = FALSE
  )


  # Create a plot, then pipe that plot into the `layout()` function to modify it
  reg_chart <- plot_ly(
    data = us_reg_gas_prices, #  data to be visualized
    x = ~year, # the x-axis
    y = ~price, # the y-axis
    type = "scatter", #  type of plot
    mode = "line"
  ) %>%
    layout(
      title = "Regular Gas Prices Through the Years", # plot title
      xaxis = list(title = "year"), # axis label + format
      yaxis = list(title = "Price", ticksuffix = "$") # axis label + format
    )

  # returns the completed chart
  return(reg_chart)
}
