#' Scrape Individual Player Statistics For One Team
#'
#' Webscrape (using rvest) all individual player statistics of a given team for the current season
#'
#' @param gender 'women' (default) or 'men'
#' @param games collecting data for 'all' (default), 'conference', or 'nonconference' games. Currently no support for 'nonconference' games
#' @param players type of players stats to collect, 'goalies' (default) or 'skaters'
#' @param team ECAC team to scrape data for
#'
#' @return data frame of individual player statistics for one ECAC team
#' @export
#'
#' @examples
#' scrapeIndivStatsByTeam(team="brown")
#' scrapeIndivStatsByTeam(team="clarkson", games="conference", players="skaters", gender="men")
scrapeIndivStatsByTeam <- function(team, games="all", players="goalies", gender="women") {


  # check valid team
  if (!teamIsValid(team)) {
    stop("not a valid team name")
  }

  # check valid games argument
  if (!gamesIsValid(games)) {
    stop("games argument must be 'all', 'conference', or 'nonconference'")
  }

  if (!playersIsValid(players)) {
    stop("players argument must be 'goalies' or 'skaters'")
  }

  # check valid gender
  if (!genderIsValid(gender)) {
    stop("gender argument must either be 'women' or 'men'")
  }

  url <- paste0("https://www.ecachockey.com/", gender, "/2021-22/teams/", team)
  tab <- rvest::read_html(url) %>% rvest::html_table(na.strings="-")

  index <- 0

  if (games == "conference") {
    index <- index + 4
  }

  if (players == "skaters") {
    index <- index + 5
    data <- tab[[index]] %>% dplyr::filter(!is.na(No.))
    dataRenamed <- data %>%
      dplyr::filter(Pos != "G") %>%
      dplyr::rename(Year = Yr,
                    Position = Pos,
                    GamesPlayed = gp,
                    Goals = g,
                    Assists = a,
                    Points = pts,
                    PenaltyMinutes = pim,
                    PlusMinus = `+/-`,
                    PowerPlayGoals = ppg,
                    ShortHandedGoals = shg,
                    EmptyNetGoals = eng,
                    GameWinningGoals = gwg,
                    GameTyingGoals = gtg,
                    HatTricks = hat,
                    Shots = s)
  } else {
    # goalies
    index <- index + 7
    data <- tab[[index]] %>% dplyr::filter(!is.na(No.))

    dataRenamed <- data %>%
      dplyr::rename(Year = Yr,
                    Position = Pos,
                    GamesPlayed = gp,
                    GamesStarted = gs,
                    Minutes = min,
                    GoalsAgainst = ga,
                    GoalsAgainstAverage = gaa,
                    Saves = sv,
                    SavePercentage = `sv%`,
                    Wins = w,
                    Losses = l,
                    Ties = t,
                    WinPercentage = `win %`)
  }

  dataRenamed
}
