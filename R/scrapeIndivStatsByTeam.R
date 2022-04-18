#' Scrape Individual Statistics (for one ECAC team)
#'
#' @param team team of choice
#' @param conf TRUE for ecac data only, FALSE for conference and non-conference
#' @param skaters TRUE for skater data, FALSE for goalie data
#' @param gender "women" for women's data, "men" for men's data
#'
#' @return data frame of individual statistics of given parameters
#' @export
#'
#' @examples
scrapeIndivStatsByTeam <- function(team, conf=FALSE, skaters=FALSE, gender="women") {

  # TODO how to test this

  # check valid team
  if (!teamIsValid(team)) {
    stop("not a valid team name")
  }

  # check valid conf argument
  if (typeof(conf) != "logical") {
    stop("conf argument must either be TRUE or FALSE")
  }

  # check valid skaters argument
  if (typeof(skaters) != "logical") {
    stop("skaters argument must either be TRUE or FALSE")
  }

  # check valid gender
  if (!genderIsValid(gender)) {
    stop("gender argument must either be 'women' or 'men'")
  }

  url <- paste0("https://www.ecachockey.com/", gender, "/2021-22/teams/", team)
  tab <- rvest::read_html(url) %>% rvest::html_table(na.strings="-")

  index <- 0

  if (conf) {
    index <- index + 4
  }

  if (skaters) {
    index <- index + 5
    data <- tab[[index]] %>% dplyr::filter(!is.na(No.))
    dataRenamed <- data %>%
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
