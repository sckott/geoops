#' Feature
#'
#' A GeoJSON object with the type "Feature" is a feature object:
#' \itemize{
#'  \item A feature object must have a member with the name "geometry". The
#'  value of the geometry member is a geometry object as defined above or a
#'  JSON null value.
#'  \item A feature object must have a member with the name "properties". The
#'  value of the properties member is an object (any JSON object or a JSON null
#'  value).
#'  \item If a feature has a commonly used identifier, that identifier should
#'  be included as a member of the feature object with the name "id".
#' }
#'
#' @name Feature
#' @family geo types
#' @examples
#' '{
#'   "type": "Feature",
#'   "properties": {
#'     "population": 200
#'   },
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [10.724029, 59.926807]
#'   }
#' }'
NULL
