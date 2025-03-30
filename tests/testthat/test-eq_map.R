
test_that("Leaflet map is created", {
    expect_s3_class(eq_map(noaa_earthquakes), "leaflet")
    expect_s3_class(eq_map(noaa_earthquakes, "location_name"), "leaflet")
})
