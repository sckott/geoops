context("distance")

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

test_that("geo_bbox_polygon works", {
  aa <- geo_distance(point1, point2)
  bb <- geo_distance(point1, point2, units = "miles")
  cc <- geo_distance(point1, point2, units = "degrees")
  dd <- geo_distance(point1, point2, units = "radians")

  expect_type(aa, "double")
  expect_type(bb, "double")
  expect_type(cc, "double")
  expect_type(dd, "double")

  expect_equal(round(aa), 97)
  expect_equal(round(bb), 60)
  expect_lt(cc, 1)
  expect_equal(round(cc), 1)
  expect_lt(dd, 1)
  expect_equal(round(dd), 0)
})
