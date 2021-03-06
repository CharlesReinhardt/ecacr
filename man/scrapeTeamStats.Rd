% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scrapeTeamStats.R
\name{scrapeTeamStats}
\alias{scrapeTeamStats}
\title{Scrape Team Summary Statistics}
\usage{
scrapeTeamStats(games = "all", gender = "women")
}
\arguments{
\item{games}{collecting data for 'all' (default), 'conference', or 'nonconference' games. Currently no support for 'nonconference' games}

\item{gender}{'women' (default) or 'men'}
}
\value{
data frame of summary team statistics
}
\description{
Web scrape (using rvest) team summary statistics for the current ECAC season
}
\examples{
scrapeTeamStats()
scrapeTeamStats(games="conference", gender="men")
}
