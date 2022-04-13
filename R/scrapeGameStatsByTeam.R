#' Scrape Game by Game stats by team
#'
#' @param team chosen team to scrape
#' @param gender gender of data to scrape
#'
#' @return a dataframe of ecac data for a given team and gender
#' @export
#'
#' @import stringr
#'
#' @examples
scrapeGameStatsByTeam <- function(team, gender="women") {

  # TODO test this

  # check valid team
  validTeams <- c("brown", "clarkson", "colgate", "cornell", "dartmouth", "harvard",
                  "princeton", "quinnipiac", "rensselaer", "stlawrence", "union", "yale")
  if (!(team %in% validTeams)) {
    stop("not a valid team name")
  }

  # check gender
  validGenders <- c("women", "men")
  if(!(gender %in% validGenders)) {
    stop("not a valid gender argument")
  }

  url <- paste0("https://www.ecachockey.com/", gender, "/2021-22/teams/", team)
  tab <- rvest::read_html(url) %>% rvest::html_table()

  dataAttend <- tab[[14]] %>%
    dplyr::mutate(Team = str_to_title(team),
           Home = !str_detect(Opponent, "(at|vs.)\\r"),
           Opponent = str_trim(str_replace(Opponent, "(at|vs.)\\r\n", "")),
           Won = str_detect(Score, "W"),
           Loss = str_detect(Score, "L"),
           Tie = str_detect(Score, "T")) %>%
    dplyr::select(-Score)


  dataGame <- tab[[12]] %>%
    dplyr::mutate(Team = team,
           Home = !str_detect(Opponent, "(at|vs.) "),
           Opponent = str_trim(str_replace(Opponent, "(at|vs.) ", "")),
           Won = str_detect(Score, "W"),
           Loss = str_detect(Score, "L"),
           Tie = str_detect(Score, "T")) %>%
    dplyr::select(-Score) %>%
    dplyr::relocate(Team, .after=Date) %>%
    dplyr::relocate(Home, Won, Loss, Tie, .after=Opponent)

  dataFull <- dplyr::left_join(dataGame, dataAttend, by = c("Date", "Team", "Opponent",
                                                     "Home", "Won", "Loss", "Tie")) %>%
    dplyr::rename("Goals" = g,
           "Assists" = a,
           "Shots" = s,
           "PenaltyMinutes" = pim,
           "PowerPlayGoals" = ppg,
           "PowerPlayOpportunities" = ppo,
           "PowerPlayPercent" = `pp%`,
           "PowerPlayGoalsAgainst" = ppga,
           "TimesShortHanded" = tsh,
           "PenaltyKillPercent" = `pk%`,
           "ShortHandedGoals" = shg,
           "ShortHandedGoalsAgainst" = shga,
           "GoalsAgainst" = ga,
           "GoalsAgainstAverage" = gaa,
           "Saves" = sv,
           "SavePercent" = `sv%`,
           "EmptyNetGoalsAgainst" = en)

  dataFull
}
