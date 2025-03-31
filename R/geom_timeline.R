
#' Timeline
#' 
#' This geom is used to display NOAA earthquakes on a timeline. Each earthquake
#' is represented by a point which can be visually differentiated by magnitude 
#' and death count. Furthermore the user can specify a grouping by which the
#' timeline can be split vertically into multiple timelines, e. g. by country.
#'
#' @inheritParams ggplot2::geom_point
#' @param xmin A date value to filter the data from the given date.
#' @param xmax A date value to filter the data up to the given date.
#'
#' @returns A ggplot graph.
#'
#' @examples
#' noaa_earthquakes |> 
#'     eq_clean_data() |> 
#'     ggplot2::ggplot(ggplot2::aes(date)) +
#'     geom_timeline()
#' 
#' @export
geom_timeline <- function(mapping = NULL, data = NULL,
                          stat = "identity", position = "identity",
                          xmin = as.Date("0001-01-01"), xmax = as.Date("9999-01-01"),
                          ...,
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE) {
    
    
    ggplot2::layer(
        data = data,
        mapping = mapping,
        stat = stat,
        geom = GeomTimeline,
        position = position,
        show.legend = show.legend,
        inherit.aes = inherit.aes,
        params = list(
            na.rm = na.rm,
            xmin = xmin,
            xmax = xmax,
            ...
        )
    )
}

#' @rdname ggplot2-ggproto
#' @format NULL
#' @usage NULL
GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
                                 
                                 required_aes = c("x"),
                                 non_missing_aes = c("size", "shape", "colour"),
                                 
                                 default_aes = ggplot2::aes(
                                     y = 1, shape = 19, colour = "black", 
                                     size = 1.5, fill = NA, alpha = 0.5, 
                                     stroke = 0.5
                                 ),
                                 
                                 # The additional parameters must be given explicitly 
                                 # to use them in the setup_data function
                                 extra_params = c("na.rm", "xmin", "xmax"),
                                 
                                 setup_data = function(data, params) {
                                     # set default y value
                                     data$y <- if (is.null(data$y)) 1 else data$y
                                     
                                     # filter data based on the parameters xmin and xmax
                                     data <- subset(data, x >= params$xmin & x <= params$xmax)
                                     
                                     # transform data as needed for GeomSegment
                                     transform(data, yend = y, xend = max(x))
                                     
                                 },
                                 
                                 
                                 draw_group = function(data, panel_scales, coord) {
                                     
                                     lines <- data
                                     lines$colour <- "grey"
                                     lines$linewidth <- 0.5
                                     lines$x <- 0

                                     grid::gList(
                                         ggplot2::GeomSegment$draw_panel(lines, panel_scales, coord, lineend = "round"),
                                         ggplot2::GeomPoint$draw_panel(data, panel_scales, coord)
                                     )
                                     
                                 },
                                 
                                 draw_key = ggplot2::draw_key_point
                                 
                                 )

