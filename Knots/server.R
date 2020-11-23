
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({
        
        set.seed(input$seed)
        n <- 500; x <- seq(0, 4 * pi, length = n); y <- sin(x) + rnorm(n, sd = .3)
        knots <- seq(0, 8 * pi, length = input$nknots)
        splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
        xMat <- cbind(1, x, splineTerms)
        if(input$quad){
            splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot)^2)
            xMat <- cbind(1, x, x^2, splineTerms)
        }
        model <- lm(y ~ xMat)
        yhat <- predict( lm(y ~ xMat), interval = 'prediction')
        plot(x, y, frame = FALSE, pch = 21, bg = "lightblue", cex = 2)
        lines(x, yhat[,'fit'], col = "red", lwd = 2)
        if (input$predict){
            lines(x, yhat[,'upr'], col = "red", lty = 2)
            lines(x, yhat[,'lwr'], col = "red", lty = 2)}
        if(input$RMSE){
            rsme_val<-sqrt(mean(model$residuals^2))
        }
        else {rsme_val<-"Click checkbox to show"}
        
        output$rsme <-renderText(rsme_val)
    })
    
})
