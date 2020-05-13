context("destination")

point1 <- '{
  "type": "Feature",
  "properties": {
    "marker-color": "#f00"
   },
   "geometry": {
      "type": "Point",
      "coordinates": [-75.343, 39.984]
   }
}'

test_that("destination works well", {
  expect_is(geo_destination(point1, 50, 90, 'miles'), "character")
  expect_match(geo_destination(point1, 50, 90, 'miles'), "geometry")
  expect_match(geo_destination(point1, 50, 90, 'miles'), "coordinates")
  expect_match(geo_destination(point1, 50, 90, 'miles'), "Feature")
})

test_that("destination fails well", {
  # expect_error(geo_destination(point1, 50, 90, 'stuff'), "Invalid 'units' input")
  expect_error(geo_destination(point1, 50, 90, 'stuff'), class = "std::runtime_error")
  # expect_error(geo_destination(point1, 50, "foobar"),
  #              "Not compatible with requested type")
  expect_error(geo_destination(point1, 50, "foobar"),
               class = "Rcpp::not_compatible")

  expect_error(geo_destination(),
               "argument \"from\" is missing, with no default")
  expect_error(geo_destination(point1, 50),
               "argument \"bearing\" is missing, with no default")
  expect_error(geo_destination(point1, 50),
               "argument \"bearing\" is missing, with no default")
  expect_error(geo_destination(point1, bearing = 50),
               "argument \"distance\" is missing, with no default")
})
