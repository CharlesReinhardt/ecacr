#' Check Variable Name Validity
#'
#' @param variableName name of Variable to check
#' @param team TRUE if checking team variable names, FALSE otherwise
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

#' Check that a team name is valid
#'
#' @param team team name to check
#'
#' @return TRUE if team is in ECAC and formatted correctly, FALSE otherwise
#' @export
#'
#' @examples
teamIsValid <- function(team) {

  validTeams <- c("brown", "clarkson", "colgate", "cornell", "dartmouth", "harvard",
                  "princeton", "quinnipiac", "rensselaer", "stlawrence", "union", "yale")

  res <- team %in% validTeams

  res
}

#' Checks gender is formatted correctly
#'
#' @param gender gender to check
#'
#' @return TRUE if gender is formatted correctly, FALSE otherwise
#' @export
#'
#' @examples
genderIsValid <- function(gender) {

  validGenders <- c("women", "men")

  res <- gender %in% validGenders

  res
}
