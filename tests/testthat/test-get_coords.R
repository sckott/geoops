context("get_coords")

test_that("get_coords works", {
  x <- '{"type": "Feature", "geometry": {"type": "Point","coordinates": [1, 2]},"properties": {}}'
  aa <- get_coords(x)
  bb <- get_coords('{"type": "Point", "coordinates": [1, 2]}')
  cc <- get_coords('[0, 5]')

  expect_is(aa, "character")
  expect_is(bb, "character")
  expect_is(cc, "character")

  expect_equal(jsonlite::fromJSON(aa), 1:2)
  expect_equal(jsonlite::fromJSON(bb), 1:2)
  expect_equal(jsonlite::fromJSON(cc), c(0, 5))
})

test_that("fails well", {
  # expect_error(geo_get_coords('[5]'), "coordinates must only contain numbers")
  expect_error(geo_get_coords('[5]'), class = "std::runtime_error")
})
