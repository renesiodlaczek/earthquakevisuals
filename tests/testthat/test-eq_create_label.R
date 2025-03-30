
test_that("label character column created", {
    expect_vector(eq_create_label(noaa_earthquakes), ptype = character(), size = nrow(noaa_earthquakes))
})
