#' Make a Lollipop Chart
#'
#' @param data gender to graph
#' @param var variable to graph, must be given as a string
#'
#' @return returns a lollipop chart of the given variable, separated by team. Plots Games Played by default.
#' @export
#'
#' @examples
#' lollipopChart() returns a plot of women's teams games played
#' lollipopChart("Goals") returns a plot of given women's teams goals scored
lollipopChart <- function(var, gender="women") {

  # TODO check for invalid variable names
  # TODO how to test this?

  data <- teamStats(gender)
  data_ordered <-
    data %>%
    mutate(Name = fct_reorder(factor(Name), .data[[var]]))

  genderTitle <- paste0(toupper(substr(gender, 1, 1)), tolower(substr(gender, 2, nchar(gender))))

  plot <-
    ggplot(data=data_ordered, mapping=aes(x = Name, y = .data[[var]])) +
    geom_segment(aes(xend=Name, y=0, yend=.data[[var]])) +
    geom_point(color="Red", size=2) +
    labs(title = paste0(var, " by ", genderTitle , "'s teams in the ECAC")) +
    coord_flip()

  plot
}
