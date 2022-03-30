#' Title Case a String (single word)
#'
#' @param string a single word
#'
#' @return the given string in title case
#'
#' @examples
#' titleCase("foo") gives "Foo"
#' titleCase("sTRinG") gives "String"
titleCase <- function(string) {
  titleString <- paste0(toupper(substr(string, 1, 1)), tolower(substr(string, 2, nchar(string))))
  titleString
}

#' Check Variable Name Validity
#'
#' @param variableName name of Variable to check
#'
#' @return TRUE if variableName is valid, FALSE otherwise
#'
#' @examples
#' varIsValid("Goals") returns TRUE,
#' varIsValid("notValid") returns FALSE
varIsValid <- function(variableName) {
  vars <- names(scrapeTeamStats())
  variableName %in% vars
}
