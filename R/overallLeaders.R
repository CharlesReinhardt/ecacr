overallLeaders <- function(var, n_leaders=10, conf=FALSE, skaters=FALSE, gender="women", verbose=TRUE) {

  # check valid variable
  type <- if_else(skaters, "skater", "goalie")
  if (!varIsValid(var, type=type)) {
    stop(paste0(var, " is not a valid variable for ", type))
  }

  # check valid gender
  if (!genderIsValid(gender)) {
    stop("invalid gender argument, must be either 'women' or 'men'")
  }

  data <- scrapeIndivStats(conf=conf, skaters=skaters, gender=gender, verbose=verbose)

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
