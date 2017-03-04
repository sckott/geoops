#' FeatureCollection
#'
#' A GeoJSON object with the type "FeatureCollection" is a feature collection
#' object. An object of type "FeatureCollection" must have a member with the
#' name "features". The value corresponding to "features" is an array. Each
#' element in the array is a feature object as defined above.
#'
#' @name FeatureCollection
#' @family geo types
#' @examples
#' '{
#'   "type": "FeatureCollection",
#'   "features": [
#'     {
#'       "type": "Feature",
#'       "properties": {
#'         "population": 200
#'       },
#'       "geometry": {
#'         "type": "Point",
#'         "coordinates": [-112.0372, 46.608058]
#'       }
#'     }
#'   ]
#' }'
NULL
