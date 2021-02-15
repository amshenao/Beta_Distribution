#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
# Define UI for application that draws a histogram
shinyUI(dashboardPage(skin = "blue",
                      dashboardHeader(title = "Beta Distribution",  titleWidth = 350),
                      dashboardSidebar(
                        sidebarMenu(
                          menuItem("Plot",tabName = "plot",icon = icon("chart-bar")),
                          menuItem("Theory",tabName = "teoria",icon = icon("align-center")),
                          menuItem("About us", tabName = "datos",icon = icon("chalkboard-teacher"))
                        )
                        
                      ),
                      dashboardBody(
                        tabItems(
                          tabItem(tabName = "plot",
                                  fluidRow(
                                    box(
                                      width = 8,
                                      title="Probability Density Function & Cumulative Distribution Function",
                                      solidHeader = TRUE,
                                      status  =   "primary",
                                      plotOutput("Plot",height = 350),
                                      box(
                                        width=8,
                                        title = "Measures of Central Tendency & Measures of Statistical Dispersion",
                                        status = "primary",
                                        "Here the user can find some measures of interest of the Beta distribution.",
                                        br(),
                                        tableOutput("datos")),
                                      valueBoxOutput("progressBox")
                                    ),
                                    br(),
                                    box(
                                      width = 4,
                                      solidHeader = TRUE,
                                      title = "Parameters & Information",
                                      status = "primary",
                                      "This Shiny application can be used to ilustrate behavior of the density and acumulative function of the Beta distribution corresponding to the parameters Î±; and Î²,which must be entered by the user. ",
                                      br(),
                                      numericInput("alpha",
                                                   label = HTML("Enter the value of &alpha;: "),
                                                   min = 0,
                                                   value = 2,
                                                   step=0.1),
                                      numericInput("beta",
                                                   label = HTML("Enter the value of &beta;: "),
                                                   min = 0,
                                                   value = 5,
                                                   step=0.1),
                                      selectInput(inputId="numero",
                                                  label = HTML("Options to calculate: "),
                                                  choices = c("Probability","Percentile"),
                                                  selected="Percentile"),
                                      conditionalPanel(condition="input.numero=='Probability'",
                                                       numericInput(inputId="percentil",
                                                                    label="Enter percentile: ",
                                                                    value=0.4, step=0.01)),
                                      conditionalPanel(condition="input.numero=='Percentile'",
                                                       numericInput(inputId="probabilidad",
                                                                    label="Enter probability: ",
                                                                    value=0.50, step=0.001, 
                                                                    min=0.001, max=0.999))
                                    )
                                    
                                  )),
                          tabItem(tabName = "teoria",includeHTML("teoria_beta.html"))
                          
                          
                        ),
                        tabItem(tabName = "datos", includeHTML("datos.html"),collapsed="TRUE")
                      )
                      
)
)



