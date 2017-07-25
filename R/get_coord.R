#' Get coordinates
#'
#' @export
#' @param x geojson string
#' @return a string, with coordinates as a JSON array
#' @examples \dontrun{
#' x <- '{"type": "Feature", "geometry": {"type": "Point","coordinates": [1, 2]},"properties": {}}'
#' get_coords(x)
#' x <- '{"type": "Point", "coordinates": [1, 2]}'
#' get_coords(x)
#' x <- '[0, 5]'
#' get_coords(x)
#' }
get_coords <- function(x) {
  get_coords(x)
}
