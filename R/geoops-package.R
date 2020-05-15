#' @title geoops
#'
#' @description Tools for doing calculations and manipulations on GeoJSON,
#' a 'geospatial' data interchange format (https://tools.ietf.org/html/rfc7946).
#' GeoJSON is also valid JSON.
#'
#' @examples
#' library("geoops")
#'
#' # Calculate distance between two GeoJSON points
#' pt1 <- '{
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
#' pt2 <- '{
#'   "type": "Feature",
#'   "properties": {
#'      "marker-color": "#0f0"
#'    },
#'    "geometry": {
#'       "type": "Point",
#'       "coordinates": [-75.534, 39.123]
#'     }
#' }'
#' geo_distance(pt1, pt2)
#'
#' @useDynLib geoops
#' @importFrom Rcpp sourceCpp
#' @name geoops-package
#' @aliases geoops
#' @docType package
#' @keywords package
#' @author Scott Chamberlain \email{myrmecocystus+r@@gmail.com}
NULL
