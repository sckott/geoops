#' Calculate length of GeoJSON LineString or Polygon
#'
#' FIXME: doesn't support FeatureCollection's yet - fix c++ code
#'
#' @export
#' @param line a [LineString] to measure
#' @param units (character) Can be degrees, radians, miles, or
#' kilometers (default)
#' @return Single numeric value
#' @examples
#' # LineString
#' line <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "LineString",
#'     "coordinates": [
#'       [-77.031669, 38.878605],
#'       [-77.029609, 38.881946],
#'       [-77.020339, 38.884084],
#'       [-77.025661, 38.885821],
#'       [-77.021884, 38.889563],
#'       [-77.019824, 38.892368]
#'     ]
#'   }
#' }'
#'
#' geo_line_distance(line)
#' geo_line_distance(line, units = "miles")
#' geo_line_distance(line, units = "degrees")
#' geo_line_distance(line, units = "radians")
#'
#' # Polygon
#' x <- '{"type":"Feature","properties":{},"geometry":{"type":"Polygon",
#' "coordinates":[[[-67.031021,10.458102],[-67.031021,10.53372],
#' [-66.929397,10.53372],[-66.929397,10.458102],[-67.031021,10.458102]]]}}'
#'
#' geo_line_distance(x)
#'
#' # MultiPolygon
#' x <- '{
#'   "type": "Feature",
#'   "properties": {},
#'   "geometry": {
#'     "type": "MultiPolygon",
#'     "coordinates": [
#'       [
#'         [
#'           [
#'             -122.62527465820311,
#'             37.89327929625019
#'           ],
#'           [
#'             -122.60467529296875,
#'             37.902490518640995
#'           ],
#'           [
#'             -122.58682250976562,
#'             37.895988598965644
#'           ],
#'           [
#'             -122.62527465820311,
#'             37.89327929625019
#'           ]
#'         ]
#'       ],
#'       [
#'         [
#'           [
#'             -122.52639770507812,
#'             37.83473402375478
#'           ],
#'           [
#'             -122.53395080566405,
#'             37.83690319650768
#'           ],
#'           [
#'             -122.51541137695311,
#'             37.83473402375478
#'           ],
#'           [
#'             -122.52639770507812,
#'             37.83473402375478
#'           ]
#'         ]
#'       ],
#'       [
#'         [
#'           [
#'             -122.44331359863283,
#'             37.726194088705576
#'           ],
#'           [
#'             -122.47833251953125,
#'             37.73651223296987
#'           ],
#'           [
#'             -122.43095397949219,
#'             37.74411415606583
#'           ],
#'           [
#'             -122.40898132324217,
#'             37.77505678240509
#'           ],
#'           [
#'             -122.4103546142578,
#'             37.72184917678752
#'           ],
#'           [
#'             -122.44331359863283,
#'             37.726194088705576
#'           ]
#'         ]
#'       ]
#'     ]
#'   }
#' }'
#'
#' geo_line_distance(x)
geo_line_distance <- function(line, units = "kilometers") {
  lineDistance(line, units)
}
