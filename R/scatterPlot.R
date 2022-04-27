#' Produce a ggplot2 Scatter Plot
#'
#' Create a ggplot2 scatter plot object of summary team statistics. Can display a trend line
#' if desired.
#'
#' @param x x-axis variable
#' @param y y-axis variable
#' @param trend TRUE (default) for smoothing trend line, FALSE for no trend line
#' @param gender 'women' (default) or 'men'
#' @param games graphing 'all' (default), 'conference', or 'nonconference' games. Currently no support for 'nonconference' games
#'
#' @return a ggplot2 scatter plot object
#' @export
#' @import ggplot2
#'
#' @examples
#' scatterPlot(x="Assists", y="PenaltyMinutes")
#' scatterPlot(x="Goals", y="Assists", games="conference", gender="men", trend=TRUE)
scatterPlot <- function(x, y, games="all", gender="women", trend=FALSE) {

  # check for invalid variable names
  if (!varIsValid(x, type="team")) {
    stop(paste0(x, " not a valid variable name for team data"))
  }

  if (!varIsValid(y, type="team")) {
    stop(paste0(y, " not a valid variable name"))
  }

  data <- scrapeTeamStats(games=games, gender=gender)
  title <- paste0(x, " vs. ", y, " in ", stringr::str_to_title(gender) , "'s ECAC")

  plot <- ggplot(data, aes(x = .data[[x]], y = .data[[y]], label = Name)) +
    geom_point() +
    labs(title = title)

  if (trend) {
    plot <- plot + geom_smooth(se=FALSE)
  }

  plot <- plotly::ggplotly(plot, tooltip="label")

  plot
}
