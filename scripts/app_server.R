source("analysis.R")

my_server <- function(input, output) {
  output$gas_plot <- renderPlotly({
    plot_ly(
      data = get_df_by_year(reg_data, input$year1),
      x = ~get_x_axis(reg_data, input$year1), 
      y = ~price,
      hovertemplate = paste("<b>Price</b>: %{y}",
                            "<br><b>Month</b>: ", 
                            get_df_by_year(reg_data, input$year1)$month,
                            "<br><b>Year</b>: ",
                            get_df_by_year(reg_data, input$year1)$year),
      name = "Regular-Grade",
      type = "scatter", 
      mode = "lines"  
    ) %>%
      add_trace(data = get_df_by_year(mid_data, input$year1), y = ~price, name = "Mid-Grade", mode = "lines") %>% 
      add_trace(data = get_df_by_year(prem_data, input$year1), y = ~price, name = "Premium-Grade", mode = "lines") %>% 
      layout(
        title = paste0("U.S. Gas Prices for ", input$year1, " by Month"),
        xaxis = x_axis_order,
        yaxis = list(title = "Price Per Gallon", tickprefix = "$")
      ) %>% 
      layout(
        xaxis = list(title = input$year1)
      )
  })
  
  output$table <- DT::renderDataTable({
    DT::datatable(aggregate_table,
    options = list(lengthMenu = c(10, 25, 50, 100, 200),
                   pageLength = 10),
    rownames = FALSE
    )
  })
  
  output$sales_plot <- renderPlotly({
    plot_ly(
      data = get_df_by_year(car_sales, input$year2),
      x = ~get_x_axis(car_sales, input$year2), 
      y = ~volume,
      hovertemplate = paste("<b>Sales Volume</b>: %{y}",
                            "<br><b>Month</b>: ", 
                            get_df_by_year(car_sales, input$year2)$month, 
                            "<br><b>Year</b>: ",
                            get_df_by_year(car_sales, input$year2)$year),
      type = "scatter", 
      mode = "lines"  
    ) %>% 
      layout(
        title = paste0("U.S. Car Sales Volume for ", input$year2, " by Month"),
        xaxis = list(title = input$year2),
        yaxis = list(title = "Volume of Cars Sold")
      ) %>% 
      layout(
        xaxis = x_axis_order
      )
  })
}