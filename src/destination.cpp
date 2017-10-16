#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "geojson_helpers.h"
#include "get_coords.h"

// [[Rcpp::export]]
std::string destination(std::string from, double distance, double bearing, std::string units) {
  const double pie = std::atan(1)*4;
  double degrees2radians = pie / 180;
  double radians2degrees = 180 / pie;
  std::string coordinates1 = get_coords(from);
  auto coords = json::parse(coordinates1);

  double longitude1 = degrees2radians * std::stod(coords[0].dump());
  double latitude1 = degrees2radians * std::stod(coords[1].dump());

  double bearing_rad = degrees2radians * bearing;

  double radians = distanceToRadians(distance, units);

  double latitude2 = std::asin(std::sin(latitude1) * std::cos(radians) +
    std::cos(latitude1) * std::sin(radians) * std::cos(bearing_rad));
  double longitude2 = longitude1 + std::atan2(std::sin(bearing_rad) *
    std::sin(radians) * std::cos(latitude1),
    std::cos(radians) - std::sin(latitude1) * std::sin(latitude2));

  std::string x = std::to_string(radians2degrees * longitude2);
  std::string y = std::to_string(radians2degrees * latitude2);
  std::string pt = "[" + x + ", " + y + "]";
  return point(pt);
};
