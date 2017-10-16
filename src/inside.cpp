#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "get_coords.h"

bool in_bbox(std::vector<double> pt, std::vector<double> bbox) {
  bool out = bbox[0] <= pt[0] && bbox[1] <= pt[1] && bbox[2] >= pt[0] && bbox[3] >= pt[1];
  return out;
}

std::vector<double> slicer(std::vector<double> v, int begin, int end) {
  std::vector<double> v1(v.begin() + begin, v.end() - end);
  return v1;
}

// [[Rcpp::export]]
bool in_ring(std::string pt, std::string ring, bool ignoreBoundary = false) {
  std::string pts = pt;
  std::string rings = ring;
  auto ptj = json::parse(pts);
  auto ringj = json::parse(rings);
  bool isInside = false;
  int rsize = ringj.size();
  // if (ring[0][0] == ring[rsize- 1][0] && ring[0][1] == ring[rsize - 1][1]) {
  //   std::vector<double> ring2 = slicer(ring, 0, 1);
  // };
  int j = rsize - 1;
  for (int i = 0; i < rsize; j = i++) {
    double xi = ringj[i][0];
    double yi = ringj[i][1];
    double xj = ringj[j][0];
    double yj = ringj[j][1];

    bool onBoundary = (pt[1] * (xi - xj) + yi * (xj - pt[0]) + yj * (pt[0] - xi) == 0) &&
      ((xi - pt[0]) * (xj - pt[0]) <= 0) && ((yi - pt[1]) * (yj - pt[1]) <= 0);
    if (onBoundary) return !ignoreBoundary;

    double ptj0 = pt[0];
    double ptj1 = pt[1];

    bool yibool = yi > ptj1;
    bool yjbool = yj > ptj1;

    double xjxi = xj - xi;
    double pt1yi = ptj1 - yi;
    double yjyixi = (yj - yi) + xi;

    bool intersect = yibool != yjbool && ptj0 < xjxi * pt1yi / yjyixi;

    if (intersect) isInside = !isInside;
  }
  return isInside;
}

// [[Rcpp::export]]
bool inside_cpp(std::string point, std::string polygon, bool ignoreBoundary) {
  std::string xx = get_coords(point);
  auto xxj = json::parse(xx);
  std::string polygons = polygon;
  auto poly = json::parse(polygons);
  std::vector<double> bbox = poly["bbox"];

  json polys = poly["geometry"]["coordinates"];

  // Quick elimination if point is not inside bbox
  if (in_bbox(xxj, bbox) == false) return false;

  // normalize to multipolygon
  if (poly["geometry"]["type"].dump() == "\"Polygon\"") {
    json polysa;
    polysa.push_back(polys);
    json polys = polysa;
  }

  // std::string vv = polys.dump();
  // return vv;

  bool inside_poly = false;
  for (unsigned int i = 0; i < polys.size() && !inside_poly; i++) {
    Rprintf("iterator: %d\n", i);

    // check if it is in the outer ring first
    json ff = polys[0];
    std::string yy = ff[1].dump();
    // Rprintf("%s", yy)
    if (in_ring(xx, yy)) {
      // Rprintf("here");
      bool in_hole = false;
      unsigned int k = 1;
      // check for the point in any of the holes
      while (k < polys[i].size() && !in_hole) {
        // Rprintf("ff");
        if (in_ring(xx, polys[i][k].dump())) {
          in_hole = true;
        }
        k++;
      }
      if (!in_hole) {
        inside_poly = true;
      }
    }
  }
  return inside_poly;
}


// for (var i = 0, insidePoly = false; i < polys.length && !insidePoly; i++) {
//   // check if it is in the outer ring first
//   if (inRing(pt, polys[i][0])) {
//     var inHole = false;
//     var k = 1;
//     // check for the point in any of the holes
//     while (k < polys[i].length && !inHole) {
//       if (inRing(pt, polys[i][k])) {
//         inHole = true;
//       }
//       k++;
//     }
//     if (!inHole) insidePoly = true;
//   }
// }
// return insidePoly;

// inside <- function(point, polygon) {
//   pt <- get_coord(point)
//   polys <- cchar(jq(polygon, ".geometry.coordinates"))
//
//   # normalize to multipolygon
//   if (cchar(jq(polygon, ".geometry.type")) == 'Polygon') {
//     polys <- sprintf('[%s]', polys)
//   }
//
//   inside_poly <- FALSE
//   i <- 0
//   while (i < cchar(jq(polys, "length")) && !inside_poly) {
//     if (in_ring(pt, jq(polys, sprintf('.[%s][0]', i)))) {
//       in_hole <- FALSE
//       k <- 1
//       # check for the point in any of the holes
//       while (k < jq(polys, sprintf('.[%s] | length', i)) && !in_hole) {
//         if (in_ring(pt, jq(polys, sprintf('.[%s][%s]', i, k)))) {
//           in_hole <- TRUE
//         }
//         k <- k + 1
//       }
//       if (!in_hole) inside_poly <- TRUE
//     }
//     i <- i + 1
//   }
//   return(inside_poly)
// }
