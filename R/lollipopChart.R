#' Produce a ggplot2 Lollipop Chart
#'
#' Create a ggplot2 lollipop chart (alternative to a bar chart) of overall season summary
#' statistics of all ECAC teams.
#'
#' @param var summary statistic to display
#' @param gender "women' (default) or 'men'
#' @param games graphing 'all' (default), 'conference', or 'nonconference' games. Currently no support for 'nonconference' games
#'
#' @return a ggplot2 lollipop chart object
#' @export
#' @import ggplot2
#'
#' @examples
#' lollipopChart(var="Goals")
#' lollipopChart(var="PenaltyMinutes", games="conference", gender="men")
lollipopChart <- function(var, games="all", gender="women") {

  # check for invalid variable names
  if (!varIsValid(var, type="team")) {
    stop(paste0(var, " not a valid variable name for team data"))
  }

  data <- scrapeTeamStats(games=games, gender=gender)
  data_ordered <-
    data %>%
    dplyr::mutate(Name = forcats::fct_reorder(factor(Name), .data[[var]]))

  genderTitle <- stringr::str_to_title(gender)
  title <- paste0(var, " by ", genderTitle, "'s teams in the ECAC")
  if (games == "conference") {
    title <- paste0(title, " (Conference only)")
  }

  plot <-
    ggplot(data=data_ordered, mapping=aes(x = Name, y = .data[[var]])) +
    geom_segment(aes(xend=Name, y=0, yend=.data[[var]])) +
    geom_point(color="Red", size=2) +
    labs(title = title) +
    coord_flip()

  plot
}
