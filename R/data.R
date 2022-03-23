url <- "https://www.ecachockey.com/women/2021-22/teams?sort=name&r=0&pos="
tab <- read_html(url) %>% html_table()
data <- tab[[1]]

data
