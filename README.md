
# ecacr

## Overview

ecacr is intended to allow R users to create introductory data
visualizations of ECAC Hockey teams, games, and players. ecacr makes
intensive use of the
[tidyverse](https://www.tidyverse.org/ "Tidyverse Homepage"), including
[dplyr](https://dplyr.tidyverse.org/ "Dplyr Homepage"),
[stringr](https://stringr.tidyverse.org/ "Stringr Homepage"), and
[ggplot2](https://ggplot2.tidyverse.org/ "ggplot2 Homepage"). Keep
reading to see how you can use ecacr.

#### Team Visualizations

ecacr provides two data visualization templates for team level data.

-   `scatterPlot()` creates a ggplot2 scatter plot of season summary
    statistics for all ECAC teams. Helps highlight relationships (or
    lack thereof) between two summary statistics.

-   `lollipopChart()` creates a ggplot2 lollipop chart (minimalist
    alternative to a bar chart) allowing comparison between ECAC teams
    by a given statistic.

#### Game Visualizations

ecacr provides two functions for data visualizations of game level data

-   `boxplot()` creates a ggplot2 boxplot grouped by ECAC team. Shows
    distribution of the given variable over the course of an entire
    season.

-   `winLossChart()` creates ggplot2 bar chart that visualizes the
    win/loss habits of a single ECAC team for an entire season. Can be
    faceted by home/away.

#### Individual Visualizations

ecacr also provides two data visualizations for individual player data

-   `histogram()` creates a ggplot2 histogram that shows the
    distribution of a given stat across all ECAC players.

-   `overallLeaders()` creates a ggplot2 lollipop chart (modified bar
    chart) of the overall ECAC leaders in a given stat category

#### Web Scraping

ecacr makes use of
[rvest](https://rvest.tidyverse.org/ "Rvest Homepage") to produce a
variety of web scraping functions. These are all used internally in the
previous data visualization functions for those with no prior ggplot2
experience. Use these functions to scrape the data and then manually
create your own visualizations.

-   `scrapeTeamStats()` for team level data

-   `scrapeGameStats()` and `scrapeGameStatsByTeam()` for game level
    data

-   `scrapeIndivStats()` and `scrapeIndivStatsByTeam()` for player level
    data

## Installation

Right now, I have no idea how one would go about installing this package
for their own use. Stay tuned!
