#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

#include "json.h"
using json = nlohmann::json;

// [[Rcpp::export]]
String get_coord(String x) {
  std::string z = x;
  auto j = json::parse(z);

  if (j.is_array()) {
    return z;
  } else {
    if ( j["type"].dump() == "\"Feature\"" &&
         j.count("geometry") != 0 &&
         j["geometry"]["type"].dump() == "\"Point\"" &&
         j["geometry"]["coordinates"].is_array()
    ) {
      std::string out = j["geometry"]["coordinates"].dump();
      return out;
    } else if (
        j["type"].dump() == "\"Point\"" &&
          j["coordinates"].is_array()
    ) {
      std::string out = j["coordinates"].dump();
      return out;
    }
  }
}

// [[Rcpp::export]]
bool in_ring(String pt, String ring) {
  std::string pts = pt;
  std::string rings = ring;
  auto ptj = json::parse(pts);
  auto ringj = json::parse(rings);

  bool isInside = false;
  int j = ringj.size() - 1;
  for (int i = 0; i < ringj.size(); j = i++) {
    double xi = ringj[i][0];
    double yi = ringj[i][1];
    double xj = ringj[j][0];
    double yj = ringj[j][1];

    double ptj0 = ptj[0];
    double ptj1 = ptj[1];

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
bool inside_cpp(String point, String polygon) {
  std::string xx = get_coord(point);
  std::string polygons = polygon;
  auto poly = json::parse(polygons);

  json polys = poly["geometry"]["coordinates"];

  // normalize to multipolygon
  if (poly["geometry"]["type"].dump() == "\"Polygon\"") {
    json polysa;
    polysa.push_back(polys);
    json polys = polysa;
    // std::string zz = polys.dump();
    // return zz;
  }

  // std::string vv = polys.dump();
  // return vv;

  bool inside_poly = false;
  for (int i = 0; i < polys.size() && !inside_poly; i++) {
    Rprintf("iterator: %d\n", i);

    // check if it is in the outer ring first
    json fart = polys[0];
    std::string yy = fart[1].dump();
    // Rprintf("%s", yy)
    if (in_ring(xx, yy)) {
      // Rprintf("here");
      bool in_hole = false;
      int k = 1;
      // check for the point in any of the holes
      while (k < polys[i].size() && !in_hole) {
        // Rprintf("fart");
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


// [[Rcpp::export]]
bool fart_cpp(String point, String polygon) {
  std::string xx = get_coord(point);
  std::string polygons = polygon;
  auto poly = json::parse(polygons);

  json polys = poly["geometry"]["coordinates"];

  // normalize to multipolygon
  if (poly["geometry"]["type"].dump() == "\"Polygon\"") {
    json polysa;
    polysa.push_back(polys);
    json polys = polysa;
    // std::string zz = polys.dump();
    // return zz;
  }

  json fart = polys[0];
  bool vv = fart.is_array();
  // std::string vv = fart[0].dump();
  return vv;
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
