#' Title Case a String (single word)
#'
#' @param string a single word
#'
#' @return the given string in title case
#'
#' @examples
#' titleCase("foo")
#' titleCase("sTRinG")
titleCase <- function(string) {
  titleString <- paste0(toupper(substr(string, 1, 1)), tolower(substr(string, 2, nchar(string))))
  titleString
}

#' Check Team Variable Name Validity
#'
#' @param variableName name of Variable to check
#' @param team TRUE if checking team variable name, FALSE otherwise
#' @param skaters TRUE if checking skater variable name, FALSE if checking goalie variable names, NULL otherwise
#'
#' @return TRUE if variableName is valid, FALSE otherwise
#'
#' @examples
varIsValid <- function(variableName, team, skaters=NULL) {
  if (team) {
    # checking team variables
    vars <- names(scrapeTeamStats())
  } else {
    if (skaters) {
      # checking skater variable names
      vars <- names(scrapeIndivStatsByTeam(team="brown", skaters=TRUE))
    } else {
      # checking goalie variable names
      vars <- names(scrapeIndivStatsByTeam(team="brown", skaters=FALSE))
    }
  }
  vars <- names(scrapeTeamStats())
  variableName %in% vars
}
