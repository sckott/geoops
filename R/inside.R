#' Inside
#'
#' @export
#' @param point geojson point
#' @param polygon  geojson polygon
#' @examples
#' #pt <- c(-77, 44)
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
#' geo_inside(point, polygon)
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
#' stuff(point, polygon)
#' geo_inside(point, polygon)
geo_inside <- function(point, polygon) {
  # .Call("geoops_inside_cpp", PACKAGE = "geoops", point, polygon)
  stop("not working quite yet", call. = FALSE)
}

# stuff <- function(point, polygon) {
#   .Call("geoops_fart_cpp", PACKAGE = "geoops", point, polygon)
# }
