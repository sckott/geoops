#' Pointgrid
#'
#' Takes a bounding box and a cell depth and returns a set of [Point]'s
#' in a grid.
#'
#' @export
#' @param bbox extent in `[minX, minY, maxX, maxY]` order
#' @param cell_size (numeric) the distance across each cell
#' @param units (character) used in calculating cellSize, can be degrees,
#' radians, miles, or kilometers (default)
#' @return [FeatureCollection]<[Point]> grid of points
#' @examples
#' extent <- c(-70.823364, -33.553984, -70.473175, -33.302986)
#' cellSize <- 1
#' units <- 'miles'
#' x <- geo_pointgrid(extent, cellSize, units)
#' x
geo_pointgrid <- function(bbox, cell_size, units = "kilometers") {
  pointGrid(bbox, cell_size, units)
}
