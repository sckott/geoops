#' LineString
#'
#' For type "LineString", the "coordinates" member must be an array of two or
#' more positions. A LinearRing is closed LineString with 4 or more positions.
#' The first and last positions are equivalent (they represent equivalent
#' points). Though a LinearRing is not explicitly represented as a GeoJSON
#' geometry type, it is referred to in the Polygon geometry type definition.
#'
#' @name LineString
#' @family geo types
#' @examples
#' '{
#'    "type": "LineString",
#'    "coordinates": [
#'       [100.0, 0.0],
#'       [101.0, 1.0]
#'    ]
#' }'
NULL
