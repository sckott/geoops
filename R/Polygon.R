#' Polygon
#'
#' For type "Polygon", the "coordinates" member must be an array of LinearRing
#' coordinate arrays. For Polygons with multiple rings, the first must be the
#' exterior ring and any others must be interior rings or holes.
#'
#' @name Polygon
#' @family geo types
#' @examples
#' '{
#' "type": "Polygon",
#' "coordinates": [
#'   [
#'     [100.0, 0.0],
#'     [101.0, 0.0],
#'     [101.0, 1.0],
#'     [100.0, 1.0],
#'     [100.0, 0.0]
#'    ]
#'  ]
#' }'
NULL
