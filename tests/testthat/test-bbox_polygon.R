context("bbox_polygon")

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

test_that("geo_bbox_polygon works", {
  aa <- geo_bbox_polygon(c(0, 0, 10, 10))
  bb <- geo_bbox_polygon(c(-90, -30, -70, -10))
  cc <- geo_bbox_polygon(c(0, 0, 10, 10))
  aaj <- jsonlite::fromJSON(aa)
  bbj <- jsonlite::fromJSON(bb)
  ccj <- jsonlite::fromJSON(cc)

  expect_is(aa, "character")
  expect_is(bb, "character")
  expect_is(cc, "character")

  expect_is(aaj, "list")
  expect_equal(aaj$geometry$type, "Polygon")
  expect_equal(aaj$type, "Feature")
  expect_equal(dim(aaj$geometry$coordinates)[2], 5)

  expect_is(bbj, "list")
  expect_equal(bbj$geometry$type, "Polygon")
  expect_equal(bbj$type, "Feature")
  expect_equal(dim(aaj$geometry$coordinates)[2], 5)

  expect_is(ccj, "list")
  expect_equal(ccj$geometry$type, "Polygon")
  expect_equal(ccj$type, "Feature")
  expect_equal(dim(ccj$geometry$coordinates)[2], 5)
})
