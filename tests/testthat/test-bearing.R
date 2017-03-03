context("bearing")

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

point2 <- '{
  "type": "Feature",
  "properties": {
     "marker-color": "#0f0"
   },
   "geometry": {
      "type": "Point",
      "coordinates": [-75.534, 39.123]
    }
}'

point3 <- '{
  "type": "Feature",
  "properties": {
     "marker-color": "#0f0b"
   },
   "geometry": {
      "type": "Point",
      "coordinates": [-65.534, 49.123]
    }
}'

test_that("bearing works well", {
  expect_is(geo_bearing(point1, point2), "numeric")
  expect_type(geo_bearing(point1, point2), "double")
  expect_lt(geo_bearing(point1, point2), 0)

  expect_is(geo_bearing(point1, point3), "numeric")
  expect_type(geo_bearing(point1, point3), "double")
  expect_gt(geo_bearing(point1, point3), 0)
})
