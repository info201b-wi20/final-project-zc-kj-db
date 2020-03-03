library(plotly)

get_mid_gas_chart <- function() {

  # Pull the data from our csv and convert it into a dataframe
  us_mid_gas_prices <- read.csv(
    "../data/U.S._Midgrade_Gasoline_Prices_Annual.csv",
    stringsAsFactors = FALSE
  )


  # Create a plot, then pipe that plot into the `layout()` function to modify it
  mid_chart <- plot_ly(
    data = us_mid_gas_prices, # data to be visualized
    x = ~year, # x-axis
    y = ~price, # y-axis
    type = "scatter", # type of plot
    mode = "line"
  ) %>%
    layout(
      title = "Midgrade Gas Prices Through the Years", # plot title
      xaxis = list(title = "year"), # axis label + format
      yaxis = list(title = "Price", ticksuffix = "$") # axis label + format
    )

  return(mid_chart)
}
