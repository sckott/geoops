#' Calculate bearing
#'
#' @export
#' @param point1 start geojson point
#' @param point2 end geojson point
#' @return (number) bearing in decimal degrees
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
#' bearing(point1, point2)
bearing <- function(point1, point2) {
  .Call("geoops_bearing", PACKAGE = "geoops", point1, point2)
}
