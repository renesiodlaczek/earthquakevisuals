
<!-- README.md is generated from README.Rmd. Please edit that file -->

# earthquakevisuals

<!-- badges: start -->

[![R-CMD-check](https://github.com/renesiodlaczek/earthquakevisuals/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/renesiodlaczek/earthquakevisuals/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of earthquakevisuals is to provide custom visualizations to
analyze the earthquake data collected by the National Oceanographic and
Atmospheric Administration (NOAA). The package includes the data itself,
some preprocessing functions and some visualization functions that are
built on top of the ggplot2 and leaflet packages.

## Installation

You can install the development version of earthquakevisuals from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("renesiodlaczek/earthquakevisuals")
```

## Setup

After installing the package the required packages must be loaded.

``` r
library(earthquakevisuals)
library(ggplot2)
```

The data is stored under the name `noaa_earthquakes`. It contains
observations form 2150 B.C. up until 2025. To be able to use it properly
some preprocessing steps are required bevorehand. For this purpose the
two functions `eq_clean_data()` and `eq_location_clean()` can be used.
Among others the former creates a date column and the latter separates
the country name and the location name into distinct columns.

``` r
data <- noaa_earthquakes |> 
    eq_clean_data() |>
    eq_location_clean()
```

## Ggplot2 dotplots

Once this is done the first visualization can be created. The package
contains the custom ggplot2 geom `geom_timeline()` which creates a
horizontal dotplot. It also provides the possibility to filter the data
in the geom itself via the parameters `xmin` and `xmax`.

``` r
data |> 
    subset(country %in% c("ALASKA", "CHINA", "JAPAN")) |> 
    ggplot(aes(date)) +
    geom_timeline(xmin = as.Date("2000-01-01"), 
                  xmax = as.Date("2018-01-01")
                  ) +
    theme_classic() +
    theme(axis.line.y = element_blank(), 
          axis.ticks.y = element_blank(), 
          axis.text.y = element_blank()
          ) +
    labs(x = "DATE", 
         y = element_blank(), 
         title = "NOAA Earthquakes") +
    ylim(0.5, 2)
```

<img src="man/figures/README-geom_timeline-1.png" width="100%" />

But `geom_timeline()` allows for much more customization. E. g. you can
give a `y aesthetic` to split the dotplots into different groups. You
can also specify size and color to include more dimensions. Lastly, the
`geom_timeline_label()` function can be used to add a label to each
earthquake. Via the parameter `n_max` only the biggest earthquakes are
labelled according to the `size aesthetic`.

``` r
data |> 
    subset(country %in% c("ALASKA", "CHINA", "JAPAN")) |> 
    ggplot(aes(date, country, size = mag, color = total_deaths)) +
    geom_timeline(xmin = as.Date("2000-01-01"), 
                  xmax = as.Date("2018-01-01")
                  ) +
    geom_timeline_label(aes(label = location_name),
                        xmin = as.Date("2000-01-01"), 
                        xmax = as.Date("2018-01-01"),
                        n_max = 5
                        ) +
    theme_classic() +
    theme(axis.line.y = element_blank(),
          axis.ticks.y = element_blank(),
          legend.position = "bottom"
          ) +
    scale_size_continuous(name = "Richter scale value") +
    scale_color_continuous(name = "# deaths") +
    labs(x = "DATE", 
         y = element_blank(), 
         title = "NOAA Earthquakes")
```

<img src="man/figures/README-geom_timeline_label-1.png" width="100%" />

## Leaflet maps

The function `eq_map()` is useful when one wants to display the
earthquakes on a map. The parameter `annot_col` steers which column is
used for labelling the individual earthquakes.

``` r
data |> 
    subset(country == "INDIA" & date >= as.Date("2000-01-01")) |>
    eq_map(annot_col = "date")
```

<div class="leaflet html-widget html-fill-item" id="htmlwidget-801f047b4bb573777489" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-801f047b4bb573777489">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"https://openstreetmap.org/copyright/\">OpenStreetMap<\/a>,  <a href=\"https://opendatacommons.org/licenses/odbl/\">ODbL<\/a>"}]},{"method":"addCircleMarkers","args":[[23.388,13.036,24.757,24.55,17.145,17.072,7.92,17.398,30.924,17.067,30.476,27.382,23.777,23.322,26.88,30.881,17.2,21.181,28.555,23.433,23.33,24.702,17.438,22.399,27.143,33.198,14.099,17.109,13.667,30.099,7.881,13.197,29.872,28.724,27.73,21.211,27.449,24.955,26.175,23.739,33.061,33.297,26.638,24.804,23.094,24.015,26.371,19.9,20,26.782,29.597,33.096],[70.32599999999999,93.068,92.539,92.524,73.73,73.66800000000001,92.19,74.11799999999999,78.56,73.773,79.255,88.38800000000001,70.899,70.477,76.15000000000001,78.239,73.7,70.724,77.057,87.111,70.592,84.964,73.91500000000001,85.90300000000001,70.749,75.78700000000001,92.88800000000001,73.767,92.831,80.026,91.93600000000001,93.087,80.428,77.18899999999999,88.155,70.533,88.684,95.236,92.889,81.31399999999999,75.863,75.95,90.41,93.651,94.86499999999999,92.018,90.161,72.8,72.90000000000001,92.43600000000001,81.652,75.896],[7.6,6.5,5.4,5.1,4.9,4.3,7.2,4.4,4.4,4.7,5.3,5.3,5.5,5.5,4.2,4.3,4.4,5.1,4.7,4.3,4.5,3.8,5,4.1,5.2,4.9,7.5,5.1,6.7,4.5,7.5,5.9,5.2,4.3,6.9,5,3.5,5.8,5.4,5,5.7,5.2,5.1,6.7,6.9,5.7,5.3,3.6,3.8,6,5.6,5],null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":1,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,["2001-01-26","2002-09-13","2004-12-09","2005-02-15","2005-03-14","2005-03-15","2005-07-24","2005-08-14","2005-08-16","2005-08-30","2005-12-14","2006-02-14","2006-03-07","2006-04-06","2006-12-24","2007-07-22","2007-08-20","2007-11-06","2007-11-25","2008-02-06","2008-03-09","2008-06-06","2008-09-16","2009-03-26","2009-04-09","2009-05-19","2009-08-10","2009-12-12","2010-03-30","2010-05-01","2010-06-12","2010-06-18","2010-06-22","2011-09-07","2011-09-18","2011-10-20","2011-10-29","2011-11-21","2012-05-11","2012-10-18","2013-05-01","2013-08-02","2015-06-28","2016-01-03","2016-04-13","2017-01-03","2018-09-12","2019-02-01","2019-07-24","2021-04-28","2023-01-24","2023-06-13"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[7.881,33.297],"lng":[70.32599999999999,95.236]}},"evals":[],"jsHooks":[]}</script>

To have a label with more information the function `eq_create_label()`
can be used to generate a HTML formatted column with information about
an earthquake’s location, its magnitude and the associated number of
deaths. The newly created column can serve as an input for the
`eq_map()` function.

``` r
data |> 
    transform(popup_text = eq_create_label(data)) |> 
    subset(country == "INDIA" & date >= as.Date("2000-01-01")) |> 
    eq_map(annot_col = "popup_text")
```

<div class="leaflet html-widget html-fill-item" id="htmlwidget-8211caed1ae2beab8437" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-8211caed1ae2beab8437">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"https://openstreetmap.org/copyright/\">OpenStreetMap<\/a>,  <a href=\"https://opendatacommons.org/licenses/odbl/\">ODbL<\/a>"}]},{"method":"addCircleMarkers","args":[[23.388,13.036,24.757,24.55,17.145,17.072,7.92,17.398,30.924,17.067,30.476,27.382,23.777,23.322,26.88,30.881,17.2,21.181,28.555,23.433,23.33,24.702,17.438,22.399,27.143,33.198,14.099,17.109,13.667,30.099,7.881,13.197,29.872,28.724,27.73,21.211,27.449,24.955,26.175,23.739,33.061,33.297,26.638,24.804,23.094,24.015,26.371,19.9,20,26.782,29.597,33.096],[70.32599999999999,93.068,92.539,92.524,73.73,73.66800000000001,92.19,74.11799999999999,78.56,73.773,79.255,88.38800000000001,70.899,70.477,76.15000000000001,78.239,73.7,70.724,77.057,87.111,70.592,84.964,73.91500000000001,85.90300000000001,70.749,75.78700000000001,92.88800000000001,73.767,92.831,80.026,91.93600000000001,93.087,80.428,77.18899999999999,88.155,70.533,88.684,95.236,92.889,81.31399999999999,75.863,75.95,90.41,93.651,94.86499999999999,92.018,90.161,72.8,72.90000000000001,92.43600000000001,81.652,75.896],[7.6,6.5,5.4,5.1,4.9,4.3,7.2,4.4,4.4,4.7,5.3,5.3,5.5,5.5,4.2,4.3,4.4,5.1,4.7,4.3,4.5,3.8,5,4.1,5.2,4.9,7.5,5.1,6.7,4.5,7.5,5.9,5.2,4.3,6.9,5,3.5,5.8,5.4,5,5.7,5.2,5.1,6.7,6.9,5.7,5.3,3.6,3.8,6,5.6,5],null,null,{"interactive":true,"className":"","stroke":true,"color":"#03F","weight":1,"opacity":0.5,"fill":true,"fillColor":"#03F","fillOpacity":0.2},null,null,["<b>Location:<\/b> Gujarat<br/><b>Magnitude:<\/b> 7.6<br/><b>Total deaths:<\/b> 20005","<b>Location:<\/b> Andaman Islands<br/><b>Magnitude:<\/b> 6.5<br/><b>Total deaths:<\/b> 2","<b>Location:<\/b> Hailakandi, Cachar<br/><b>Magnitude:<\/b> 5.4","<b>Location:<\/b> Khaspur<br/><b>Magnitude:<\/b> 5.1","<b>Location:<\/b> Maharashtra<br/><b>Magnitude:<\/b> 4.9","<b>Location:<\/b> Maharashtra<br/><b>Magnitude:<\/b> 4.3","<b>Location:<\/b> Andaman Islands, Nicobar Islands<br/><b>Magnitude:<\/b> 7.2","<b>Location:<\/b> Maharashtra<br/><b>Magnitude:<\/b> 4.4","<b>Location:<\/b> Uttaranchal<br/><b>Magnitude:<\/b> 4.4","<b>Location:<\/b> Maharashtra<br/><b>Magnitude:<\/b> 4.7","<b>Location:<\/b> Jausari, Chamoli, Nandprayag<br/><b>Magnitude:<\/b> 5.3<br/><b>Total deaths:<\/b> 1","<b>Location:<\/b> Sikkim<br/><b>Magnitude:<\/b> 5.3<br/><b>Total deaths:<\/b> 2","<b>Location:<\/b> Gujarat<br/><b>Magnitude:<\/b> 5.5","<b>Location:<\/b> Gujarat<br/><b>Magnitude:<\/b> 5.5","<b>Location:<\/b> Rajasthan<br/><b>Magnitude:<\/b> 4.2","<b>Location:<\/b> Uttarkashi, Chamoli, Muzaffarnagar<br/><b>Magnitude:<\/b> 4.3","<b>Location:<\/b> Maharashtra<br/><b>Magnitude:<\/b> 4.4","<b>Location:<\/b> Gujarat<br/><b>Magnitude:<\/b> 5.1<br/><b>Total deaths:<\/b> 1","<b>Location:<\/b> Badaun, Meerut, Noida, Rewari<br/><b>Magnitude:<\/b> 4.7","<b>Location:<\/b> West Bengal<br/><b>Magnitude:<\/b> 4.3<br/><b>Total deaths:<\/b> 1","<b>Location:<\/b> Gujarat<br/><b>Magnitude:<\/b> 4.5","<b>Location:<\/b> Manpur<br/><b>Magnitude:<\/b> 3.8","<b>Location:<\/b> Maharashtra<br/><b>Magnitude:<\/b> 5<br/><b>Total deaths:<\/b> 1","<b>Location:<\/b> Chaibasa<br/><b>Magnitude:<\/b> 4.1","<b>Location:<\/b> Jaisalmer<br/><b>Magnitude:<\/b> 5.2","<b>Location:<\/b> Kashmir<br/><b>Magnitude:<\/b> 4.9","<b>Location:<\/b> Andaman I<br/><b>Magnitude:<\/b> 7.5","<b>Location:<\/b> Maharashtra<br/><b>Magnitude:<\/b> 5.1","<b>Location:<\/b> Andaman Islands<br/><b>Magnitude:<\/b> 6.7","<b>Location:<\/b> Chamoli<br/><b>Magnitude:<\/b> 4.5","<b>Location:<\/b> Little Nicobar Island<br/><b>Magnitude:<\/b> 7.5","<b>Location:<\/b> Andaman Islands<br/><b>Magnitude:<\/b> 5.9","<b>Location:<\/b> Tauli<br/><b>Magnitude:<\/b> 5.2","<b>Location:<\/b> Delhi<br/><b>Magnitude:<\/b> 4.3","<b>Location:<\/b> Sikkim; Nepal; China; Bhutan<br/><b>Magnitude:<\/b> 6.9<br/><b>Total deaths:<\/b> 127","<b>Location:<\/b> Gujarat<br/><b>Magnitude:<\/b> 5","<b>Location:<\/b> Sikkim<br/><b>Magnitude:<\/b> 3.5<br/><b>Total deaths:<\/b> 2","<b>Location:<\/b> Assam<br/><b>Magnitude:<\/b> 5.8","<b>Location:<\/b> Assam<br/><b>Magnitude:<\/b> 5.4","<b>Location:<\/b> Deurala, Jaisinghnagar, Kotma, Sarai, Umaria<br/><b>Magnitude:<\/b> 5","<b>Location:<\/b> Kashmir<br/><b>Magnitude:<\/b> 5.7<br/><b>Total deaths:<\/b> 3","<b>Location:<\/b> Kashmir<br/><b>Magnitude:<\/b> 5.2","<b>Location:<\/b> Kokrajhar<br/><b>Magnitude:<\/b> 5.1","<b>Location:<\/b> Impahl<br/><b>Magnitude:<\/b> 6.7<br/><b>Total deaths:<\/b> 13","<b>Location:<\/b> Assam; Bangladesh<br/><b>Magnitude:<\/b> 6.9<br/><b>Total deaths:<\/b> 2","<b>Location:<\/b> Ambasa; Bangladesh<br/><b>Magnitude:<\/b> 5.7<br/><b>Total deaths:<\/b> 3","<b>Location:<\/b> West Bengal<br/><b>Magnitude:<\/b> 5.3<br/><b>Total deaths:<\/b> 1","<b>Location:<\/b> Maharashtra<br/><b>Magnitude:<\/b> 3.6<br/><b>Total deaths:<\/b> 1","<b>Location:<\/b> Maharashtra<br/><b>Magnitude:<\/b> 3.8<br/><b>Total deaths:<\/b> 1","<b>Location:<\/b> Assam<br/><b>Magnitude:<\/b> 6<br/><b>Total deaths:<\/b> 2","<b>Location:<\/b> Uttar Pradesh; Nepal<br/><b>Magnitude:<\/b> 5.6<br/><b>Total deaths:<\/b> 4","<b>Location:<\/b> Kashmir<br/><b>Magnitude:<\/b> 5"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[7.881,33.297],"lng":[70.32599999999999,95.236]}},"evals":[],"jsHooks":[]}</script>
