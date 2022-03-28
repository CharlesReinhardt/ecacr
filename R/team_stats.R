#' Scrape Team Statistics
#'
#' @return returns a list of women's and men's ecac team data
#' @export
#'
#' @examples
#' team_stats()[1] gives women's team data
#' team_stats()[2] gives men's team data
team_stats <- function() {
  url_women <- "https://www.ecachockey.com/women/2021-22/teams?sort=name&r=0&pos="
  tab_women <- read_html(url_women) %>% html_table()
  data_women <- tab[[1]]

  url_men <- "https://www.ecachockey.com/men/2021-22/teams?sort=name&r=0&pos="
  tab_men <- read_html(url_men) %>% html_table()
  data_men <- tab[[1]]

  data_list <- list(data_women, data_men)
  return(data_list)
}
