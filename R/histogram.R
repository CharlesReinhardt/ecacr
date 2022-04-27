#' Produce a ggplot2 Histogram
#'
#' Create a ggplot2 histogram object displaying the distribution of a given statistic among
#' all ECAC players of a single gender (women or men)
#'
#' @param var variable to plot
#' @param gender 'women' (default) or 'men'
#' @param games graphing 'all' (default), 'conference', or 'nonconference' games. Currently no support for 'nonconference' games
#' @param players type of players stats to graph, 'goalies' (default) or 'skaters'
#'
#' @return a ggplot2 histogram object
#' @export
#' @import ggplot2
#'
#' @examples
#' histogram(var="Saves", verbose=FALSE)
#' histogram(var="Goals", games="conference", players="skaters", gender="men", verbose=FALSE)
histogram <- function(var, games="all", players="goalies", gender="women", verbose=TRUE) {

  # check valid variable name
  if (!varIsValid(var, type=players)) {
    stop(paste0(var, " not a valid variable name for ", players, " data"))
  }

  data <- scrapeIndivStats(games=games, players=players, gender=gender, verbose=verbose)
  title <- paste0(var, " in ", stringr::str_to_title(gender), "'s ECAC")

  if (games == "conference") {
    title <- paste0(title, " (Conference Only)")
  }

  ggplot(data = data, aes_string(x = var)) +
    geom_histogram() +
    labs(x = var, y = "Number of Players", title = title)
}
