#' Calculate nearest point to a reference point
#'
#' Takes a reference [Point] and a FeatureCollection of Features
#' with Point geometries and returns the point from the FeatureCollection
#' closest to the reference. This calculation is geodesic.
#'
#' @export
#' @param target_point the reference point [Feature]<[Point]>
#' @param points against input point set [FeatureCollection]<[Point]>
#' @return A [Feature]<[Point]> the closest point in the set to
#' the reference point
#' @examples
#' point1 <- '{
#'   "type": "Feature",
#'   "properties": {
#'      "marker-color": "#0f0"
#'    },
#'   "geometry": {
#'      "type": "Point",
#'      "coordinates": [28.965797, 41.010086]
#'   }
#' }'
#'
#' points <- '{
#'   "type": "FeatureCollection",
#'   "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [28.973865, 41.011122]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [28.948459, 41.024204]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [28.938674, 41.013324]
#'       }
#'     }
#'   ]
#' }'
#'
#' geo_nearest(point1, points)
geo_nearest <- function(target_point, points) {
  nearest(target_point, points)
}
