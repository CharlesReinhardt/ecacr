#' Scrape Game Statistics for one season of ECAC hockey games
#'
#' Webscrape (using rvest) skater and goalie statistics for all ECAC games this season
#'
#' @param gender 'women' (default) or 'men'
#' @param verbose TRUE (default) for intermediate data scraping output messages, FALSE for no additional output
#'
#' @return dataframe of game statistics
#' @export
#'
#' @examples
#' scrapeGameStats()
#' scrapeGameStats(gender="men", verbose=FALSE)
scrapeGameStats <- function(gender="women", verbose=TRUE) {
  teamNames <- c("brown", "clarkson", "colgate", "cornell", "dartmouth", "harvard",
                 "princeton", "quinnipiac", "rensselaer", "stlawrence", "union", "yale")

  data <- data.frame()

  # fill data with each team's data
  for (i in 1:length(teamNames)) {
    team <- teamNames[i]
    if (verbose) {
      message(paste0("scraping data from ", stringr::str_to_title(team)))
    }
    newTeamData <- scrapeGameStatsByTeam(team, gender=gender) %>%
      dplyr::mutate(Team = team)
    data <- dplyr::bind_rows(data, newTeamData)
  }

  data
}
