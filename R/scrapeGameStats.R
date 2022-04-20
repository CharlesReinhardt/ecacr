#' Scrape data for all ECAC games
#'
#' @param gender the given gender to scrape games for
#' @param verbose TRUE for additional output, FALSE for no additional output
#'
#' @return
#' @export
#'
#' @examples
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
