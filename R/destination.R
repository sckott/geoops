#' Calculate a destination
#'
#' @export
#' @param from (character) from starting [Feature]<[Point]>
#' @param distance (numeric) distance from the starting [Feature]<[Point]>
#' @param bearing (numeric) ranging from -180 to 180
#' @param units (character) miles, kilometers, degrees, or radians
#' @return (character) destination [Feature]<[Point]>
#' @examples
#' point <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "marker-color": "#0f0"
#'    },
#'    "geometry": {
#'       "type": "Point",
#'       "coordinates": [-75.343, 39.984]
#'    }
#' }'
#' geo_destination(point, 50, 90, 'miles')
#' geo_destination(point, 200, 90)
geo_destination <- function(from, distance, bearing, units = 'kilometers') {
  destination(from, distance, bearing, units)
}
