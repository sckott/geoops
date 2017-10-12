#' Calculate length of GeoJSON LineString or Polygon
#'
#' FIXME: doesn't support FeatureCollection's yet - fix c++ code
#'
#' @export
#' @param line a [LineString] to measure
#' @param units (character) Can be degrees, radians, miles, or
#' kilometers (default)
#' @return Single numeric value
#' @examples
#' # LineString
#' line <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "LineString",
#'     "coordinates": [
#'       [-77.031669, 38.878605],
#'       [-77.029609, 38.881946],
#'       [-77.020339, 38.884084],
#'       [-77.025661, 38.885821],
#'       [-77.021884, 38.889563],
#'       [-77.019824, 38.892368]
#'     ]
#'   }
#' }'
#'
#' geo_boolean_clockwise(line)
#' geo_boolean_clockwise_bool(line)
#' geo_boolean_clockwise(line)
geo_boolean_clockwise <- function(line) {
  boolean_clockwise_bool(line)
}
