
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$Plot <- renderPlot({
    if(input$numero=="Probability"){
      par(mfrow=c(1,2))
      curve(dbeta(x,shape1=input$alpha,shape2 = input$beta),ylab="f(x)",lwd=3,col="black",xlab="x",main="Probability Density Function (PDF)",las=1)
      axis(side=1, at=seq(0, 1, by=0.1))
      secuencia <- seq(0, input$percentil, length.out=10000)
      cord.x <- c(0,secuencia, input$percentil)
      cord.y <- c(0,dbeta(secuencia, shape1=input$alpha, shape2=input$beta), -100000)
      polygon(cord.x, cord.y, col="#A4BF41")
      axis(side=1, labels=FALSE)
      #per <- qbeta(p = input$percentil,shape1 = input$alpha, shape2 = input$beta)
      prob <- pbeta(q=input$percentil,shape1=input$alpha,shape2 = input$beta)
      curve(pbeta(x,shape1=input$alpha,shape2 = input$beta),ylab="F(x)",lwd=3,col="black",xlab="x",main="Cumulative Distribution Function (CDF)",las=1)
      segments(x0=input$percentil, y0=0, x1=input$percentil, y1=prob, lty="longdash",lwd=2, col="#A4BF41")
      segments(x0=0, y0=prob, x1=input$percentil, y1=prob, lty="longdash",lwd=2, col="#A4BF41")
      #axis(side=2, at=seq(0, 1, by=0.1))
      #axis(side=1, at=seq(0, 1, by=0.1))
      
    }
    
    else{
      par(mfrow=c(1,2))
      curve(dbeta(x,shape1=input$alpha,shape2 = input$beta),ylab="f(x)",lwd=3,col="black",xlab="x",main="Probability Density Function (PDF)",las=1)
      #axis(side=1, at=seq(0, 1, by=0.1))
      #crear percentil para el poligono
      percentil1 <- qbeta(input$probabilidad, shape1 = input$alpha, shape2 = input$beta)
      secuencia <- seq(0, percentil1, length.out=10000)
      cord.x <- c(0,secuencia, percentil1)
      cord.y <- c(0,dbeta(secuencia, shape1=input$alpha, shape2=input$beta), -100000)
      polygon(cord.x, cord.y, col="#8155FF")
      axis(side=1, labels=FALSE)
      #para crear los segmentos  (curva)
      prob <- pbeta(q=input$probabilidad,shape1=input$alpha,shape2 = input$beta)
      curve(pbeta(x,shape1=input$alpha,shape2 = input$beta),ylab="F(x)",lwd=3,col="black",xlab="x",main="Cumulative Distribution Function (CDF)",las=1)
      segments(x0=input$probabilidad, y0=0, x1=input$probabilidad, y1=prob, lty="longdash",lwd=2, col="#8155FF")
      segments(x0=0.0, y0=prob, x1=input$probabilidad, y1=prob, lty="longdash",lwd=2, col="#8155FF")
      #axis(side=2, at=seq(0, 1, by=0.1))
      #axis(side=1, at=seq(0, 1, by=0.1))
    }
    
  })
  
  output$datos <- renderTable({
    a<-input$alpha
    b<-input$beta
    Calculation <-c("Mean","Mode","Variance","Skewness","Ex.kurtosis")
    e<- a/(a+b)
    m<- (a-1)/(a+b-2)
    v<- a*b/((a+b)^2*(a+b+1))
    s<- (2*(b-a)*((a+b+1)^(1/2)))/((a+b+2)*((a*b)^(1/2)))
    k<- 6*((a-b)^2*(a+b+1)-(a*b)*(a+b+2))/((a*b)*(a+b+2)*(a+b+3))
    Result <- c(e,m,v,s,k)
    
    dj <- data.frame(Calculation,Result)
  })
  
  output$progressBox <- renderValueBox({
    if(input$numero=="Probability"){
      
      valueBox(
        paste0(round(pbeta(q=input$percentil,shape1=input$alpha,shape2 = input$beta)*100,4), "%"), "
Probability obtained with the percentile entered.", icon = icon("calculator"),
        color = "navy"
        
      )}
    
    else{
      valueBox(
        paste0(round(qbeta(p = input$probabilidad,shape1 = input$alpha, shape2 = input$beta),4)), "
Percentile obtained with the probability entered.", icon = icon("calculator"),
        color = "navy")
      
    }
    
  })
  
})

