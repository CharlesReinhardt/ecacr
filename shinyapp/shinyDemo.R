library(shiny)

validTeamVars <- names(scrapeTeamStats())[3:21] %>% c(rep(NA, 19-length(.)))
validGameVars <- names(scrapeGameStatsByTeam(team="stlawrence"))[8:25] %>% c(rep(NA, 19-length(.)))
validGoalieVars <- names(scrapeIndivStatsByTeam(team="stlawrence"))[5:15] %>% c(rep(NA, 19-length(.)))
validSkaterVars <- names(scrapeIndivStatsByTeam(team="stlawrence", players="skaters"))[5:19] %>% c(rep(NA, 19-length(.)))

ui <- fluidPage(
  tabsetPanel(
    tabPanel("Team Visualizations",
            fluidPage(
              fluidRow(
                  column(width=4,
                         selectInput(inputId = "lolli_var",
                                    label="Choose a variable",
                                    choices=validTeamVars)),
                  column(width=4,
                         radioButtons(inputId="lolli_games",
                                      label="Game Type",
                                      choices=c("All", "Conference"))),
                  column(width=4,
                         radioButtons(inputId="lolli_gender",
                               label="Gender",
                               choices=c("Women","Men")))
                ),
              # fluidRow(
              #   includeMarkdown("lolli.md")
              # ),
              fluidRow(
                textOutput("lolli_call")
              ),
              fluidRow(
                plotOutput("scatterPlot")
              )
            )
    ),
    tabPanel("tab 2", "contents"),
    tabPanel("tab 3", "contents"))
)

server <- function(input, output, session) {

  # scatterReact <- eventReactive(input$runappbutton, {
  #   lolli_call()
  # })

  output$scatterPlot <- renderPlot({
    ecacr::lollipopChart(
      var=input$lolli_var,
      games=stringr::str_to_lower(input$lolli_games),
      gender=stringr::str_to_lower(input$lolli_gender)
      )
  })


  output$lolli_call <- renderText({
    msg <- paste0('lollipopChart(var="', input$lolli_var,
                    '" , gender="', stringr::str_to_lower(input$lolli_gender),
                    '" , games="', stringr::str_to_lower(input$lolli_games), '")')
    msg <- paste("Corresponding ecacr function", msg, sep=": ")
  })

  # lolli_call <- reactive({
  #   head <- "##### Corresponding `ecacr` function"
  #   msg <- paste0("`lollipopChart(var=", input$lolli_var,
  #          " , gender=", stringr::str_to_lower(input$lolli_gender),
  #          " , games=", stringr::str_to_lower(input$lolli_games), ")`")
  #   cat(paste(head, msg, sep="\n"), file="lolli.md", append=FALSE)
  # })
}

shinyApp(ui, server)
