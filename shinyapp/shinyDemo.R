library(shiny)

validTeamVars <- names(scrapeTeamStats())[3:21] %>% c(rep(NA, 19-length(.)))
validGameVars <- names(scrapeGameStatsByTeam(team="stlawrence"))[8:25] %>% c(rep(NA, 19-length(.)))
validGoalieVars <- names(scrapeIndivStatsByTeam(team="stlawrence"))[5:15] %>% c(rep(NA, 19-length(.)))

validTeamNames <- listValidTeams()

ui <- fluidPage(
  tabsetPanel(
    tabPanel("Team Visualizations",
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
        plotOutput("lollipopChart")
      ),
      fluidRow(
        column(width=3,
               selectInput(inputId="scatter_x",
                           label="Choose an X Variable",
                           choices=validTeamVars)),
        column(width=3,
                selectInput(inputId="scatter_y",
                            label="Choose a Y variable",
                            choices=validTeamVars)),
        column(width=3,
               radioButtons(inputId="scatter_games",
                            label="Game Type",
                            choices=c("All", "Conference"))),
        column(width=3,
               radioButtons(inputId="scatter_gender",
                            label="Gender",
                            choices=c("Women","Men"))),
        column(width=3,
               checkboxInput(inputId="scatter_trend",
                             label="Display Trend Line",
                             value=FALSE))
      ),
      fluidRow(
        textOutput("scatter_call")
      ),
      fluidRow(
        plotOutput("scatterPlot")
      ),
    ),
    tabPanel("Game Visualizations",
      fluidRow(
        column(width=4,
               selectInput(inputId="winloss_team",
                          label="Choose a Team",
                          choices=validTeamNames)),
        column(width=4,
               radioButtons(inputId="winloss_gender",
                            label="Choose a gender",
                            choices=c("Women", "Men"))),
        column(width=4,
               checkboxInput(inputId="winloss_byLoc",
                             label="Facet by Home/Away",
                             value=FALSE))
      ),
      fluidRow(
        textOutput("winloss_call")
      ),
      fluidRow(
        plotOutput("winlossChart")
      ),
      fluidRow(
        column(width=4,
              selectInput(inputId="boxplot_var",
                           label="Choose a Variable",
                           choices=validGameVars)),
        column(width=4,
              radioButtons(inputId="boxplot_gender",
                           label="Choose a Gender",
                           choices=c("Women", "Men")))
      ),
      fluidRow(
        textOutput("boxplot_call")
      ),
      fluidRow(
        plotOutput("boxplot")
      )
    ),
    tabPanel("Individual Visualizations",
       fluidRow(
          column(width=3,
            selectInput(inputId="leaders_var",
                        label="Choose a variable",
                        choices=validGoalieVars)),
          column(width=2,
            radioButtons(inputId="leaders_games",
                         label="Game Type",
                         choices=c("All", "Conference"))),
          column(width=2,
            radioButtons(inputId="leaders_players",
                         label="Player Type",
                         choices=c("Goalies", "Skaters"))),
          column(width=2,
            radioButtons(inputId="leaders_gender",
                         label="Choose a Gender",
                         choices=c("Women", "Men"))),
          column(width=3,
            sliderInput(inputId="leaders_n",
                        label="Number of Leaders",
                        min=2, max=20, value=10))
       ),
       fluidRow(
         textOutput("leaders_call")
       ),
       fluidRow(
         plotOutput("overallLeaders")
       ),
       fluidRow(
         column(width=3,
            selectInput(inputId="hist_var",
                        label="Choose a Variable",
                        choices=validGoalieVars)),
         column(width=3,
            radioButtons(inputId="hist_games",
                         label="Game Type",
                         choices=c("All", "Conference"))),
         column(width=3,
            radioButtons(inputId="hist_players",
                        label="Player Type",
                        choices=c("Goalies", "Skaters"))),
         column(width=3,
            radioButtons(inputId="hist_gender",
                        label="Choose a Gender",
                        choices=c("Women", "Men")))
       ),
       fluidRow(
         textOutput("hist_call")
       ),
       fluidRow(
         plotOutput("histogram")
       )
    )
  )
)

server <- function(input, output, session) {

  # scatterReact <- eventReactive(input$runappbutton, {
  #   lolli_call()
  # })

  output$lollipopChart <- renderPlot({
    ecacr::lollipopChart(
      var=input$lolli_var,
      games=stringr::str_to_lower(input$lolli_games),
      gender=stringr::str_to_lower(input$lolli_gender)
      )
  })

  output$scatterPlot <- renderPlot({
    ecacr::scatterPlot(
      x=input$scatter_x,
      y=input$scatter_y,
      games=stringr::str_to_lower(input$scatter_games),
      gender=stringr::str_to_lower(input$scatter_gender),
      trend=input$scatter_trend,
      dynamic=FALSE
    )
  })

  output$lolli_call <- renderText({
    msg <- paste0('lollipopChart(var="', input$lolli_var,
                    '", gender="', stringr::str_to_lower(input$lolli_gender),
                    '", games="', stringr::str_to_lower(input$lolli_games), '")')
    msg
  })

  output$scatter_call <- renderText({
    msg <- paste0('scatterplot(x="', input$scatter_x,
                  '", y="', input$scatter_y,
                  '", gender="', stringr::str_to_lower(input$scatter_gender),
                  '", games="', stringr::str_to_lower(input$scatter_games), '")')
    msg
  })

  output$winlossChart <- renderPlot({
    ecacr::winLossChart(
      team=input$winloss_team,
      gender=stringr::str_to_lower(input$winloss_gender),
      byLocation=input$winloss_byLoc)
  })

  output$boxplot <- renderPlot({
    ecacr::boxplot(
      var=input$boxplot_var,
      gender=stringr::str_to_lower(input$boxplot_gender),
      verbose=FALSE)
  })

  output$winloss_call <- renderText({
    msg <- paste0('winLossChart(team="', input$winloss_team,
                  '", gender="', input$winloss_gender,
                  '", byLocation="', input$winloss_byLoc, '")')
    msg
  })

  output$boxplot_call <- renderText({
    msg <- paste0('boxplot(var="', input$boxplot_var,
                  '", gender="', stringr::str_to_lower(input$boxplot_gender),
                  '")')
    msg
  })

  # Individual Visualizations

  output$overallLeaders <- renderPlot({
    ecacr::overallLeaders(
      var=input$leaders_var,
      n_leaders=input$leaders_n,
      games=stringr::str_to_lower(input$leaders_games),
      players=stringr::str_to_lower(input$leaders_players),
      gender=stringr::str_to_lower(input$leaders_gender),
      verbose=FALSE)
  })

  output$histogram <- renderPlot({
    ecacr::histogram(
      var=input$hist_var,
      games=stringr::str_to_lower(input$hist_games),
      players=stringr::str_to_lower(input$hist_players),
      gender=stringr::str_to_lower(input$hist_gender),
      verbose=FALSE)
  })

  output$leaders_call <- renderText({
    msg <- paste0('overallLeaders(var="', input$leaders_var,
           '", n_leaders=,', input$leaders_n,
           ', games="', stringr::str_to_lower(input$leaders_games),
           '", players="', stringr::str_to_lower(input$leaders_players),
           '", gender="', stringr::str_to_lower(input$leaders_gender), '")')
    msg
  })

  output$hist_call <- renderText({
    msg <- paste0('histogram(var="', input$hist_var,
                  '", games="', stringr::str_to_lower(input$hist_games),
                  '", players="', stringr::str_to_lower(input$hist_players),
                  '", gender="', stringr::str_to_lower(input$hist_gender), '")')
    msg
  })

  validIndivVarLeaders <- reactive({
    validSkaterVars <- names(scrapeIndivStatsByTeam(team="stlawrence", players="skaters"))[5:19] %>% c(rep(NA, 19-length(.)))

    if (input$leaders_players == "Goalies") {
      validGoalieVars
    } else {
      validSkaterVars
    }

  })

  validIndivVarHist<- reactive({
    validSkaterVars <- names(scrapeIndivStatsByTeam(team="stlawrence", players="skaters"))[5:19] %>% c(rep(NA, 19-length(.)))

    if (input$hist_players == "Goalies") {
      validGoalieVars
    } else {
      validSkaterVars
    }

  })

  observe({
    updateSelectInput(session,inputId="leaders_var", label="Choose a Variable", choices=validIndivVarLeaders())
    updateSelectInput(session,inputId="hist_var", label="Choose a Variable", choices=validIndivVarHist())
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
