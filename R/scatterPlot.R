#' Scatter Plot of Two Variables
#'
#' @param x variable on the x-axis of the scatterplot
#' @param y variable on the y-axis of the scatterplot
#' @param trend TRUE/FALSE, whether to display a smoothing trend line to the scatter plot
#' @param gender gender of data to graph, default to "women"
#'
#' @return a scatter plot of the two given variables
#' @export
#' @import ggplot2
#'
#' @examples
#' scatterPlot("Goals", "Assists", TRUE)
#' scatterPlot("Goals", "Assists", FALSE, "men")
scatterPlot <- function(x, y, trend, gender="women") {

  # check for invalid variable names
  if (!varIsValid(x)) {
    stop(paste0(x, " not a valid variable name"))
  }

  if (!varIsValid(y)) {
    stop(paste0(y, " not a valid variable name"))
  }

  data <- scrapeTeamStats(gender)
  title <- paste0(x, " vs. ", y, " in ", titleCase(gender) , "'s ECAC")

  plot <- ggplot(data, aes(x = .data[[x]], y = .data[[y]])) +
    geom_point() +
    labs(title = title)

  if (trend) {
    plot <- plot + geom_smooth(se=FALSE)
  }

  plot
}
