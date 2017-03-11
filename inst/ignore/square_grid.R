#' Takes a bounding box and a cell depth and returns a set of square
#' [Polygon] in a grid.
#'
#' @export
#' @param bbox (numeric) extent in `[minX, minY, maxX, maxY]` order
#' @param cell_size (numeric) width of each cell
#' @param units (character) used in calculating cellSize, can be degrees,
#' radians, miles, or kilometers (default)
#' @return [FeatureCollection]<[Polygon]> a grid of polygons
#' @examples
#' bbox <- c(-96, 31, -84, 40)
#' cellSize <- 10
#' units <- 'miles'
#'
#' geo_square_grid(bbox, cellSize, units)
geo_square_grid <- function(bbox, cell_size, units = "kilometers") {
  squareGrid(bbox, cell_size, units)
}
