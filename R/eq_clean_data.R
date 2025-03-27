
#' Earthquake data cleaning
#' 
#' This function can be used to clean the NOAA earthquake dataset. E. g. it
#' formats the data correctly.
#'
#' @param x A dataframe of the NOAA earthquake dataset
#'
#' @returns A dataframe.
#' @export
#'
#' @examples
eq_clean_data <- function(x) {
    x$mo <- ifelse(is.na(x$mo), 1, x$mo)
    x$dy <- ifelse(is.na(x$dy), 1, x$dy)
    x$date <- ISOdate(x$year, x$mo, x$dy)
    x$date <- as.Date(x$date)
    x$longitude = as.numeric(x$longitude)
    x$latitude = as.numeric(x$latitude)
    x
}


