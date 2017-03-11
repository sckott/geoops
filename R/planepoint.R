#' Planepoint
#'
#' Takes a triangular plane as a [Polygon] and a [Point] within that
#' triangle and returns the z-value at that point. The Polygon needs to
#' have properties `a`, `b`, and `c` that define the values at its
#' three corners.
#'
#' @export
#' @param point [Feature]<[Point]> the Point for which a z-value will be
#' calculated
#' @param triangle [Feature]<[Polygon]> a Polygon feature with three vertices
#' @return (numeric) the z-value for `interpolatedPoint`
#' @examples
#' point <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [-75.3221, 39.529]
#'   }
#' }'
#'
#' triangle <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "a": 11,
#'     "b": 122,
#'     "c": 44
#'   },
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-75.1221, 39.57],
#'       [-75.58, 39.18],
#'       [-75.97, 39.86],
#'       [-75.1221, 39.57]
#'     ]]
#'   }
#' }'
#'
#' geo_planepoint(point, triangle)
geo_planepoint <- function(point, triangle) {
  planepoint(point, triangle)
}
