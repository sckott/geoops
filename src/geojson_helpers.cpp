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

std::string point(std::string coordinates, std::string properties) {
  auto coords = json::parse(coordinates);
  json j;
  j["type"] = "Point";
  j["coordinates"] = coords;
  std::string x = j.dump();
  std::string out = feature(x, properties);
  return out;
};
