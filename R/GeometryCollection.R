#' GeometryCollection
#'
#' Each element in the geometries array of a GeometryCollection is one of the
#' geometry objects described above.
#'
#' @name GeometryCollection
#' @family geo types
#' @examples
#' '{
#'    "type": "GeometryCollection",
#'    "geometries": [ {
#'      "type": "Point",
#'      "coordinates": [100.0, 0.0]
#'    }, {
#'    "type": "LineString",
#'    "coordinates": [ [101.0, 0.0], [102.0, 1.0] ]
#'    }
#'  ]
#' }'
NULL
