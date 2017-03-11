#' Midpoint
#'
#' Takes two [Point]'s and returns a point midway between them.
#' The midpoint is calculated geodesically, meaning the curvature of
#' the earth is taken into account.
#'
#' @export
#' @param from [Feature]<[Point]> first point
#' @param to [Feature]<[Point]> second point
#' @return [Feature]<[Point]> a point midway between `from` and `to`
#' @examples
#' pt1 <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [144.834823, -37.771257]
#'   }
#' }'
#' pt2 <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [145.14244, -37.830937]
#'   }
#' }'
#'
#' geo_midpoint(pt1, pt2)
geo_midpoint <- function(from, to) {
  midpoint(from, to)
}
