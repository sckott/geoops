#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

#include <string>

#include "json.h"
using json = nlohmann::json;

#include "geojson_helpers.h"
#include "get_coords.h"

// Takes a ring and return true or false whether or not the ring is clockwise or counter-clockwise.
// [[Rcpp::export]]
bool boolean_clockwise(std::string line) {
  auto linej = json::parse(line);
  // validation
  std::string type;
  if (linej["geometry"].empty()) {
    std::string type = linej["type"].dump();
  } else {
    std::string type = linej["geometry"]["type"].dump();
  };

  // bool f = linej.is_array();
  // Rprintf("linej.isarray bool: %s", f?"true":"false");
  // std::string typep = std::to_string(type);
  // Rprintf("type value: %s", type);
  // if (!linej.is_array() && type != "\"LineString\"") {
  //   throw std::runtime_error("geometry must be a LineString");
  // };

  std::string ringg = get_coords(line);
  auto ring = json::parse(ringg);
  int sum = 0;
  int i = 1;
  std::vector<double> prev;
  std::vector<double> cur;
  while (i < ring.size()) {
    if (cur.empty()) {
      std::vector<double> prev = ring[0];
    } else {
      std::vector<double> prev = cur;
    };
    std::vector<double> cur = ring[i];
    sum += ((cur[0] - prev[0]) * (cur[1] + prev[1]));
    i++;
  }
  return sum > 0;
};

// [[Rcpp::export]]
std::string boolean_clockwise_type(std::string line) {
  auto linej = json::parse(line);
  // validation
  std::string type;
  if (linej["geometry"].empty()) {
    std::string type = linej["type"].dump();
  } else {
    std::string type = linej["geometry"]["type"].dump();
  };
  return type;
};

// [[Rcpp::export]]
bool boolean_clockwise_bool(std::string line) {
  auto linej = json::parse(line);
  // validation
  std::string type;
  if (linej["geometry"].empty()) {
    std::string type = linej["type"].dump();
  } else {
    std::string type = linej["geometry"]["type"].dump();
  };
  bool f = linej.is_array();
  return f;
};
