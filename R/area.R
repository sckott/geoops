#' Takes one or more features and returns their area
#' in square meters.
#'
#' @export
#' @param x (character) a [Feature] or [FeatureCollection]
#' @return (numeric) area in square meters
#' @examples
#' polygons <- '{
#'   "type": "FeatureCollection",
#'   "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Polygon",
#'         "coordinates": [[
#'           [-67.031021, 10.458102],
#'           [-67.031021, 10.53372],
#'           [-66.929397, 10.53372],
#'           [-66.929397, 10.458102],
#'           [-67.031021, 10.458102]
#'         ]]
#'       }
#'     }, {
#'       "type": "Feature",
#'       "properties": {},
#'       "geometry": {
#'         "type": "Polygon",
#'         "coordinates": [[
#'           [-66.919784, 10.397325],
#'           [-66.919784, 10.513467],
#'           [-66.805114, 10.513467],
#'           [-66.805114, 10.397325],
#'           [-66.919784, 10.397325]
#'         ]]
#'       }
#'     }
#'   ]
#' }'
#' geo_area(polygons)
geo_area <- function(x) area(x)
