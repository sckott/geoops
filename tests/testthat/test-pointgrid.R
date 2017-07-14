context("pointgrid")

test_that("geo_pointgrid works", {
  extent <- c(-70.823364, -33.553984, -70.473175, -33.302986)
  cellSize <- 1
  units <- 'miles'

  aa <- geo_pointgrid(extent, cellSize, units)
  aaj <- jsonlite::fromJSON(aa)

  expect_type(aa, "character")
  expect_type(aaj, "list")

  expect_named(aaj, c('features', 'type'))
  expect_named(aaj$features, c('geometry', 'properties', 'type'))
  expect_is(aaj$features, 'data.frame')
  expect_equal(aaj$type, 'FeatureCollection')
})
