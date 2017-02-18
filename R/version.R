#' Get json library version information
#'
#' @export
#' @return JSON as a string for now, will make a list soon
#' @examples
#' version()
version <- function() {
  .Call("geoops_version", PACKAGE = "geoops")
}
