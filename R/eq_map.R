
#' Earthquake map
#' 
#' This function creates a leaflet map visualizing the earthquake locations.
#'
#' @param x A dataframe containing the cleaned NOAA earthquake dataset.
#' @param annot_col A column name of the given dataframe to be used as label text.
#'
#' @returns A leaflet map.
#'
#' @examples
#' eq_map(noaa_earthquakes, "location_name")
#' 
#' @export
eq_map <- function(x, annot_col) {
    
    popup_text <- as.character(x[[annot_col]])

    x |> 
        leaflet::leaflet() |> 
        leaflet::addTiles() |> 
        leaflet::addCircleMarkers(lng = ~longitude,
                                  lat = ~latitude,
                                  radius = ~mag,
                                  weight = 1,
                                  popup = popup_text
                                  )
    
}    
    



