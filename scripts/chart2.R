library(plotly)

get_mid_gas_chart <- function(){
  us_mid_gas_prices <- read.csv("../data/U.S._Midgrade_Gasoline_Prices_Annual.csv",
                                stringsAsFactors = FALSE)
  
  
  # Create a plot, then pipe that plot into the `layout()` function to modify it
  # (Example adapted from the Plotly documentation)
  mid_chart <- plot_ly(
    data = us_mid_gas_prices,      # pass in the data to be visualized
    x = ~year, # use a formula to specify the column for the x-axis
    y = ~price, # use a formula to specify the column for the y-axis
    # use a formula to specify the color encoding
    type = "scatter", # specify the type of plot to create
    mode = "line"  # determine the "drawing mode" for the scatter (points)
  ) %>%
    layout(
      title = "Midgrade Gas Prices Through the Years",                  # plot title
      xaxis = list(title = "year"), # axis label + format
      yaxis = list(title = "Price", ticksuffix = "$")  # axis label + format
    )
  
  return(mid_chart)
}


