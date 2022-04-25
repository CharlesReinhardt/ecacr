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
#'
#' @examples
#' histogram(var="Saves")
#' histogram(var="Goals", games="conference", players="skaters", gender="men")
histogram <- function(var, games="all", players="goalies", gender="women") {

  # check valid variable name
  if (!varIsValid(var, type="individual")) {
    stop(paste0(var, " not a valid variable name"))
  }

  data <- scrapeIndivStats(conf=conf, skaters=skaters, gender=gender)
  title <- paste0(var, " in ", titleCase(gender), "'s ECAC")

  if (games == "conference") {
    title <- paste0(title, " (Conference Only)")
  }

  ggplot(data = data, aes_string(x = var)) +
    geom_histogram() +
    labs(x = var, y = "Number of Players", title = title)
}
