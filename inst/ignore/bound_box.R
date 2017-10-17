#' Bounding box
#'
#' @export
#' @param x input
#' @examples
#' x <- '{
#'    "type": "FeatureCollection",
#'    "features": [
#'        {
#'            "type": "Feature",
#'            "properties": {
#'
#'            },
#'            "geometry": {
#'                "type": "Polygon",
#'                "coordinates": [
#'                    [
#'                        [
#'                            -112.072391,
#'                            46.586591
#'                        ],
#'                        [
#'                            -112.072391,
#'                            46.61761
#'                        ],
#'                        [
#'                            -112.028102,
#'                            46.61761
#'                        ],
#'                        [
#'                            -112.028102,
#'                            46.586591
#'                        ],
#'                        [
#'                            -112.072391,
#'                            46.586591
#'                        ]
#'                    ]
#'                ]
#'            }
#'        },
#'        {
#'            "type": "Feature",
#'            "properties": {
#'
#'            },
#'            "geometry": {
#'                "type": "Polygon",
#'                "coordinates": [
#'                    [
#'                        [
#'                            -112.023983,
#'                            46.570426
#'                        ],
#'                        [
#'                            -112.023983,
#'                            46.615016
#'                        ],
#'                        [
#'                            -111.966133,
#'                            46.615016
#'                        ],
#'                        [
#'                            -111.966133,
#'                            46.570426
#'                        ],
#'                        [
#'                            -112.023983,
#'                            46.570426
#'                        ]
#'                    ]
#'                ]
#'            }
#'        }
#'    ]
#' }'
#' # geo_bbox(x)
geo_bbox <- function(x) {
  #geojson::geo_bbox(unclass(x))
}
