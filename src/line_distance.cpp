#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "geojson_helpers.h"
#include "distance.h"

double length(std::string coords, std::string units) {
  double travelled = 0;
  auto c1 = json::parse(coords);
  std::string prevCoords = point(c1[0].dump(), "{}");
  std::string curCoords = point(c1[0].dump(), "{}");
  auto prevCoordsjson = json::parse(prevCoords);
  auto curCoordsjson = json::parse(curCoords);
  json temp;
  for (unsigned int i = 1; i < c1.size(); i++) {
    curCoordsjson["geometry"]["coordinates"] = c1[i];
    travelled += distance(prevCoordsjson.dump(), curCoordsjson.dump(), units);
    temp = prevCoordsjson;
    prevCoordsjson = curCoordsjson;
    curCoordsjson = temp;
  };
  return travelled;
};

// [[Rcpp::export]]
double lineDistance(std::string line, std::string units) {
  // std::string ln = line;
  auto lnj = json::parse(line);

  // if (lnj['type'].dump() == "\"FeatureCollection\"") {
  //   std::reduce(lineDistance, 0)
  //   return out;
  // };

  json geometry;

  if (lnj["type"].dump() == "\"Feature\"") {
    geometry = lnj["geometry"];
  } else {
    geometry = lnj;
  };

  if (geometry["type"].dump() == "\"LineString\"") {
    return length(geometry["coordinates"].dump(), units);
  } else if (
    geometry["type"].dump() == "\"Polygon\"" ||
    geometry["type"].dump() == "\"MultiLineString\""
  ) {
    double d = 0;
    for (unsigned int i = 0; i < geometry["coordinates"].size(); i++) {
      d += length(geometry["coordinates"][i].dump(), units);
    };
    return d;
  } else if (geometry["type"].dump() == "\"MultiPolygon\"") {
    double d = 0;
    for (unsigned int i = 0; i < geometry["coordinates"].size(); i++) {
      for (unsigned int j = 0; j < geometry["coordinates"][i].size(); j++) {
        d += length(geometry["coordinates"][i][j].dump(), units);
      };
    };
    return d;
  } else {
    throw std::runtime_error("input must be a LineString, MultiLineString, Polygon, or MultiPolygon Feature or Geometry (or a FeatureCollection containing only those types)");
  };
}
