context("midpoint")

pt1 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [144.834823, -37.771257]
  }
}'
pt2 <- '{
  "type": "Feature",
  "properties": {},
  "geometry": {
    "type": "Point",
    "coordinates": [145.14244, -37.830937]
  }
}'

test_that("geo_midpoint works", {
  aa <- geo_midpoint(pt1, pt2)
  aaj <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aaj, "list")
  expect_equal(aaj$geometry$type, "Point")
  expect_equal(aaj$type, "Feature")
})
