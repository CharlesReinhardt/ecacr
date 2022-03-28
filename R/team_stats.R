#' Scrape Team Statistics
#'
#' @return returns a list of women's and men's ecac team data
#' @export
#'
#' @examples
#' team_stats() gives women's team data by default
#' team_stats(gender="women") gives women's team data
#' team_stats(gender="men") gives men's team data
team_stats <- function(gender="women") {
  # TODO deal with errors
  # TODO implement testthat tests for this function (test col dimensions and col names)
  url <- paste0("https://www.ecachockey.com/", gender, "/2021-22/teams?sort=name&r=0&pos=")
  tab <- read_html(url) %>% html_table()
  data <- tab[[1]]

  data_renamed <- data %>%
    rename(GamesPlayed = gp,
           Goals = g,
           Assists = a,
           GoalsPerGame = gpg,
           Shots = s,
           PenaltyMinutes = pim,
           PowerPlayGoals = ppg,
           PowerPlayOpportunities = ppo,
           PowerPlayPercent = `pp%`,
           PowerPlayGoalsAgainst = ppga,
           TimesShortHanded = tsh,
           PenaltyKillPercent = `pk%`,
           ShortHandedGoals = shg,
           GoalsAgainst = ga,
           GoalsAgainstAverage = gaa,
           Saves = sv,
           SavePercent = `sv%`,
           EmptyNetGoalsAgainst = en)

  return(data_renamed)
}
