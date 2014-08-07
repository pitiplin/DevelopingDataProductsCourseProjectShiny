library(shiny)

BScatalog <- read.csv("BScatalog.csv")

shinyServer(
  function(input, output) {
    
    output$text1 <- renderText({input$magnitude[1]})
    output$text2 <- renderText({input$magnitude[2]})
    output$text3 <- renderText({
      if (input$radio == 1){
          "Table"
      }
      else if(input$radio == 2){
          "Plot"
      }
    })
    output$text4 <- renderText({
      x<-BScatalog[(BScatalog$Vmag>=input$magnitude[1]&BScatalog$Vmag<=input$magnitude[2]),input$xaxis]
      mean(x)
    })
    output$text5 <- renderText({
      x<-BScatalog[(BScatalog$Vmag>=input$magnitude[1]&BScatalog$Vmag<=input$magnitude[2]),input$xaxis]
      sd(x)
    })
    
    output$mytable = renderDataTable({
      BScatalog[(BScatalog$Vmag>=input$magnitude[1]&BScatalog$Vmag<=input$magnitude[2]),]
    })
    
    output$plot <- renderPlot({
      x<-BScatalog[(BScatalog$Vmag>=input$magnitude[1]&BScatalog$Vmag<=input$magnitude[2]),input$xaxis]
      
      if(input$yaxis=="NONE"){
        hist(x, xlab=input$xaxis, col='lightblue',main='Histogram')        
      }
      else{
        y<-BScatalog[(BScatalog$Vmag>=input$magnitude[1]&BScatalog$Vmag<=input$magnitude[2]),input$yaxis]
        plot(x,y, xlab=input$xaxis, ylab=input$yaxis, col='lightblue')
        abline(lm(y~x), col='red')
      }      
    })
  }
)