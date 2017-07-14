context("nearest")

point1 <- '{
  "type": "Feature",
  "properties": {
     "marker-color": "#0f0"
   },
  "geometry": {
     "type": "Point",
     "coordinates": [28.965797, 41.010086]
  }
}'

points <- '{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": [28.973865, 41.011122]
      }
    }, {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": [28.948459, 41.024204]
      }
    }, {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": [28.938674, 41.013324]
      }
    }
  ]
}'

test_that("geo_nearest works", {
  aa <- geo_nearest(point1, points)
  aaj <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aaj, "list")
  expect_equal(aaj$geometry$type, "Point")
  expect_equal(length(aaj$geometry$coordinates), 2)
  expect_equal(aaj$type, "Feature")
})
