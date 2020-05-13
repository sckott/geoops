context("line_distance")

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

test_that("destination works well", {
  expect_is(geo_line_distance(line), "numeric")
  expect_type(geo_line_distance(line), "double")
  expect_gt(geo_line_distance(line), 0)

  expect_gte(geo_line_distance(line, 'miles'), 1.6)
  expect_lte(geo_line_distance(line, 'radians'), 0.001)
})

badline <- '{
  "type": "feature",
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

test_that("line_distance fails well", {
  expect_error(
    geo_line_distance(badline),
    class = "std::runtime_error"
    # "input must be a LineString, "
  )

  expect_error(
    geo_line_distance(),
    "argument \"line\" is missing"
  )
})
