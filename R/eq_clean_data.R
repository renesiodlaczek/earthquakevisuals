
eq_clean_data <- function(x) {
    x$mo <- ifelse(is.na(x$mo), 1, x$mo)
    x$dy <- ifelse(is.na(x$dy), 1, x$dy)
    x$date <- ISOdate(x$year, x$mo, x$dy)
    x$date <- as.Date(x$date)
    x$longitude = as.numeric(x$longitude)
    x$latitude = as.numeric(x$latitude)
    x
}


