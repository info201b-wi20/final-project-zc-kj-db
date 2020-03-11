library("shinythemes")
source("analysis.R")

#Creates the homepage
home_page <- tabPanel(
  "Car Sales and Gas Prices",
  titlePanel('Car Sales & Gas Prices Overview'),
  mainPanel(
    h1('Main Research Question'),
    tags$h4("What is the relationship between gas prices and car sales?")
  ),
  mainPanel(
    tags$hr(),
    h1('Additional Research Questions'),
    tags$li("Which months have the best car sales?"),
    tags$li("Do the gas prices reflect a balance on car sales")
  ),
  mainPanel(
    tags$hr(),
    h1("About our Data"),
    p("Our data is sourced from the US Energy Information Administration
      and Goodcarbadcar.net. The EIA collected the gasoline price data
      as monthly and annual averages and are simple averages of the
      weekly data contained therein. Goodcarbadcar.net compiled 
      data on US Automotive sales since 2005 broken down by month.
      This is on a unit basis and contains new vehicle sals in the US
      since 2005. Goodcarbadcar.net is rouced from the US Bureau of Economic
      Analyis Our data has 15 to 30 observations and 12 features.")
  ),
  sidebarPanel(
    h2('Important Links'),
    p(tags$a(href = "https://eia.gov/dnav/pet/pet_pri_gnd_dcus_nus_m.html", " US EIA dataset")),
    p(tags$a(href = "https://goodcarbadcar.net/usa-auto-industry-total-sales-figures","Goodcarbadcar.net")),
    p(tags$a(href = 'https://github.com/info201b-wi20/final-project-zc-kj-db/blob/master/README.md', "Project Brainstorm")),
    p(tags$a(href = "https://info201b-wi20.github.io/final-project-zc-kj-db/index.html", "Midpoint Report")),
    p(tags$a(href = "https://github.com/info201b-wi20/final-project-zc-kj-db", "Github Repository"))
  )
)

#Creates the main page with the charts above as subpages
chart_page <- tabPanel(
  "Visualizations",
  titlePanel("A Deeper Look at the Data"),
  tabsetPanel(
    #Creates the page with our gas chart visualization
    tabPanel(
      "Gas Prices",
      sidebarLayout(
        sidebarPanel(
          h3("Interactive Control"),
          selectInput(inputId = "year1", 
                      label = "Year to Display:",
                      choices = year_choices,
                      selected = "ALL")
        ),
        mainPanel(
          plotlyOutput("gas_plot")
        )
      )
    ),
    #creates our car sales analysis page
    tabPanel(
      "Car Sales",
      sidebarLayout(
        sidebarPanel(
          h3("Interactive Control"),
          selectInput(inputId = "year2", 
                      label = "Year to Display:",
                      choices = year_choices,
                      selected = "ALL")
        ),
        mainPanel(
          plotlyOutput("sales_plot")
        )
      )
    ),
    
    #creates our summary table page
    tabPanel(
      "Summary Table",
      titlePanel("Our Summarized Data"),
      DT::dataTableOutput("table")
    )
  )
)


#Creates our summary Page
summary_page <- tabPanel(
  "Summary",
  titlePanel("In Conclusion.."),
  mainPanel(
    p("For this project, we analyzed the relationship between car sales and gas prices.
      After analyzing the data, we were able to determine the peaks and valleys within 
      the United States car sales market, as well as the peaks and valleys in gas prices."),
    p("We found that in 2008, gas prices were the highest with regular gas prices averaging 
      at $4.18 in July, whereas car sales were very low, with less than a million car sales 
      at one point in the year. This is likely due to the United States' economic crash that 
      occurred in September of 2008. In January of 2009, gas prices were the lowest that they 
      had been since 2005, with an average price of $1.90 for regular gas; a possible indication
      of a recovering economy."),
    p("Overall, there seems to be a correlation between gas prices and car sales, but more research
      should be conducted to determine whether the price of gas and the sales of cars are caused
      by one another. From the data we gathered and analyzed, we are able to better understand the
      fluctuations of the economy and its impact on different markets.")
    
    
    
  )
  
)

#Creates the contact info page
contact_page <- tabPanel(
  "Contact us",
  titlePanel("Contact Us:"),
  mainPanel(
    p("Zach Casler: zcasler@uw.edu"),
    p("Kylie Jones: jonesk85@uw.edu"),
    p("Dana Brooks: dabrooks@uw.edu") 
  )
)



# Defines the User Interaction
my_ui <- fluidPage( 
theme = shinytheme("flatly"),
  navbarPage(
    "Gas Prices Vs. Car Sales",
    home_page,
    chart_page,
    summary_page,
    contact_page
  )
)
