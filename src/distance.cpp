#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

#include "json.h"
using json = nlohmann::json;

std::string get_coordss(std::string x) {
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

// Convert a distance measurement from radians to a more friendly unit.
// @param radians (number) distance in radians across the sphere
// @param units (string) can be degrees, radians, miles, inches, yards,
// metres, meters, kilometres or kilometers (default: kilometers)
// @return {number} distance
double radiansToDistance(double radians, std::string units = "kilometers") {
  std::map<std::string,double> factor;
  factor["miles"] = 3960;
  factor["nauticalmiles"] = 3441.145;
  factor["degrees"] = 57.2957795;
  factor["radians"] = 1;
  factor["inches"] = 250905600;
  factor["yards"] = 6969600;
  factor["meters"] = 6373000;
  factor["metres"] = 6373000;
  factor["kilometers"] = 6373;
  factor["kilometres"] = 6373;
  factor["feet"] = 20908792.65;
  double unit = factor[units];
  return radians * unit;
}

// [[Rcpp::export]]
double distance(std::string start, std::string end, std::string units) {
  const double pie = std::atan(1)*4;
  const double degrees2radians = pie / 180;
  std::string coordinates1 = get_coordss(start);
  std::string coordinates2 = get_coordss(end);

  auto c1 = json::parse(coordinates1);
  auto c2 = json::parse(coordinates2);
  double c10 = std::stod(c1[0].dump());
  double c11 = std::stod(c1[1].dump());
  double c20 = std::stod(c2[0].dump());
  double c21 = std::stod(c2[1].dump());

  const double dLat = degrees2radians * (c21 - c11);
  const double dLon = degrees2radians * (c20 - c10);
  const double lat1 = degrees2radians * c11;
  const double lat2 = degrees2radians * c21;

  const double a = pow(sin(dLat / 2), 2) +
    pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);

  const double dist = radiansToDistance(2 * atan2(sqrt(a), sqrt(1 - a)), units);

  return dist;
}

// [[Rcpp::export]]
std::string nearest(std::string target_point, std::string points) {
  std::string nearestPoint;
  double minDist = std::numeric_limits<double>::infinity();

  std::string tp = target_point;
  auto j = json::parse(tp);
  std::string pp = points;
  auto k = json::parse(pp);

  for (int i = 0; i < k["features"].size(); i++) {
    double distanceToPoint = distance(j.dump(), k["features"][i].dump(), "miles");
    if (distanceToPoint < minDist) {
      nearestPoint = k["features"][i].dump();
      minDist = distanceToPoint;
    };
  };
  return nearestPoint;
}
