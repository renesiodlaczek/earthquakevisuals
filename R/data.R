
#' National Oceanographic and Atmospheric Administration (NOAA) earthquake data
#' 
#' The Significant Earthquake Database contains information on destructive 
#' earthquakes from 2150 B.C. to 2025 that meet at least one of the 
#' following criteria: Moderate damage (approximately $1 million or more), 
#' 10 or more deaths, Magnitude 7.5 or greater, Modified Mercalli Intensity 
#' X or greater, or the earthquake generated a tsunami.
#'
#'
#' @format ## `noaa_earthquakes`
#' A data frame with 6478 rows and 38 columns:
#' \describe{
#'   \item{year}{Year}
#'   \item{mo}{Month}
#'   \item{dy}{Day}
#'   \item{location_name}{Country and location name}
#'   \item{latitude}{Latitude}
#'   \item{longitude}{Longitude}
#'   \item{mag}{Magnitude}
#'   \item{total_deaths}{Death count}
#'   ...
#' }
#' @source <https://www.ngdc.noaa.gov/hazel/view/hazards/earthquake/search>
"noaa_earthquakes"