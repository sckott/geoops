#' Get coordinates
#'
#' @export
#' @param x geojson string
#' @examples \dontrun{
#' x <- '{"type": "Feature", "geometry": {"type": "Point","coordinates": [1, 2]},"properties": {}}'
#' get_coords(x)
#' x <- '{"type": "Point", "coordinates": [1, 2]}'
#' get_coords(x)
#' x <- '[0, 5]'
#' get_coords(x)
#' }
get_coords <- function(x) {
  .Call("geoops_get_coords", PACKAGE = "geoops", x)
}
