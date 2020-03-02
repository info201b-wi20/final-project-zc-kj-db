library(plotly)

get_prem_gas_chart <- function(){
  us_prem_gas_prices <- read.csv("../data/U.S._Premium_Gasoline_Prices_Annual.csv",
                                 stringsAsFactors = FALSE)
  
  
  # Create a plot, then pipe that plot into the `layout()` function to modify it
  # (Example adapted from the Plotly documentation)
  prem_chart <- plot_ly(
    data = us_prem_gas_prices,      # pass in the data to be visualized
    x = ~year, # use a formula to specify the column for the x-axis
    y = ~price, # use a formula to specify the column for the y-axis
    # use a formula to specify the color encoding
    type = "scatter", # specify the type of plot to create
    mode = "line"  # determine the "drawing mode" for the scatter (points)
  ) %>%
    layout(
      title = "Premium Gas Prices Through the Years",                  # plot title
      xaxis = list(title = "year"), # axis label + format
      yaxis = list(title = "Price", ticksuffix = "$")  # axis label + format
    )
  return(prem_chart)
}

