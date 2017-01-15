library(shiny)
library(ggplot2)
library(scales)
source("Model.R")

# Setting up the client (page elements appear in order specified)
ui <- fluidPage(
  titlePanel("System Dynamics Modeling: The SIR Model"),
  a("See supporting resources on GitHub", href="https://github.com/JimDuggan/SDMR",target="_blank"),
  br(),br(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("cr", "Contact Rate", min=0, max=10, value=5, step=1),
      sliderInput("inf", "Infectivity", min=0, max=1, value=0.5, step=0.05),
      sliderInput("rd",  "Recovery Delay", min=1, max=5, value=2, step=1)
    ),
    mainPanel(
      plotOutput("plot")
      )
  )
)

# The Server Function
server <- function(input, output) {
  output$plot <- renderPlot({
    cat(file=stderr(), "Function output$plot::renderPlot...\n")
    START<-0; FINISH<-20; STEP<-0.125
    simtime <- seq(START, FINISH, by=STEP)
    stocks  <- c(sSusceptible=99999,sInfected=1,sRecovered=0)
    auxs    <- c(aTotalPopulation=100000, 
                 aContactRate=as.numeric(input$cr), 
                 aInfectivity=as.numeric(input$inf),
                 aDelay=as.numeric(input$rd))

    o<-data.frame(ode(y=stocks, times=simtime, func = model, 
                       parms=auxs, method="euler"))
    ggplot()+
      geom_line(data=o,aes(time,o$sSusceptible,color="1. Susceptible"))+
      geom_line(data=o,aes(time,o$sInfected,color="2. Infected"))+
      geom_line(data=o,aes(time,o$sRecovered,color="3. Recovered"))+
      scale_y_continuous(labels = comma)+
      ylab("System Stocks")+
      xlab("Day") +
      labs(color="")+
      theme(legend.position="bottom")
  })
}

# Launch the app
shinyApp(ui, server)

