#' Produce a ggplot2 Boxplot
#'
#' Create a ggplot2 boxplot displaying the distribution of a given variable. Does so by
#' grouping the variable of choice by ECAC team, and displaying the value of variable
#' for each ECAC game.
#'
#' @param var variable to plot
#' @param gender 'women' (default) or 'men'
#'
#' @return a ggplot2 boxplot object
#' @export
#'
#' @import ggplot2
#' @import dplyr
#'
#' @examples
#' boxplot(var="Goals", gender="women", verbose=FALSE)
#' boxplot(var="Assists", gender="men", verbose=FALSE)
boxplot <- function(var, gender="women", verbose=TRUE) {

  if (!varIsValid(var, type="game")) {
    stop(paste0(var, " not a valid variable for games data"))
  }

  data <- scrapeGameStats(gender=gender, verbose=verbose)
  title <- paste0(var, " (each game) by team in ", stringr::str_to_title(gender), "'s ECAC")

  dataModified <- data %>%
    mutate(Team = str_to_title(Team)) %>%
    mutate(Team = factor(Team)) %>%
    group_by(Team) %>%
    mutate(median = median(na.omit(.data[[var]]))) %>%
    ungroup() %>%
    mutate(Team = forcats::fct_reorder(Team, median)) %>%
    group_by(Team)

  plot <- ggplot(dataModified, aes(x = Team)) +
    geom_boxplot(aes_string(y=var)) +
    coord_flip() +
    labs(title = title)

  plot
}
