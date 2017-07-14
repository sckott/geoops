#' Check if a Point is in a GeoJSON Ring
#'
#' @export
#' @param pt a point
#' @param ring a ring
#' @return boolean, `FALSE` if point is not in the ring, `TRUE` if it is
#' @examples \dontrun{
#' pt <- "[-77, 44]"
#' ring <- "[[10,59],[10.1,59.8],[10.3,60],[10.3,59],[10,59]]"
#' in_ring(pt, ring)
#'
#' pt <- "[10.17, 59.4]"
#' ring <- "[[10,59],[10.1,59.8],[10.3,60],[10.3,59],[10,59]]"
#' in_ring(pt, ring)
#' }
in_ring <- function(pt, ring) {
  .Call("geoops_in_ring", PACKAGE = "geoops", pt, ring)
}
