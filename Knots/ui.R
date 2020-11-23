library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Fitting Linear Model with Knots"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("nknots",
                        "Number of knots:",
                        min = 1,
                        max = 30,
                        value = 2),
            numericInput("seed", "Set the seed for the random numbers generation", 
                         value = 6385, min = 1, max = 10000, step = 1),
            checkboxInput("predict", "Show/Hide Prediction Interval", value = TRUE),
            checkboxInput("quad", "Add Quadratic terms", value = TRUE),
            checkboxInput("RMSE", "Show/Hide RSME Value", value = TRUE),
            h4("RSME:",textOutput('rsme'))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = 'tabs',
                        tabPanel(title = "Plot",plotOutput("distPlot")),
                        tabPanel(title = "Documentation",
                                 h4('Objective'),
                                 p("The objective of this app is show the effect 
                                   of applying a different number of knots in a linear model."),
                                 h4("Usage"),
                                 p("The app generates random data points following a sine pattern, and adjusts a linear model
                                   using the number of knots defined by the user. To use the app, follow these indications:"),
                                 tags$ul(
                                     tags$li("Select the number of knots with the slider"),
                                     tags$li("Select the random seed for the generation of random points"),
                                     tags$li("Show/Hide Prediction Interval: Checkbox to control the display of prediction intervals for the fitted model"),
                                     tags$li("Add Quadratic terms: checkbox to control if the model includes quadratic terms in the fitting (x^2)"),
                                     tags$li("Show/Hide RSME Value: Checkbox to to display the Root Squared Mean Error of the fitted model")),
                                 h4("Source Code"),
                                 tagList(a("github/gnelis", href="https://github.com/gnelis/DataProducts_FinalAssignment"))
                                 )
                                 )
                        
                        )


        )
    )
)
