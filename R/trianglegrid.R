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
#' geo_trianglegrid(c(-77.3876, 38.7198, -76.9482, 39.0277), 3, "miles")
#' geo_trianglegrid(c(-77.3876, 38.7198, -76.9482, 39.0277), 10, "miles")
#' geo_trianglegrid(c(-77.3876, 38.7198, -76.9482, 39.0277), 30, "miles")
geo_trianglegrid <- function(bbox, cell_size, units = "kilometers") {
  triangleGrid(bbox, cell_size, units)
}
