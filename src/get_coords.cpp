#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

// Checks if coordinates contains a number
bool contains_number(std::string coordinates) {
  auto jj = json::parse(coordinates);
  if (jj.size() > 1 && jj[0].is_number() && jj[1].is_number()) {
    return true;
  }

  if (jj[0].is_array() && jj[0].size()) {
    return contains_number(jj[0].dump());
  }
  throw std::runtime_error("coordinates must only contain numbers");
}

// Checks if coordinates contains a number
std::string check_contain(std::string x) {
  if (contains_number(x)) {
    return x;
  } else {
    throw std::runtime_error("No valid coordinates");
  };
};

// [[Rcpp::export]]
std::string get_coords(std::string x) {
  std::string z = x;
  auto j = json::parse(z);

  std::string out;
  if (j.is_array()) {
    // array
    std::string out = z;
    std::string res = check_contain(out);
    return res;
    // return out;
  } else if (j["coordinates"].is_array()) {
    // geometry object
    std::string out = j["coordinates"].dump();
    std::string res = check_contain(out);
    return res;
  } else if (j["geometry"]["coordinates"].is_array()) {
    // feature
    std::string out = j["geometry"]["coordinates"].dump();
    // return out;
    std::string res = check_contain(out);
    return res;
  } else {
    throw std::runtime_error("No valid coordinates");
  };
};
