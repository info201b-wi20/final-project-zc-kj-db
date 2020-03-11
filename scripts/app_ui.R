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
   # p(),
    p("Regular gas prices reached its peak
      in Jul 2008 at the price of $4.062 per gallon. 
      Surprisingly, regular gas prices hit its lowest point in our data set 
      in the same year. in Dec 2008, the average cost of regular gas was $1.687
      per gallon.")
    #p()
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
    "Project ZKD",
    home_page,
    chart_page,
    summary_page,
    contact_page
  )
)
