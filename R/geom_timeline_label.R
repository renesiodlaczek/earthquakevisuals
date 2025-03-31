
#' Timeline label
#' 
#' This geom labels the earthquakes that have been visualized by the
#' [geom_timeline()] function, e.g. with the location name.
#' 
#' @inheritParams ggplot2::geom_point
#' @param xmin A date value to filter the data from the given date.
#' @param xmax A date value to filter the data up to the given date.
#' @param n_max Maximum amount of earthquakes that will be labelled. The
#' earthquakes with the greatest size value are labelled first. 
#'
#' @returns A ggplot graph.
#'
#' @examples
#' noaa_earthquakes |> 
#'     eq_clean_data() |> 
#'     ggplot2::ggplot(ggplot2::aes(date)) +
#'     geom_timeline() +
#'     geom_timeline_label(ggplot2::aes(label = location_name))
#'     
#' @export 
geom_timeline_label <- function(mapping = NULL, data = NULL,
                          stat = "identity", position = "identity",
                          xmin = as.Date("0001-01-01"), xmax = as.Date("9999-01-01"),
                          n_max = 5,
                          ...,
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE) {
    ggplot2::layer(
        data = data,
        mapping = mapping,
        stat = stat,
        geom = GeomTimelineLabel,
        position = position,
        show.legend = show.legend,
        inherit.aes = inherit.aes,
        params = list(
            na.rm = na.rm,
            xmin = xmin,
            xmax = xmax,
            n_max = n_max,
            ...
        )
    )
}

#' @rdname ggplot2-ggproto
#' @format NULL
#' @usage NULL
GeomTimelineLabel <- ggplot2::ggproto("GeomTimelineLabel", ggplot2::Geom,
                                 
                                 required_aes = c("x", "label"),
                                 non_missing_aes = c("size", "shape", "colour"),
                                 
                                 default_aes = ggplot2::aes(
                                     y = 1, shape = 19, colour = "black", 
                                     size = 1.5, fill = NA, alpha = 0.5, 
                                     stroke = 0.5
                                 ),
                                 
                                 # The additional parameters must be given explicitly 
                                 # to use them in the setup_data function
                                 extra_params = c("na.rm", "xmin", "xmax", "n_max"),
                                 
                                 setup_data = function(data, params) {
                                     # set default y value
                                     data$y <- if (is.null(data$y)) 1 else data$y
                                     data$size <- if (is.null(data$size)) 1 else data$size

                                     # filter data based on the parameters xmin and xmax
                                     data <- subset(data, x >= params$xmin & x <= params$xmax)
                                     
                                     # filter data based on parameter n_max per group
                                     data <- tapply(data, data$y, function(x) {
                                         x <- x[order(x$size, decreasing = TRUE), ]
                                         x <- x[1:params$n_max, ]
                                         x
                                     })
                                     
                                     data <- do.call(rbind, data)
                                     
                                     # transform data as needed for GeomSegment
                                     transform(data, yend = y, xend = max(x))
                                 },
                                 
                                 draw_group = function(data, panel_scales, coord) {
                                     
                                     lines <- data
                                     lines$colour <- "grey"
                                     lines$alpha <- 1
                                     lines$linewidth <- 0.3
                                     lines$xend <- lines$x
                                     lines$yend <- lines$y + 0.1

                                     text <- data
                                     text$colour <- "black"
                                     text$alpha <- 1
                                     text$size <- 3
                                     text$angle <- 45
                                     text$y <- lines$yend + 0.01
                                     text$vjust <- 0
                                     text$hjust <- 0

                                     grid::gList(
                                         ggplot2::GeomSegment$draw_panel(lines, panel_scales, coord, lineend = "round"),
                                         ggplot2::GeomText$draw_panel(text, panel_scales, coord)
                                     )
                                     
                                 },
                                 
                                 draw_key = ggplot2::draw_key_point
                                 
                                 )

