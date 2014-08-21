library(shiny)
library(faraway)

data(hprice)
hprice$time<-hprice$time+1985

minYear<-min(hprice$time)
maxYear<-max(hprice$time)

shinyUI(
      navbarPage("Developing Data Products Course Project",
            
            tabPanel("Documentation",
                    mainPanel(
                      includeMarkdown("documentation.md")
                    )
            ),
            tabPanel("Application",
            
                p("Data Science Series"),
                p("Christopher Garcia Ambrozaitis"),
                p("August 2014"),
                
                sidebarPanel(
                  
                  sliderInput('year', 'Year:',value = c(minYear,maxYear), min = minYear, max = maxYear, step = 1),
                  
                  radioButtons("radio", "Select Visualization:",
                              choices = list("Show Table" = 1, "Show Plot" = 2),selected = 1),
                  
                  conditionalPanel(
                    condition = "input.radio == 2",
                    selectInput("xaxis", "X Axis:", choices = names(hprice)),
                    selectInput("yaxis", "Y Axis:", choices = c("NONE",names(hprice)))
                  )
                ),
                mainPanel(
                  p('Min Year'),
                  textOutput('text1'),
                  p(''),
                  p('Max Year'),
                  textOutput('text2'),
                  p(''),
                  p('Selected Visualization'),
                  textOutput('text3'),
                  p(''),
                  conditionalPanel(
                    condition = "input.yaxis == 'NONE' & input.radio == 2",
                    p('Mean'),
                    textOutput('text4'),
                    p(''),
                    p('Standard Deviation'),
                    textOutput('text5')
                  )
                ),
                
                conditionalPanel(
                  condition = "input.radio == 1",
                  tabsetPanel(
                    tabPanel(dataTableOutput("mytable"))
                  )
                ),
                
                conditionalPanel(
                  condition = "input.radio == 2",
                  plotOutput('plot')
                )  
            )
      )
)