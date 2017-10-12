#' Hexgrid
#'
#' Takes a bounding box and the diameter of the cell and returns a
#' [FeatureCollection] of flat-topped hexagons or triangles ([Polygon]
#' features) aligned in an "odd-q" vertical grid as described in
#' [Hexagonal Grids](http://www.redblobgames.com/grids/hexagons/)
#'
#' @export
#' @param bbox extent in `[minX, minY, maxX, maxY]` order
#' @param cell_diameter (numeric) diameter of the circumcircle of the
#' hexagons, in specified units
#' @param triangles (boolean) whether to return as triangles instead of
#' hexagons. Default: `FALSE`
#' @param units (character) used in calculating cell size, can be degrees,
#' radians, miles, or kilometers (default)
#' @return [FeatureCollection]<[Polygon]> a hexagonal grid
#' @examples
#' bbox <- c(-96, 31, -84, 40)
#' cellDiameter <- 50
#' units <- 'miles'
#'
#' hexgrid = turf.hexGrid(bbox, cellDiameter, units)
geo_hexgrid <- function(bbox, cell_diameter, triangles = FALSE,
                        units = "kilometers") {
  hexGrid(bbox, cell_diameter, triangles, units)
}

#hex_triangles(c(30, 10), 4, 5)
