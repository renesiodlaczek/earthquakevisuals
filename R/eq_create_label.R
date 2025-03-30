
#' Earthquake label creation
#' 
#' This function creates a HTML-formatted earthquake description containing the
#' location, magnitude and death count. It was built to serve as the label text
#' for the function [eq_map()].
#'
#' @param x A dataframe containing the cleaned NOAA earthquake dataset.
#'
#' @returns A character vector
#' 
#' @examples
#' eq_create_label(noaa_earthquakes)
#'  
#' @export
eq_create_label <- function(x) {
    
    # ensure all variables are characters
    location_name <- as.character(x$location_name)
    mag <- as.character(x$mag)
    total_deaths <- as.character(x$total_deaths)

    # replace NAs with an empty string for the tags + format the tags
    location_name_tag <- ifelse(is.na(location_name), "", "<b>Location:</b> ")
    mag_tag <- ifelse(is.na(mag), "", "<br/><b>Magnitude:</b> ")
    total_deaths_tag <- ifelse(is.na(total_deaths), "", "<br/><b>Total deaths:</b> ")
    
    # replace NAs with an empty string for the values
    location_name_value <- ifelse(is.na(location_name), "", location_name)
    mag_value <- ifelse(is.na(mag), "", mag)
    total_deaths_value <- ifelse(is.na(total_deaths), "", total_deaths)
    
    # Paste the tags together
    paste0(location_name_tag,
           location_name_value,
           mag_tag,
           mag_value,
           total_deaths_tag,
           total_deaths_value)
    
}    
