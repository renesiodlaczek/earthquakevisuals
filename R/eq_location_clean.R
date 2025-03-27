

eq_location_clean <- function(x) {
    x$country <- stringr::str_split_i(x$location_name, ":", i = 1)
    x$location_name = stringr::str_split_i(x$location_name, ":", i = 2)
    x$location_name = stringr::str_squish(x$location_name)
    x$location_name = stringr::str_to_title(x$location_name)
    x
}