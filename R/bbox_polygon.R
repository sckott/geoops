#' BBOX polygon
#'
#' Takes a bbox and returns an equivalent [Feature]<[Polygon]>
#'
#' @export
#' @param bbox extent in `[minX, minY, maxX, maxY]` order
#' @return [Feature]<[Polygon]> a Polygon representation of the bounding box
#' @examples
#' geo_bbox_polygon(c(0, 0, 10, 10))
#' geo_bbox_polygon(c(-90, -30, -70, -10))
#' geo_bbox_polygon(c(0, 0, 10, 10))
geo_bbox_polygon <- function(bbox) {
  bbox_polygon(bbox)
}
