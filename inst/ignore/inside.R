#' Inside
#'
#' Takes a [Point] and a [Polygon] or [MultiPolygon] and determines if
#' the point resides inside the polygon. The polygon can be convex
#' or concave. The function accounts for holes.
#'
#' @export
#' @param point (character) geojson point
#' @param polygon (character) geojson polygon or multipolygon
#' @param ignore_boundary (logical) `TRUE` if polygon boundary should be
#' ignored when determining if the point is inside the polygon.
#' Default: `FALSE`
#' @return (logical) `TRUE` if the Point is inside the Polygon; `FALSE` if
#' the Point is not inside the Polygon
#' @examples \dontrun{
#' point <- c(-77, 44)
#' point <- "[-77, 44]"
#' point <- "[10.17, 59.4]"
#' #polygon <- "[[-81,41],[-81,47],[-72,47],[-72,41],[-81,41]]"
#' polygon <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [10.0, 59.0],
#'       [10.1, 59.8],
#'       [10.3, 60],
#'       [10.3, 59],
#'       [10.0, 59.0]
#'     ]]
#'   }
#' }'
#' # geo_inside(point, polygon)
#'
#' point <- "[-77, 44]"
#' point <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Point",
#'     "coordinates": [ -77, 44 ]
#'   }
#' }'
#' polygon <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "Polygon",
#'     "coordinates": [[
#'       [-81, 41],
#'       [-81, 47],
#'       [-72, 47],
#'       [-72, 41],
#'       [-81, 41]
#'     ]]
#'   }
#' }'
#' # stuff(point, polygon)
#' # geo_inside(point, polygon)
#' }
geo_inside <- function(point, polygon, ignore_boundary = FALSE) {
  #inside_cpp(point, polygon, ignore_boundary)
  stop("not working quite yet", call. = FALSE)
}
