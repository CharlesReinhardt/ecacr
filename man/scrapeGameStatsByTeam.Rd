% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scrapeGameStatsByTeam.R
\name{scrapeGameStatsByTeam}
\alias{scrapeGameStatsByTeam}
\title{Scrape Game Statistics for one season (of one team) of ECAC hockey games}
\usage{
scrapeGameStatsByTeam(team, gender = "women")
}
\arguments{
\item{team}{ECAC team to scrape data for}

\item{gender}{'women' (default) or 'men'}
}
\value{
dataframe of game statistics
}
\description{
Webscrape (using rvest) skater and goalie statistics for one team's games this season
}
\examples{
scrapeGameStatsByTeam(team="brown")
scrapeGameStatsByTeam(team="stlawrence", gender="men")
}
