#' Takes a \code{LineString} or \code{Polygon} and measures its length in
#' the specified units.
#'
#' @export
#' @param line (Feature [LineString|Polygon] or
#' FeatureCollection [LineString|Polygon]) line line to measure
#' @param units (string) [units=kilometers] can be degrees, radians, miles, or
#' kilometers
#' @return (number) length of the input line
#' @examples
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
#' len <- geo_line_distance(line, 'miles');
geo_line_distance <- function(line, units) {
  #line_distance(line, units)
}
