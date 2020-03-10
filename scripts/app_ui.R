library(shiny)
library(shiny)
library(plotly)

#Creates the homepage
home_page <- tabPanel(
  "Car Sales and Gas Prices",
  titlePanel('Overview'),
  mainPanel(
    h1('Main Research Question'),
    p("body text goes here")
  ),
  mainPanel(
    h1('Additional Research Questions'),
    p("body text here")
  ),
  mainPanel(
    h2('Important Links'),
    p("Link 1"),
    p("Link 2"),
    p("Link 3")
  )
)

#Creates the page with our gas chart visualization
gas_page <- tabPanel(
  "Gas Prices",
  titlePanel("Gas Prices Since 2005")
)


#creates our summary table page
table_page <- tabPanel(
  "Summary Table",
  titlePanel("Our Sumamrized Data")
)

#creates our car sales analysis page
car_page <- tabPanel(
  "Car Sales",
  titlePanel("Car Sales Since 2005")
)

#Creates the main page with the charts above as subpages
chart_page <- tabPanel(
  "Visualizations",
  titlePanel("A Deeper Look at the Data")
)


#Creates our summary Page
summary_page <- tabPanel(
  "Summary",
  titlePanel("In Conclusion.."),
  mainPanel(
    p("Summarization goes Here")
  )
  
)

#Creates the contact info page
contact_page <- tabPanel(
  "Contact us",
  titlePanel("Contact Us:"),
  mainPanel(
    p("Zach Casler:"),
    p("Kylie Jones:"),
    p("Dana Brooks:")
  )
)



# Defines the User Interaction
my_ui <- fluidPage(
  navbarPage(
    "Project ZKD",
    home_page,
    chart_page,
    summary_page,
    contact_page
  )
)
