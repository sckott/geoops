#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

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

std::string point(std::string coordinates, std::string properties = "{}") {
  auto coords = json::parse(coordinates);
  json j;
  j["type"] = "Point";
  j["coordinates"] = coords;
  std::string x = j.dump();
  std::string out = feature(x, properties);
  return out;
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
