context("trianglegrid")

extent <- c(-77.3876, 38.7198, -76.9482, 39.0277)
cellSize <- 3
units <- 'miles'

test_that("geo_trianglegrid works", {
  aa <- geo_trianglegrid(extent, cellSize, units)
  aaj <- jsonlite::fromJSON(aa)

  expect_type(aa, "character")
  expect_type(aaj, "list")

  expect_named(aaj, c('features', 'type'))
  expect_named(aaj$features, c('geometry', 'properties', 'type'))
  expect_is(aaj$features, 'data.frame')
  expect_equal(aaj$type, 'FeatureCollection')

  expect_equal(aaj$features$type[1], 'Feature')
  expect_equal(aaj$features$geometry$type[1], 'Polygon')
})


test_that("geo_trianglegrid fails well", {
  expect_error(geo_trianglegrid(extent, cellSize, 5),
    class = "Rcpp::not_compatible")
               # "Expecting a single string value")
  expect_error(geo_trianglegrid(extent, 'asdf', 'miles'),
    class = "Rcpp::not_compatible")
               # "Not compatible with requested type")
})
