#' Trianglegrid
#'
#' Takes a bounding box and a cell depth and returns a set of [Polygon]'s
#' in a grid.
#'
#' @export
#' @param bbox extent in `[minX, minY, maxX, maxY]` order
#' @param cell_size (numeric) the distance across each cell
#' @param units (character) used in calculating cellSize, can be degrees,
#' radians, miles, or kilometers (default)
#' @return [FeatureCollection]<[Polygon]> grid of polygons
#' @examples
#' extent <- c(-96, 31, -84, 40)
#' cell_size <- 10
#' units <- "miles"
#' x <- geo_trianglegrid(extent, cell_size, units)
#' x
geo_trianglegrid <- function(bbox, cell_size, units = "kilometers") {
  triangleGrid(bbox, cell_size, units)
}
