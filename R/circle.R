#' Takes a [Point] and calculates the circle polygon given a radius
#' in degrees, radians, miles, or kilometers; and steps for precision.
#'
#' @export
#' @param center [Feature]<[Point]> center point
#' @param radius (numeric) radius of the circle
#' @param steps (numeric) number of steps. default: 64
#' @param units (character) miles, kilometers, degrees, or
#' radians
#' @return [Feature]<[Polygon]> circle polygon
#' @examples
#' # circle(center, radius, steps, units)
geo_circle <- function(center, radius, steps, units = "kilometers") {
  circle3(center, radius, steps, units)
}
