#' Get coordinates
#'
#' @export
#' @name playing
#' @param x stuff
#' @examples \dontrun{
#' x <- '{"type": "Feature", "geometry": {"type": "Point","coordinates": [1, 2]},"properties": {}}'
#' get_coord(x)
#' x <- '{"type": "Point", "coordinates": [1, 2]}'
#' get_coord(x)
#' x <- '[0, 5]'
#' get_coord(x)
#'
#' # get_coord(x)
#' # get_str(x)
#' # get_json()
#' # parse_type(x)
#'
#' # in ring
#' pt <- "[-77, 44]"
#' ring <- "[[10,59],[10.1,59.8],[10.3,60],[10.3,59],[10,59]]"
#' in_ring(pt, ring)
#'
#' pt <- "[10.17, 59.4]"
#' ring <- "[[10,59],[10.1,59.8],[10.3,60],[10.3,59],[10,59]]"
#' in_ring(pt, ring)
#' }

get_str <- function(x) {
  .Call("geoops_rcpp_str", PACKAGE = "geoops", x)
}

# get_coord <- function(x) {
#   .Call("geoops_get_coord", PACKAGE = "geoops", x)
# }

get_json <- function() {
  .Call("geoops_rcpp_json", PACKAGE = "geoops")
}

parse_type <- function(x) {
  .Call("geoops_rcpp_type", PACKAGE = "geoops", x)
}

parse_ifelse <- function(x) {
  .Call("geoops_rcpp_ifelse", PACKAGE = "geoops", x)
}

parse_bools <- function(x) {
  .Call("geoops_rcpp_bools", PACKAGE = "geoops", x)
}

in_ring <- function(x, y) {
  .Call("geoops_in_ring", PACKAGE = "geoops", x, y)
}
