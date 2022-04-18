#' Scrape Individual Player Statistics (all ECAC Teams, one gender)
#'
#' @param conf TRUE for ecac data only, FALSE for conference and non-conference
#' @param skaters TRUE for skater data, FALSE for goalie data
#' @param gender "women" for women's data, "men" for men's data
#' @param verbose TRUE for extra output during runtime, FALSE for no extra output
#'
#' @return data frame of individual player statistics for all ECAC teams
#' @export
#'
#' @examples
scrapeIndivStats <- function(conf=FALSE, skaters=FALSE, gender="women", verbose=TRUE) {

  # check valid conf argument
  if (typeof(conf) != "logical") {
    stop("conf argument must either be TRUE or FALSE")
  }

  # check valid skaters argument
  if (typeof(skaters) != "logical") {
    stop("skaters argument must either be TRUE or FALSE")
  }

  teamNames <- c("brown", "clarkson", "colgate", "cornell", "dartmouth", "harvard",
                 "princeton", "quinnipiac", "rensselaer", "stlawrence", "union", "yale")
  dataFrames <- c()

  data <- data.frame()

  # fill dataFrames with each team's data
  for (i in 1:length(teamNames)) {
    team <- teamNames[i]
    if (verbose) {
      message(paste0("scraping data from ", str_to_title(team)))
    }
    newTeamData <- scrapeIndivStatsByTeam(team, conf=conf, skaters=skaters, gender=gender) %>%
      dplyr::mutate(Team = team)
    data <- dplyr::bind_rows(data, newTeamData)
  }

  data
}
