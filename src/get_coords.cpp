#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

#include "json.h"
using json = nlohmann::json;

// [[Rcpp::export]]
std::string get_coords(std::string x) {
  std::string z = x;
  auto j = json::parse(z);

  if (j.is_array()) {
    return z;
  } else {
    if ( j["type"].dump() == "\"Feature\"" &&
         j.count("geometry") != 0 &&
         j["geometry"]["type"].dump() == "\"Point\"" &&
         j["geometry"]["coordinates"].is_array()
    ) {
      std::string out = j["geometry"]["coordinates"].dump();
      return out;
    } else if (
        j["type"].dump() == "\"Point\"" &&
          j["coordinates"].is_array()
    ) {
      std::string out = j["coordinates"].dump();
      return out;
    } else {
      throw std::runtime_error("get_coords problem ...");
    }
  }
}
