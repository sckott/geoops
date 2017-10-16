#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

// [[Rcpp::export]]
std::string version_nlohmann_json() {
  auto ma = json::meta();
  std::string st = ma.dump();
  return st;
}
