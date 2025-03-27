


    
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
    



