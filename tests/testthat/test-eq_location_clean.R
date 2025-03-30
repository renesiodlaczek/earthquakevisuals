
test_that("country column successfully created", {
    expect_type(eq_location_clean(noaa_earthquakes)$country, "character")
})