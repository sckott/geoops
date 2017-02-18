#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

#include "json.h"
using json = nlohmann::json;

#include "get_coords.h"

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

  for (int i = 0; i < k["features"].size(); i++) {
    double distanceToPoint = distance(j.dump(), k["features"][i].dump(), "miles");
    if (distanceToPoint < minDist) {
      nearestPoint = k["features"][i].dump();
      minDist = distanceToPoint;
    };
  };
  return nearestPoint;
}

// std::string point(std::string coordinates, std::string properties) {
//   if (!Array.isArray(coordinates)) throw new Error('Coordinates must be an array');
//   if (coordinates.length < 2) throw new Error('Coordinates must be at least 2 numbers long');
//   return feature({
//     type: 'Point',
//     coordinates: coordinates.slice()
//   }, properties);
// };

// double length(coords, units) {
//   double travelled = 0;
//   double prevCoords = point(coords[0]);
//   double curCoords = point(coords[0]);
//   double temp;
//   for (int i = 1; i < coords.length; i++) {
//     curCoords.geometry.coordinates = coords[i];
//     travelled += distance(prevCoords, curCoords, units);
//     temp = prevCoords;
//     prevCoords = curCoords;
//     curCoords = temp;
//   }
//   return travelled;
// };

// std::string lineDistance(std::string line, std::string units) {
//   std::string ln = line;
//   auto lnj = json::parse(ln);
//
//   if (lnj['type'] == "FeatureCollection") {
//     std::reduce(lineDistance, 0)
//     return out;
//   };
//
//   if (lnj['type'] == "Feature") {
//     geometry = lnj['type']
//   } else {
//     geometry = lnj;
//   };
//
//   double d;
//   double i;
//
//   if (geometry['type'] == "LineString") {
//     return length(geometry['coordinates'], units);
//   } else if (geometry['type'] == "Polygon"|| geometry['type'] == "MultiLineString") {
//     double d = 0;
//     for (int i = 0; i < geometry['coordinates'].size(); i++) {
//       d += length(geometry['coordinates'][i], units);
//     };
//     return d;
//   } else if (geometry['type'] == "MultiPolygon") {
//     double d = 0;
//     for (int i = 0; i < geometry['coordinates'].size(); i++) {
//       for (int j = 0; j < geometry['coordinates'][i].size(); j++) {
//         d += length(geometry['coordinates'][i][j], units)
//       };
//     };
//     return d;
//   } else {
//     throw std::runtime_error("input must be a LineString, MultiLineString, Polygon, or MultiPolygon Feature or Geometry (or a FeatureCollection containing only those types)")
//   };
// }

// std::string foobar(std::string line, std::string units) {
//   std::string ln = line;
//   auto lnj = json::parse(ln);
//
//   // if (lnj['type'] == "FeatureCollection") {
//   //   std::reduce(lineDistance, 0)
//   //   return out;
//   // };
//
//   auto geometry = json::empty();
//
//   if (lnj['type'] == "Feature") {
//     auto geometry = lnj['type'];
//   } else {
//     auto geometry = lnj;
//   };
//
//   double d;
//   double i;
//
//   return geometry['coordinates'];
// }
