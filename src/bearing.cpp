#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "get_coords.h"

// [[Rcpp::export]]
double bearing(std::string start, std::string end) {
  const double pie = std::atan(1)*4;
  const double degrees2radians = pie / 180;
  const double radians2degrees = 180 / pie;
  std::string coordinates1 = get_coords(start);
  std::string coordinates2 = get_coords(end);

  auto c1 = json::parse(coordinates1);
  auto c2 = json::parse(coordinates2);
  double c10 = std::stod(c1[0].dump());
  double c11 = std::stod(c1[1].dump());
  double c20 = std::stod(c2[0].dump());
  double c21 = std::stod(c2[1].dump());

  const double lon1 = degrees2radians * c10;
  const double lon2 = degrees2radians * c20;
  const double lat1 = degrees2radians * c11;
  const double lat2 = degrees2radians * c21;

  const double a = sin(lon2 - lon1) * cos(lat2);
  const double b = cos(lat1) * sin(lat2) -
      sin(lat1) * cos(lat2) * cos(lon2 - lon1);

  const double bear = radians2degrees * atan2(a, b);

  return bear;
};
