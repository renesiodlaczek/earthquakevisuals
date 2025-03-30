
test_that("Ggplot graph is created", {
    testdata <- eq_clean_data(noaa_earthquakes)
    
    m <- testdata |> 
        ggplot2::ggplot(ggplot2::aes(date)) +
        geom_timeline() +
        geom_timeline_label(ggplot2::aes(label = location_name))
    expect_s3_class(m, "gg")
    
    n <- testdata |> 
        ggplot2::ggplot(ggplot2::aes(date, country, size = mag, color = total_deaths)) + 
        geom_timeline(xmin = as.Date("2000-01-01"), xmax = as.Date("2018-01-01")) +
        geom_timeline_label(ggplot2::aes(label = location_name),
                            xmin = as.Date("2000-01-01"), 
                            xmax = as.Date("2018-01-01"),
                            n_max = 5)
    expect_s3_class(n, "gg")
})
