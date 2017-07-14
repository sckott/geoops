context("planepoint")

point <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [-75.3221, 39.529]
  }
}'
triangle <- '{
  "type": "Feature",
  "properties": {
    "a": 11,
    "b": 122,
    "c": 44
  },
  "geometry": {
    "type": "Polygon",
    "coordinates": [[
      [-75.1221, 39.57],
      [-75.58, 39.18],
      [-75.97, 39.86],
      [-75.1221, 39.57]
    ]]
  }
}'

test_that("geo_planepoint works", {
  aa <- geo_planepoint(point, triangle)

  expect_type(aa, "double")
  expect_gt(aa, 0)
})
