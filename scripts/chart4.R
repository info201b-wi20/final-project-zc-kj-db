#Line graph 
library(plotly)

get_car_sales_chart <- function(){
  car_sales <- read.csv("../data/US_Vehicle_Sales_Monthly.csv",
                        stringsAsFactors = FALSE)
  car_sales <- car_sales %>% gather(key = month, value = volume, -year)
  car_sales <- car_sales %>% 
    group_by(year) %>% 
    summarize(total_volume = sum(volume))
  car_sales_summary$year <- as.numeric(car_sales_summary$year)
  
  
  # Create a plot, then pipe that plot into the `layout()` function to modify it
  # (Example adapted from the Plotly documentation)
  sales_chart <- plot_ly(
    data = car_sales,      # pass in the data to be visualized
    x = ~year, # use a formula to specify the column for the x-axis
    y = ~total_volume, # use a formula to specify the column for the y-axis
    # use a formula to specify the color encoding
    type = "scatter", # specify the type of plot to create
    mode = "line"  # determine the "drawing mode" for the scatter (points)
  ) %>%
    layout(
      title = "Car Sales Volume Through the Years",                  # plot title
      xaxis = list(title = "year"), # axis label + format
      yaxis = list(title = "Sales Volume", tickprefix = "$")  # axis label + format
    )
  # returns the completed chart
  sales_chart
}

