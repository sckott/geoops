#' Calculate distance between two GeoJSON points
#'
#' @export
#' @param from Origin [Feature]<[Point]>
#' @param to Destination [Feature]<[Point]>
#' @param units (character) Can be degrees, radians, miles, or
#' kilometers (default)
#' @return the distance, a single numeric value, in units given
#' in `units` parameter
#' @examples
#' point1 <- '{
#'   "type": "Feature",
#'   "properties": {
#'     "marker-color": "#f00"
#'    },
#'    "geometry": {
#'       "type": "Point",
#'       "coordinates": [-75.343, 39.984]
#'    }
#' }'
#'
#' point2 <- '{
#'   "type": "Feature",
#'   "properties": {
#'      "marker-color": "#0f0"
#'    },
#'    "geometry": {
#'       "type": "Point",
#'       "coordinates": [-75.534, 39.123]
#'     }
#' }'
#'
#' geo_distance(point1, point2)
#' geo_distance(point1, point2, units = "miles")
#' geo_distance(point1, point2, units = "degrees")
#' geo_distance(point1, point2, units = "radians")
#'
#' pt1 <- '{
#'   "type": "Feature",
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [
#'        0.5,
#'        0.5
#'      ]
#'    }
#' }'
#'
#' pt2 <- '{
#'   "type": "Feature",
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [2, 2]
#'    }
#' }'
#'
#' geo_distance(pt1, pt2, units = "miles")
geo_distance <- function(from, to, units = "kilometers") {
  distance(from, to, units)
}
