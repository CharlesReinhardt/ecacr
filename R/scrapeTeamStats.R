#' Scrape Team Statistics
#'
#' @return returns a either women's or men's team statistics data. Returns women's data by default.
#' @export
#'
#' @examples
#' scrapeTeamStats()
#' scrapeTeamStats(gender="women")
#' scrapeTeamStats(gender="men")
scrapeTeamStats <- function(conf=FALSE, gender="women") {

  # throw an error
  if (!genderIsValid(gender)) {
    stop("gender argument must either be 'women' or 'men'")
  }

  url <- paste0("https://www.ecachockey.com/", gender, "/2021-22/teams?sort=name&r=0&pos=")
  tab <- rvest::read_html(url) %>% rvest::html_table()

  index <- 1

  if (conf) {
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
