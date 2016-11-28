#' Get coordinates
#'
#' @export
#' @param x geojson string
#' @examples \dontrun{
#' x <- '{"type": "Feature", "geometry": {"type": "Point","coordinates": [1, 2]},"properties": {}}'
#' get_coord(x)
#' x <- '{"type": "Point", "coordinates": [1, 2]}'
#' get_coord(x)
#' x <- '[0, 5]'
#' get_coord(x)
#' }
get_coord <- function(x) {
  .Call("geoops_get_coord", PACKAGE = "geoops", x)
}
