histogram <- function(var, conf=FALSE, skaters=FALSE, gender="women") {

  # check valid variable name
  if (!varIsValid(var, team=FALSE, skaters=skaters)) {
    stop(paste0(var, " not a valid variable name"))
  }

  data <- scrapeIndivStats(conf=conf, skaters=skaters, gender=gender)
  title <- paste0(var, " in ", titleCase(gender), "'s ECAC")

  if (conf) {
    title <- paste0(title, " (Conference Only)")
  }

  ggplot(data = data, aes_string(x = var)) +
    geom_histogram() +
    labs(x = var, y = "Number of Players", title = title)
}
