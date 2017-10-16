#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "get_coords.h"

double wgs84_RADIUS = 6378137;
double wgs84_FLATTENING_DENOM = 298.257223563;
double wgs84_FLATTENING = 1/wgs84_FLATTENING_DENOM;
double wgs84_POLAR_RADIUS = wgs84_RADIUS * (1 - wgs84_FLATTENING);


double rad(double x) {
  const double pie = std::atan(1)*4;
  return x * pie / 180;
};

// Calculate the approximate area of the polygon were it projected onto
// the earth.  Note that this area will be positive if ring is oriented
// clockwise, otherwise it will be negative.
//
// @reference
// Robert. G. Chamberlain and William H. Duquette, "Some Algorithms for
//     Polygons on a Sphere", JPL Publication 07-03, Jet Propulsion
//     Laboratory, Pasadena, CA, June 2007
//     http://trs-new.jpl.nasa.gov/dspace/handle/2014/40409
//
// @return {float} The approximate signed geodesic area of the polygon in
// square meters.
//

// [[Rcpp::export]]
double ringArea(std::string x) {
  json p1;
  json p2;
  json p3;
  int lowerIndex = 0;
  int middleIndex = 0;
  int upperIndex = 0;
  double area = 0;

  auto coords = json::parse(x);
  int n = coords.size();
  double coordsLength = n;

  if (coordsLength > 2) {
    for (int i = 0; i < coordsLength; i++) {
      if (i == coordsLength - 2) {// i = N-2
        lowerIndex = coordsLength - 2;
        middleIndex = coordsLength - 1;
        upperIndex = 0;
      } else if (i == coordsLength - 1) {// i = N-1
        lowerIndex = coordsLength - 1;
        middleIndex = 0;
        upperIndex = 1;
      } else { // i = 0 to N-3
        lowerIndex = i;
        middleIndex = i + 1;
        upperIndex = i + 2;
      };
      p1 = coords[lowerIndex];
      p2 = coords[middleIndex];
      p3 = coords[upperIndex];
      area += (rad(p3[0]) - rad(p1[0])) * std::sin(rad(p2[1]));
    };

    area = area * wgs84_RADIUS * wgs84_RADIUS / 2;
  }

  return area;
}


double polygonArea(std::string coords) {
  double area = 0;

  auto obj = json::parse(coords);
  int n = obj.size();

  if (n > 0) {
    area += std::abs(ringArea(obj[0].dump()));
    for (int i = 1; i < n; i++) {
      area -= std::abs(ringArea(obj[i].dump()));
    };
  };
  return area;
};

// [[Rcpp::export]]
double geometry(std::string x) {
  // create geosjon type map
  std::map<std::string,double> geotypes;
  geotypes["Polygon"] = 1;
  geotypes["MultiPolygon"] = 2;
  geotypes["Point"] = 3;
  geotypes["MultiPoint"] = 4;
  geotypes["LineString"] = 5;
  geotypes["MultiLineString"] = 6;
  geotypes["GeometryCollection"] = 7;

  double area = 0;
  int i;

  auto obj = json::parse(x);

  int tt = geotypes[obj["type"]];
  int coordn = obj["coordinates"].size();
  int objn = obj["geometries"].size();

  switch (tt) {
    case 1:
      return polygonArea(obj["coordinates"].dump());
    case 2:
      for (int i = 0; i < coordn; i++) {
        area += polygonArea(obj["coordinates"][i].dump());
      };
      return area;
    case 3:
    case 4:
    case 5:
    case 6:
      return 0;
    case 7:
      for (i = 0; i < objn; i++) {
        area += geometry(obj["geometries"][i]);
      };
      return area;
    default:
      throw std::runtime_error("Unimplemented GeoJSON type");
  };
};

// [[Rcpp::export]]
double area(std::string inp) {
  auto x = json::parse(inp);

  if (x["type"] == "FeatureCollection") {
    double sum = 0;
    for (unsigned int i = 0; i < x["features"].size(); i++) {
      if (x["features"][i]["geometry"].size() > 0) {
        sum += geometry(x["features"][i]["geometry"].dump());
      };
    };
    return sum;
  } else if (x["type"] == "Feature") {
    return geometry(x["geometry"].dump());
  } else {
    return geometry(x);
  };
};
