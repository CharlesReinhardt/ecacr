#' Produce a Boxplot of your variable of choice
#'
#' @param var variable to plot
#' @param gender women or men
#'
#' @return
#' @export
#'
#' @examples
boxplot <- function(var, gender="women") {

  if (!varisValid(var, type="game")) {
    stop(paste0(var, " not a valid variable"))
  }

  data <- scrapeGameStats(gender=gender)
  title <- paste0(var, " (each game) by team in ", str_to_title(gender), "'s ECAC")

  dataModified <- data %>%
    mutate(Team = str_to_title(Team)) %>%
    mutate(Team = factor(Team)) %>%
    group_by(Team) %>%
    mutate(median = median(na.omit(.data[[var]]))) %>%
    ungroup() %>%
    mutate(Team = fct_reorder(Team, median)) %>%
    group_by(Team)

  plot <- ggplot(dataModified, aes(x = Team)) +
    geom_boxplot(aes_string(y=var)) +
    coord_flip() +
    labs(title = title)

  plot
}
