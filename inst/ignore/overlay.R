#' Overlay
#'
#' Clip a set of points to a polygon
#'
#' @export
#' @param points geojson points
#' @param polygons geojson polygons
#' @examples
#' library("lawn")
#' lawn_data$points_within %>% view
#' overlay(
#'   points = lawn_data$points_within,
#'   polygons = lawn_data$polygons_within) %>% view
#'
#'
overlay <- function(points, polygons) {
  with_in(points, polygons)
}

# within ------------------------

# points <- '{
#  "type": "FeatureCollection",
#  "features": [
#    {
#      "type": "Feature",
#      "properties": {},
#      "geometry": {
#        "type": "Point",
#        "coordinates": [-46.6318, -23.5523]
#      }
#    }, {
#      "type": "Feature",
#      "properties": {},
#      "geometry": {
#        "type": "Point",
#        "coordinates": [-46.6246, -23.5325]
#      }
#    }, {
#      "type": "Feature",
#      "properties": {},
#      "geometry": {
#        "type": "Point",
#        "coordinates": [-46.6062, -23.5513]
#      }
#    }, {
#      "type": "Feature",
#      "properties": {},
#      "geometry": {
#        "type": "Point",
#        "coordinates": [-46.663, -23.554]
#      }
#    }, {
#      "type": "Feature",
#      "properties": {},
#      "geometry": {
#        "type": "Point",
#        "coordinates": [-46.643, -23.557]
#      }
#    }
#  ]
# }'
# search_within <- '{
#   "type": "FeatureCollection",
#   "features": [
#     {
#       "type": "Feature",
#       "properties": {},
#       "geometry": {
#         "type": "Polygon",
#         "coordinates": [[
#           [-46.653,-23.543],
#           [-46.634,-23.5346],
#           [-46.613,-23.543],
#           [-46.614,-23.559],
#           [-46.631,-23.567],
#           [-46.653,-23.560],
#           [-46.653,-23.543]
#         ]]
#       }
#     }
#   ]
# }'
# with_in(points, polygons = search_within)

with_in <- function(points, polygons) {
  points_within <- '{ "type": "FeatureCollection", "features": [] }'
  i <- 0
  while (i < cchar(jq(polygons, ".features | length"))) {

    j <- 0
    while (j < cchar(jq(points, ".features | length"))) {
      is_inside <- inside(
        jq(points, sprintf(".features[%s]", j)),
        jq(polygons, sprintf(".features[%s]", i))
      )
      if (is_inside) {
        points_within <- jq(
          points_within,
          sprintf(
            '.features |= (.+ [%s] | unique)',
            jq(points, sprintf(".features[%s]", j))
          )
        )
      }
      j <- j + 1
    }

    i <- i + 1
  }

  return(unclass(points_within))
}

# inside ------------------------

# #pt <- c(-77, 44)
# point <- "[-77, 44]"
# point <- "[10.17, 59.4]"
# #polygon <- "[[-81,41],[-81,47],[-72,47],[-72,41],[-81,41]]"
# polygon <- '{
#   "type": "Feature",
#   "properties": {},
#   "geometry": {
#     "type": "Polygon",
#     "coordinates": [[
#       [10.0, 59.0],
#       [10.1, 59.8],
#       [10.3, 60],
#       [10.3, 59],
#       [10.0, 59.0]
#     ]]
#   }
# }'
# inside(point, polygon)
#
# point <- "[-77, 44]"
# point <- '{
#   "type": "Feature",
#   "properties": {},
#   "geometry": {
#     "type": "Point",
#     "coordinates": [ -77, 44 ]
#   }
# }'
# polygon <- '{
#   "type": "Feature",
#   "properties": {},
#   "geometry": {
#     "type": "Polygon",
#     "coordinates": [[
#       [-81, 41],
#       [-81, 47],
#       [-72, 47],
#       [-72, 41],
#       [-81, 41]
#     ]]
#   }
# }'
# inside(point, polygon)

inside <- function(point, polygon) {
  pt <- get_coord(point)
  polys <- cchar(jq(polygon, ".geometry.coordinates"))

  # normalize to multipolygon
  if (cchar(jq(polygon, ".geometry.type")) == 'Polygon') {
    polys <- sprintf('[%s]', polys)
  }

  inside_poly <- FALSE
  i <- 0
  while (i < cchar(jq(polys, "length")) && !inside_poly) {
    if (in_ring(pt, jq(polys, sprintf('.[%s][0]', i)))) {
      in_hole <- FALSE
      k <- 1
      # check for the point in any of the holes
      while (k < jq(polys, sprintf('.[%s] | length', i)) && !in_hole) {
        if (in_ring(pt, jq(polys, sprintf('.[%s][%s]', i, k)))) {
          in_hole <- TRUE
        }
        k <- k + 1
      }
      if (!in_hole) inside_poly <- TRUE
    }
    i <- i + 1
  }
  return(inside_poly)
}


# in_ring ------------------------

#pt <- "[-77, 44]"
#ring <- "[[10,59],[10.1,59.8],[10.3,60],[10.3,59],[10,59]]"
# in_ring(pt, ring)

#pt <- "[10.17, 59.4]"
#ring <- "[[10,59],[10.1,59.8],[10.3,60],[10.3,59],[10,59]]"
# in_ring(pt, ring)

in_ring <- function(pt, ring) {
  is_inside <- FALSE
  i <- 0
  j <- as.numeric(jq(ring, "length")) - 1
  while (i < jq(ring, "length")) {
    xi <- as.numeric(jq(ring, sprintf(".[%s][0]", i)))
    yi <- as.numeric(jq(ring, sprintf(".[%s][1]", i)))
    xj <- as.numeric(jq(ring, sprintf(".[%s][0]", j)))
    yj <- as.numeric(jq(ring, sprintf(".[%s][1]", j)))
    intersect <-
    (
      (yi > as.numeric(jq(pt, '.[1]'))) != (yj > as.numeric(jq(pt, '.[1]')))
    ) && (
      as.numeric(jq(pt, '.[0]')) < (xj - xi) * (as.numeric(jq(pt, '.[1]')) - yi) / (yj - yi) + xi
    )
    if (intersect) is_inside <- !is_inside
    i <- i + 1
    j <- i - 1
  }
  return(is_inside)
}

# pt is [x,y] and ring is [[x,y], [x,y],..]
# function inRing(pt, ring) {
#     var isInside = false;
#     for (var i = 0, j = ring.length - 1; i < ring.length; j = i++) {
#         var xi = ring[i][0], yi = ring[i][1];
#         var xj = ring[j][0], yj = ring[j][1];
#         var intersect = ((yi > pt[1]) !== (yj > pt[1])) &&
#           (pt[0] < (xj - xi) * (pt[1] - yi) / (yj - yi) + xi);
#         if (intersect) isInside = !isInside;
#     }
#     return isInside;
# }



# get_coord ------------------------

# obj <- '{
#  "type": "Feature",
#  "geometry": {
#    "type": "Point",
#    "coordinates": [1, 2]
#  },
#  "properties": {}
# }'

# obj <- '{
#   "type": "Point",
#   "coordinates": [1, 2]
# }'
#
# obj <- '[0, 5]'

# invariant.getCoord
# get_coord(obj)
get_coord <- function(obj) {
  if (cchar(jq(obj, "type")) == "array" &&
      cchar(jq(obj, ".[0] | type")) == 'number' &&
      cchar(jq(obj, ".[1] | type")) == 'number') {
    return(obj)
  } else {
    if (cchar(jq(obj, '.type')) == 'Feature' &&
        jb(cchar(jq(obj, 'has("geometry")'))) &&
        cchar(jq(obj, '.geometry.type')) == 'Point' &&
        cchar(jq(obj, '.geometry.coordinates | type')) == "array"
     ) {
      return(cchar(jq(obj, '.geometry.coordinates')))
    } else if (
      cchar(jq(obj, '.type')) == 'Point' &&
      cchar(jq(obj, '.coordinates | type')) == "array"
    ) {
      return(cchar(jq(obj, '.coordinates')))
    }
  }
  #stop('A coordinate, feature, or point geometry is required', call. = FALSE)
}


cchar <- function(x) gsub("\"", "", as.character(x))

jb <- function(x) {
  if (x == "true") {
    TRUE
  } else if (x == "false") {
    FALSE
  } else {
    FALSE
  }
}
