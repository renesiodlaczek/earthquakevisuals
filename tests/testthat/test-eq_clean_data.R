
test_that("date column successfully created", {
    expect_type(eq_clean_data(noaa_earthquakes)$date, "double")
})

test_that("lat/lon are numeric", {
    expect_type(eq_clean_data(noaa_earthquakes)$latitude, "double")
    expect_type(eq_clean_data(noaa_earthquakes)$longitude, "double")
})
