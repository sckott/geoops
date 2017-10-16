#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "destination.h"
#include "geojson_helpers.h"

// std::string circle(std::string center, double radius, int steps = 64, std::string units = "kilometers") {
//   List co;
//   for (int i = 0; i < steps; i++) {
//     std::string x = destination(center, radius, i * 360 / steps, units);
//     auto xx = json::parse(x);
//     co.push_back(xx["geometry"]["coordinates"]);
//   };
//
//   co.push_back(co[0]);
//   // std::string cx = "[" + std::to_string(co) + "]";
//
//   // std::string out = String.Join(String.empty, co.ToArray());
//
//   return polygon(co);
// };

// List circle2() {
//   List x;
//   std::array<int, 2> y = {4, 5};
//   x.push_back(y);
//   return x;
// };

// [[Rcpp::export]]
std::string circle3() {
  Rcpp::List v;
  v.push_back("a");
  v.push_back("b");
  v.push_back("c");
  std::string ff = std::accumulate(v.begin(), v.end(), "");
  return ff;
};
