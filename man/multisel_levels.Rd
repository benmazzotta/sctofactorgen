% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/multi_select_levels.R
\name{multisel_levels}
\alias{multisel_levels}
\title{Convert multi select variables to factors}
\usage{
multisel_levels(surveydata, thefields, thechoices, na_value = "zero")
}
\arguments{
\item{surveydata}{a tibble with survey data as processed by \code{scto_responses}}

\item{thefields}{a tibble with survey fields as processed by \code{read_questions}}

\item{thechoices}{a tibble with choices as processed by \code{read_choices}}

\item{na_value}{a character string, one of \code{"zero"}, \code{"boolean"}, or \code{"NA"}}
}
\value{
a tibble with survey data where single select variables have variable labels in the \code{label} attribute
}
\description{
Convert multi select variables to factors
}
\examples{
NULL
}
