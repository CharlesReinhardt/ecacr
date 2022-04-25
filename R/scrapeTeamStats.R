#' Scrape Team Summary Statistics
#'
#' Web scrape (using rvest) team summary statistics for the current ECAC season
#'
#' @param games collecting data for 'all' (default), 'conference', or 'nonconference' games. Currently no support for 'nonconference' games
#' @param gender 'women' (default) or 'men'
#'
#' @return data frame of summary team statistics
#' @export
#'
#' @examples
#' scrapeTeamStats()
#' scrapeTeamStats(games="conference", gender="men")
scrapeTeamStats <- function(games="all", gender="women") {

  # check if games argument is valid
  if (!gamesIsValid(games)) {
    stop("games argument must be 'all', 'conference', or 'nonconference'")
  }

  # throw an error
  if (!genderIsValid(gender)) {
    stop("gender argument must either be 'women' or 'men'")
  }

  url <- paste0("https://www.ecachockey.com/", gender, "/2021-22/teams?sort=name&r=0&pos=")
  tab <- rvest::read_html(url) %>% rvest::html_table()

  index <- 1

  if (games == "conference") {
    index <- index + 1
  }

  data <- tab[[index]]

  data_renamed <- data %>%
    dplyr::rename(GamesPlayed = gp,
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
           ShortHandedGoalsAgainst = shga,
           GoalsAgainst = ga,
           GoalsAgainstAverage = gaa,
           Saves = sv,
           SavePercent = `sv%`,
           EmptyNetGoalsAgainst = en)

  return(data_renamed)
}
