#' Produce a chart visualizing the wins and losses of a team
#'
#' @param team the team you'd like to investigate
#' @param byLocation TRUE to split Home/Away, FALSE otherwise (default TRUE)
#' @param gender gender you'd like to investigate (default "women")
#'
#' @return
#' @export
#'
#' @import ggplot2
#'
#' @examples
winLossChart <- function(team, byLocation=TRUE, gender="women") {

  # check valid team name
  if (!teamIsValid(team)) {
    message <- paste0(team, " not a valid team name")
    stop(message)
  }

  # check valid gender
  if (!genderIsValid(gender)) {
    stop("gender argument must either be 'women' or 'men'")
  }

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
