#' Scrape Individual Player Statistics (all ECAC Teams, one gender)
#'
#' @param conf TRUE for ecac data only, FALSE for conference and non-conference
#' @param skaters TRUE for skater data, FALSE for goalie data
#' @param gender "women" for women's data, "men" for men's data
#'
#' @return data frame of individual player statistics for all ECAC teams
#' @export
#'
#' @examples
scrapeIndivStats <- function(conf=FALSE, skaters=FALSE, gender="women") {

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
    newTeamData <- scrapeIndivStatsByTeam(teamNames[i], conf=conf, skaters=skaters, gender=gender) %>%
      dplyr::mutate(Team = teamNames[i])
    data <- dplyr::bind_rows(data, newTeamData)
  }

  data
}
