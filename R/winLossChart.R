#' Produce a Win/Loss ggplot2 Bar Chart
#'
#' Creates a ggplot2 bar chart object visualizing the wins and losses of a given ECAC team.
#' Can be faceted by home/away.
#'
#' @param team ECAC team to visualize
#' @param byLocation TRUE (default) to split Home/Away, FALSE otherwise
#' @param gender 'women' (default) or 'men'
#'
#' @return ggplot2 bar chart object
#' @export
#'
#' @import ggplot2
#'
#' @examples
#' winLossChart(team="brown")
#' winLossChart(team="clarkson", gender="men", byLocation=FALSE)
winLossChart <- function(team, gender="women", byLocation=TRUE) {

  data <- scrapeGameStatsByTeam(team=team, gender=gender) %>%
    dplyr::mutate(Location = dplyr::if_else(Home, "Home", "Away"),
           Outcome = dplyr::if_else(Won, "Won", dplyr::if_else(Loss, "Loss", "Tie")))

  titleGender <- stringr::str_to_title(gender)
  titleTeam <- stringr::str_to_title(team)
  title <- paste0(titleTeam, " ", titleGender, " Wins/Losses")

  plot <- ggplot(data=data, aes(x = Outcome)) +
    geom_bar(aes(fill=Outcome))

  if (byLocation) {
    plot <- plot + facet_wrap(~Location)
    title <- paste0(title, " by Game Location")
  }

  plot <- plot + labs(title=title)

  plot
}
