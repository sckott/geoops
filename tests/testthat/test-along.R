context("along")

line <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "LineString",
    "coordinates": [
      [-77.031669, 38.878605],
      [-77.029609, 38.881946],
      [-77.020339, 38.884084],
      [-77.025661, 38.885821],
      [-77.021884, 38.889563],
      [-77.019824, 38.892368]
    ]
  }
}'

test_that("geo_along works", {
  aa <- geo_along(line, 10, 'kilometers')
  aaa <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_match(aa, "coordinates")

  expect_is(aaa, "list")
  expect_equal(aaa$geometry$type, "Point")
  expect_equal(aaa$type, "Feature")
  expect_equal(length(aaa$properties), 0)
})
