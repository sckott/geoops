#' Calculate bearing
#'
#' @export
#' @param point1 start geojson [Feature]<[Point]>
#' @param point2 end geojson [Feature]<[Point]>
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
#' geo_bearing(point1, point2)
geo_bearing <- function(point1, point2) {
  bearing(point1, point2)
}
