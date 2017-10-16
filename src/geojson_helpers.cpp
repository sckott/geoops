#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

std::string feature(std::string geometry, std::string properties = "{}") {
  auto prop = json::parse(properties);
  auto geom = json::parse(geometry);

  json j;
  j["type"] = "Feature";
  j["properties"] = prop;
  j["geometry"] = geom;
  std::string out = j.dump();
  return out;
};

std::string featureCollection(std::string features) {
  auto feat = json::parse(features);

  json j;
  j["type"] = "FeatureCollection";
  j["features"] = feat;
  std::string out = j.dump();
  return out;
};

// std::string featureCollection2(std::array<> features) {
//   json j;
//   j["type"] = "FeatureCollection";
//   j["features"] = features;
//   std::string out = j.dump();
//   return out;
// };

// [[Rcpp::export]]
std::string point(std::string coordinates, std::string properties = "{}") {
  auto coords = json::parse(coordinates);
  json j;
  j["type"] = "Point";
  j["coordinates"] = coords;
  std::string x = j.dump();
  std::string out = feature(x, properties);
  return out;
};

std::string point_numvec(std::vector<double> coordinates, std::string properties = "{}") {
  json j;
  j["type"] = "Point";
  j["coordinates"] = coordinates;
  std::string x = j.dump();
  std::string out = feature(x, properties);
  return out;
};

std::string polygon_numvec(std::vector< std::vector< std::vector<double> > > coords, std::string properties = "{}") {
  for (unsigned int i = 0; i < coords.size(); i++) {
    json ring = coords[i];
    if (ring.size() < 5) {
      throw std::runtime_error("Each LinearRing of a Polygon must have 4 or more Positions");
    };
    for (unsigned int j = 0; j < ring[ring.size() - 1].size(); j++) {
      if (ring[ring.size() - 1][j] != ring[0][j]) {
        throw std::runtime_error("First and last Position are not equivalent");
      };
    };
  };

  json j;
  j["type"] = "Polygon";
  j["coordinates"] = coords;
  std::string polystr = j.dump();
  std::string out = feature(polystr, properties);
  return out;
};

std::string polygon_numvec2(std::vector< std::vector< std::vector<double> > > coords) {
  for (unsigned int i = 0; i < coords.size(); i++) {
    json ring = coords[i];
    if (ring.size() < 5) {
      throw std::runtime_error("Each LinearRing of a Polygon must have 4 or more Positions");
    };
    for (unsigned int j = 0; j < ring[ring.size() - 1].size(); j++) {
      if (ring[ring.size() - 1][j] != ring[0][j]) {
        throw std::runtime_error("First and last Position are not equivalent");
      };
    };
  };

  json j;
  j["type"] = "Polygon";
  j["coordinates"] = coords;
  std::string out = j.dump();
  return out;
};

std::string polygon(std::vector< std::vector< std::vector<double> > > coordinates, std::string properties = "{}") {
  std::string xx = polygon_numvec2(coordinates);
  std::string out = feature(xx, properties);
  return out;
};

std::vector< std::vector< std::vector<double> > > make_coords(
    std::vector<double> lowLeft,
    std::vector<double> lowRight,
    std::vector<double> topRight,
    std::vector<double> topLeft) {

  std::vector< std::vector< std::vector<double> > > coords = {{
    lowLeft, lowRight, topRight, topLeft, lowLeft
  }};
  return coords;
};

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
  if (unit == 0) {
    throw std::runtime_error("Invalid 'units' input");
  };
  return radians * unit;
}

// Convert a distance measurement from real-world units into radians.
// @param distance (number) distance in real units
// @param units (string) can be degrees, radians, miles, inches, yards,
// metres, meters, kilometres or kilometers (default: kilometers)
// @return {number} radians
double distanceToRadians(double distance, std::string units = "kilometers") {
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
  if (unit == 0) {
    throw std::runtime_error("Invalid 'units' input");
  };
  return distance / unit;
};
