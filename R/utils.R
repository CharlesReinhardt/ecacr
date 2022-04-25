#' Check Variable Name Validity
#'
#' Checks the validity of a given variable name for a certain type of ECAC hockey data
#'
#' @param variableName name of Variable to check
#' @param type type of variable to check ('team', 'skaters', 'goalies', or' game')
#'
#' @return TRUE if variableName is valid, FALSE otherwise
#'
#' @examples
#' varIsValid(variableName="Goals", type="skaters") # TRUE
#' varIsValid(varaibleName="Assists", type="goalies") # FALSE
varIsValid <- function(variableName, type) {
  if (!(type %in% c("team", "skaters", "goalies", "game"))) {
    stop("type argument must be one of 'team', 'skaters', 'goalies', or 'game")
  }

  if (type == "team") {
    # checking team variables
    vars <- names(scrapeTeamStats())
  } else if (type == "game") {
    # checking game variable
    vars <- names(scrapeGameStatsByTeam(team="brown"))
  } else {
    # checking goalie or player variables
    vars <- names(scrapeIndivStatsByTeam(team="brown", players=type))
  }

  variableName %in% vars
}

#' Check Team Name Validity
#'
#' Checks that a provided team name
#'
#' @param team team name to check
#'
#' @return TRUE if team is in ECAC and formatted correctly, FALSE otherwise
#'
#' @examples
#' teamIsValid(team="rensselaer") # TRUE
#' teamIsValid(team="RIT") # FALSE
teamIsValid <- function(team) {

  validTeams <- c("brown", "clarkson", "colgate", "cornell", "dartmouth", "harvard",
                  "princeton", "quinnipiac", "rensselaer", "stlawrence", "union", "yale")

  res <- team %in% validTeams

  res
}

#' List of Valid Teams
#'
#' Return a list of valid team names for ecacr package
#'
#' @return a list
#' @export
#'
#' @examples
#' listValidTeams()
listValidTeams <- function() {
  validTeams <- c("brown", "clarkson", "colgate", "cornell", "dartmouth", "harvard",
                  "princeton", "quinnipiac", "rensselaer", "stlawrence", "union", "yale")

  validTeams
}

#' Checks Gender Formatting
#'
#' Checks that the gender argument provided is formatted correctly for ecacr processing
#'
#' @param gender gender to check
#'
#' @return TRUE if gender is formatted correctly, FALSE otherwise
#'
#' @examples
#' genderIsValid(gender="women") # TRUE
#' genderIsValid(gender="WOMEN") # FALSE
#' genderIsValid(gender="W") # FALSE
genderIsValid <- function(gender) {

  validGenders <- c("women", "men")

  res <- gender %in% validGenders

  res
}

#' Check Games Argument Validity
#'
#' Check that games argument is valid value for ecacr use
#'
#' @param games argument to check
#'
#' @return TRUE if valid, FALSE otherwise
#'
#' @examples
#' gamesIsValid("all") # TRUE
#' gamesIsValid("foobar") # FALSE
gamesIsValid <- function(games) {
  vals <- c("all", "conference", "nonconference")

  # throw warning about nonconference argument
  if (games == "nonconference") {
    message("nonconference games only not supported, treating games argument as 'all'")
  }

  res <- games %in% vals

  res
}

#' Check Players Argument Validity
#'
#' Checks the validity of provided players argument
#'
#' @param players argument to check
#'
#' @return TRUE if valid argument, FALSE otherwise
#'
#' @examples
#' playersIsValid(players="goalies") # TRUE
#' playersIsValid(players="Skate") # FALSE
playersIsValid <- function(players) {
  vals <- c("goalies", "skaters")

  res <- players %in% vals

  res
}
