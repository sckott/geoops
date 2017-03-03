context("package fails well")

# test_that("sift_client fails well", {
#   skip_on_cran()
#
#   x <- "{\"type\":\"FeatureCollection\",\"features\":[{\"type\":\"Feature\",\"geometry\":{\"type\":\"Point\",\"coordinates\":[-99.74,32.45]},\"properties\":{}}]}"
#   x <- as.geojson(x)
#
#   expect_error(sift_client(x),
#                "argument \"query\" is missing, with no default")
#   expect_error(sift_client(x, 4),
#                "jq query specification must be character")
# })
#
# test_that("sifter fails well", {
#   skip_on_cran()
#
#   file <- system.file("examples", "zillow_or.geojson", package = "siftgeojson")
#   json <- paste0(readLines(file), collapse = "")
#
#   expect_equal(sifter(json, COUNTY == asadf), "[]")
#   expect_equal(sifter(json, asdfadf == Multnomah), "[]")
#
#   expect_error(sifter(5, COUNTY == Multnomah),
#                "no applicable method for 'sifter'")
#   expect_error(sifter(mtcars, COUNTY == Multnomah),
#                "no applicable method for 'sifter'")
# })
