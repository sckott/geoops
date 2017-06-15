#' Takes a [LineString] and returns a [Point] at a specified
#' distance along the line.
#'
#' @export
#' @param line (character) a [Feature]<[LineString]>
#' @param distance (numeric) distance along the line
#' @param units (character) can be degrees, radians, miles, or
#' kilometers (default)
#' @return [Feature]<[Point]> distance (at X units) along the line
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
#'
#' geo_along(line, 10, 'kilometers')
geo_along <- function(line, distance, units) {
  along(line, distance, units)
}
