#' Bounding box
#'
#' @export
#' @param x input
#' @examples
#' library("lawn")
#' library("geojson")
#' geo_bbox(as.geojson(lawn_data$polygons_count))
#'
#' # x <- as.geojson(lawn_data$polygons_count)
#' # geojson::geo_bbox(x)
geo_bbox <- function(x) {
  geojson::geo_bbox(unclass(x))
}
