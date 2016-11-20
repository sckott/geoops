#' Bounding box
#'
#' @export
#' @param x input
#' @examples
#' library("lawn")
#' library("geojson")
#' bound_box(as.geojson(lawn_data$polygons_count))
#'
#' x <- as.geojson(lawn_data$polygons_count)
#' geojson::geo_bbox(x)
bound_box <- function(x) {
  #lawn::lawn_extent(x)
  geojson::geo_bbox(unclass(x))
}
