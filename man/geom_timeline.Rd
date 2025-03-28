% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_timeline.R
\name{geom_timeline}
\alias{geom_timeline}
\title{Timeline}
\usage{
geom_timeline(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  xmin = as.Date("0001-01-01"),
  xmax = as.Date("9999-01-01"),
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)
}
\arguments{
\item{xmin}{A date value to filter the data from the given date.}

\item{xmax}{A date value to filter the data up to the given date.}
}
\value{
A ggplot graph.
}
\description{
This geom is used to display NOAA earthquakes on a timeline. Each earthquake
is represented by a point which can be visually differentiated by magnitude
and death count. Furthermore the user can specify a grouping by which the
timeline can be split vertically into multiple timelines, e. g. by country.
}
