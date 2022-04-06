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
scrapeIndivStats <- function(conf, skaters, gender="women") {

  # TODO deal with missing or incorrect params
  # http://adv-r.had.co.nz/Functions.html#function-arguments
  # https://stackoverflow.com/questions/28370249/correct-way-to-specifiy-optional-arguments-in-r-functions


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
