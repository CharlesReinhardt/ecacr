#' Scrape Individual Player Statistics
#'
#' Webscrape (using rvest) all individual player statistics for the current season
#'
#' @param gender 'women' (default) or 'men'
#' @param verbose TRUE (default) for intermediate data scraping output messages, FALSE for no additional output
#' @param games collecting data for 'all' (default), 'conference', or 'nonconference' games. Currently no support for 'nonconference' games
#' @param players type of players stats to collect, 'goalies' (default) or 'skaters'
#'
#' @return data frame of individual player statistics for all ECAC teams
#' @export
#'
#' @examples
#' scrapeIndivStats(verbose=FALSE)
#' scrapeIndivStats(games="conference", players="skaters", gender="men", verbose=FALSE)
scrapeIndivStats <- function(games="all", players="goalies", gender="women", verbose=TRUE) {

  # check valid games argument
  if (!gamesIsValid(games)) {
    stop("games argument must be 'all', 'conference', or 'nonconference'")
  }

  # check valid players argument
  if (!playersIsValid(players)) {
    stop("players argument must be 'goalies' or 'skaters'")
  }

  teamNames <- c("brown", "clarkson", "colgate", "cornell", "dartmouth", "harvard",
                 "princeton", "quinnipiac", "rensselaer", "stlawrence", "union", "yale")

  data <- data.frame()

  # fill data with each team's data
  for (i in 1:length(teamNames)) {
    team <- teamNames[i]
    if (verbose) {
      message(paste0("scraping data from ", str_to_title(team)))
    }
    newTeamData <- scrapeIndivStatsByTeam(team, games=games, players=players, gender=gender) %>%
      dplyr::mutate(Team = team)
    data <- dplyr::bind_rows(data, newTeamData)
  }

  data
}
