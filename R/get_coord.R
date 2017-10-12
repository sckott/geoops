#' Get coordinates
#'
#' @export
#' @param x geojson string
#' @return a numeric vector with coordinates
#' @examples \dontrun{
#' x <- '{"type": "Feature", "geometry": {"type": "Point","coordinates": [1, 2]},"properties": {}}'
#' geo_get_coords(x)
#' x <- '{"type": "Point", "coordinates": [1, 2]}'
#' geo_get_coords(x)
#' x <- '[0, 5]'
#' geo_get_coords(x)
#' # x <- '[5]'
#' # geo_get_coords(x)
#' }
geo_get_coords <- function(x) {
  jsonlite::fromJSON(get_coords(x))
}
