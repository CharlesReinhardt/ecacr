#' Make a Lollipop Chart
#'
#' @param var variable to graph, must be given as a string
#' @param gender gender of data to graph
#'
#' @return returns a lollipop chart of the given variable, separated by team. Plots Games Played by default.
#' @export
#'
#' @examples
#' lollipopChart() returns a plot of women's teams games played
#' lollipopChart("Goals") returns a plot of given women's teams goals scored
#' lollipopChart("Goals", "men") returns a plot of men's team's goals scored
lollipopChart <- function(var, gender="women") {

  # check for invalid variable names
  if (!varIsValid(var)) {
    stop(paste0(var, " not a valid variable name"))
  }

  # TODO how to test this function?

  data <- scrapeTeamStats(gender)
  data_ordered <-
    data %>%
    mutate(Name = fct_reorder(factor(Name), .data[[var]]))

  genderTitle <- titleCase(gender)

  plot <-
    ggplot(data=data_ordered, mapping=aes(x = Name, y = .data[[var]])) +
    geom_segment(aes(xend=Name, y=0, yend=.data[[var]])) +
    geom_point(color="Red", size=2) +
    labs(title = paste0(var, " by ", genderTitle , "'s teams in the ECAC")) +
    coord_flip()

  plot
}
