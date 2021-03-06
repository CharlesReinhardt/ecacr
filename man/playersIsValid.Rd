% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{playersIsValid}
\alias{playersIsValid}
\title{Check Players Argument Validity}
\usage{
playersIsValid(players)
}
\arguments{
\item{players}{argument to check}
}
\value{
TRUE if valid argument, FALSE otherwise
}
\description{
Checks the validity of provided players argument
}
\examples{
playersIsValid(players="goalies") # TRUE
playersIsValid(players="Skate") # FALSE
}
