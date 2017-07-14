context("version")

test_that("version works", {
  aa <- version()
  aaj <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aaj, "list")

  expect_named(aaj$compiler, c("c++", "family", "version"))
  expect_named(aaj$version, c("major", "minor", "patch", "string"))
})
