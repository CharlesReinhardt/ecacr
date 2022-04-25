#' Produce a Chart of Individual Overall Season Leaders
#'
#' Creates a ggplot2 lollipop chart (bar chart alternative) object. Displays the overall individual leaders of
#' a given player statistic. Also provides the player's team.
#'
#' @param var summary statistic to plot
#' @param n_leaders number of leaders to plot (default is 10)
#' @param games graphing 'all' (default), 'conference', or 'nonconference' games. Currently no support for 'nonconference' games
#' @param players type of players stats to graph, 'goalies' (default) or 'skaters'
#' @param gender 'women' (default) or 'men'
#' @param verbose TRUE (default) for intermediate data scraping output messages, FALSE for no additional output
#'
#' @return a ggplot2 lollipop chart object
#' @export
#'
#' @examples
#' overallLeaders(var="Saves")
#' overallLeaders(var="Assists", n_leaders=15, games="conference", players="skaters", gender="men", verbose=FALSE)
overallLeaders <- function(var, n_leaders=10, games="all", players="goalies", gender="women", verbose=TRUE) {

  # check valid variable
  if (!varIsValid(var, type=players)) {
    stop(paste0(var, " is not a valid variable for ", players))
  }

  data <- scrapeIndivStats(games=game, skaters=skaters, gender=gender, verbose=verbose)

  title <- paste0("Overall ", var, " Leaders in ", str_to_title(gender), "'s ECAC")
  if (conf) {
    title <- paste0(title, " (Conference Only)")
  }

  dataLeaders <- data %>%
    slice_max(.data[[var]], n=n_leaders) %>%
    mutate(Name = paste0( Name, " (", str_to_title(Team), ")" )) %>%
    mutate(Name = factor(Name)) %>%
    mutate(Name = fct_reorder(Name, .data[[var]]))

  plot <- ggplot(data=dataLeaders, aes(x = Name, y = .data[[var]])) +
    geom_segment(aes(xend=Name, y=0, yend=.data[[var]])) +
    geom_point(color="red", size=2) +
    coord_flip() +
    labs(title=title)

  plot
}
