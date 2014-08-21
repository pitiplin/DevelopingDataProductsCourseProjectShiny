library(shiny)
library(faraway)

data(hprice)
hprice$time<-hprice$time+1985

shinyServer(
  function(input, output) {
    
    output$text1 <- renderText({input$year[1]})
    output$text2 <- renderText({input$year[2]})
    output$text3 <- renderText({
      if (input$radio == 1){
        "Table"
      }
      else if(input$radio == 2){
        "Plot"
      }
    })
    output$text4 <- renderText({
      x<-hprice[(hprice$time>=input$year[1]&hprice$time<=input$year[2]),input$xaxis]
      mean(x)
    })
    output$text5 <- renderText({
      x<-hprice[(hprice$time>=input$year[1]&hprice$time<=input$year[2]),input$xaxis]
      sd(x)
    })
    
    output$mytable = renderDataTable({
      hprice[(hprice$time>=input$year[1]&hprice$time<=input$year[2]),]
    })
    
    output$plot <- renderPlot({
      x<-hprice[(hprice$time>=input$year[1]&hprice$time<=input$year[2]),input$xaxis]
      
      if(input$yaxis=="NONE"){
        hist(x, xlab=input$xaxis, col='lightblue',main='Histogram')        
      }
      else{
        y<-hprice[(hprice$time>=input$year[1]&hprice$time<=input$year[2]),input$yaxis]
        plot(x,y, xlab=input$xaxis, ylab=input$yaxis, col='lightblue')
        abline(lm(y~x), col='red')
      }      
    })
  }
)