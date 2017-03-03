#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

#include "json.h"
using json = nlohmann::json;

// [[Rcpp::export]]
std::string version() {
  auto ma = json::meta();
  std::string st = ma.dump();
  // List ret;
  // ret["platform"] = ma['platform'];
  return st;
}
