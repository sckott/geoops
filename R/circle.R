#' Takes a {@link Point} and calculates the circle polygon given a radius
#' in degrees, radians, miles, or kilometers; and steps for precision.
#'
#' @export
#' @param {Feature<Point>} center center point
#' @param {number} radius radius of the circle
#' @param {number} [steps=64] number of steps
#' @param {string} [units=kilometers] miles, kilometers, degrees, or radians
#' @returns {Feature<Polygon>} circle polygon
#' @example
#' var center = point([-75.343, 39.984]);
#' var radius = 5;
#' var steps = 10;
#' var units = 'kilometers';
#'
#' circle(center, radius, steps, units)
geo_circle <- function(x) {
  circle(x)
}
