#' Scrape Game Statistics for one season (of one team) of ECAC hockey games
#'
#' Webscrape (using rvest) skater and goalie statistics for one team's games this season
#'
#' @param team ECAC team to scrape data for
#' @param gender 'women' (default) or 'men'
#'
#' @return dataframe of game statistics
#' @export
#'
#' @import stringr
#'
#' @examples
#' scrapeGameStatsByTeam(team="brown")
#' scrapeGameStatsByTeam(team="stlawrence", gender="men", verbose=FALSE)
scrapeGameStatsByTeam <- function(team, gender="women") {

  season <- "2021-22"

  # check valid team
  if (!teamIsValid(team)) {
    stop("not a valid team name")
  }

  # check gender
  if (!genderIsValid(gender)) {
    stop("not a valid gender argument")
  }

  url <- paste0("https://www.ecachockey.com/", gender, "/2021-22/teams/", team)
  tab <- rvest::read_html(url) %>% rvest::html_table(na.strings="-")

  year1 <- str_split(season, "-")[[1]][1]
  year2 <- paste0("20", str_split(season, "-")[[1]][2])

  dataAttend <- tab[[14]] %>%
    dplyr::mutate(
            Date = paste0(Date, " ", dplyr::if_else( str_detect(Date, "Oct|Nov|Dec"), true=year1, false=year2 )),
            Team = str_to_title(team),
            Home = !str_detect(Opponent, "(at|vs.)\\r"),
            Opponent = str_trim(str_replace(Opponent, "(at|vs.)\\r\n", "")),
            Won = str_detect(Score, "W"),
            Loss = str_detect(Score, "L"),
            Tie = str_detect(Score, "T")) %>%
    dplyr::select(-Score)

  dataGame <- tab[[12]] %>%
    dplyr::mutate(
            Date = paste0(Date, " ", dplyr::if_else( str_detect(Date, "Sep|Oct|Nov|Dec"), true=year1, false=year2 )),
            Team = str_to_title(team),
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
    dplyr::mutate(Date = lubridate::mdy(Date)) %>%
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
