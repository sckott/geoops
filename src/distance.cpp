#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "geojson_helpers.h"
#include "get_coords.h"

// [[Rcpp::export]]
double distance(std::string start, std::string end, std::string units) {
  const double pie = std::atan(1)*4;
  const double degrees2radians = pie / 180;
  std::string coordinates1 = get_coords(start);
  std::string coordinates2 = get_coords(end);

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

  for (unsigned int i = 0; i < k["features"].size(); i++) {
    double distanceToPoint = distance(j.dump(), k["features"][i].dump(), "miles");
    if (distanceToPoint < minDist) {
      nearestPoint = k["features"][i].dump();
      minDist = distanceToPoint;
    };
  };
  return nearestPoint;
}
