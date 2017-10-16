#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

// [[Rcpp::export]]
double planepoint(std::string point, std::string triangle) {
  auto pt = json::parse(point);
  auto tr = json::parse(triangle);

  double x = pt["geometry"]["coordinates"][0];
  double y = pt["geometry"]["coordinates"][1];
  double x1 = tr["geometry"]["coordinates"][0][0][0];
  double y1 = tr["geometry"]["coordinates"][0][0][1];
  double z1 = tr["properties"]["a"];
  double x2 = tr["geometry"]["coordinates"][0][1][0];
  double y2 = tr["geometry"]["coordinates"][0][1][1];
  double z2 = tr["properties"]["b"];
  double x3 = tr["geometry"]["coordinates"][0][2][0];
  double y3 = tr["geometry"]["coordinates"][0][2][1];
  double z3 = tr["properties"]["c"];

  double z = (z3 * (x - x1) * (y - y2) + z1 * (x - x2) * (y - y3) +
            z2 * (x - x3) * (y - y1) - z2 * (x - x1) * (y - y3) -
            z3 * (x - x2) * (y - y1) - z1 * (x - x3) * (y - y2)) /
            ((x - x1) * (y - y2) + (x - x2) * (y - y3) + (x - x3) * (y - y1) -
            (x - x1) * (y - y3) - (x - x2) * (y - y1) - (x - x3) * (y - y2));

  return z;
};
