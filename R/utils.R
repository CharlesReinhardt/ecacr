#' Check Variable Name Validity
#'
#' @param variableName name of Variable to check
#' @param type must be one of 'team', 'skater', 'goalie', 'game'
#'
#' @return TRUE if variableName is valid, FALSE otherwise
#'
#' @examples
varIsValid <- function(variableName, type) {
  if (!(type %in% c("team", "skater", "goalie", "game"))) {
    stop("variable type must be one of 'team', 'skater', 'goalie', or 'game")
  }

  if (type == "team") {
    # checking team variables
    vars <- names(scrapeTeamStats())
  } else if (type == "skater") {
    # checking skater variable names
    vars <- names(scrapeIndivStatsByTeam(team="brown", skaters=TRUE))
  } else if (type == "goalie") {
    # checking goalie variable names
    vars <- names(scrapeIndivStatsByTeam(team="brown", skaters=FALSE))
  } else {
    vars <- names(scrapeGameStatsByTeam(team="brown"))
  }

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
