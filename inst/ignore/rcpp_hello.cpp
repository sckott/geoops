#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]


#include "json.h"
using json = nlohmann::json;


// [[Rcpp::export]]
List rcpp_hello() {
  CharacterVector x = CharacterVector::create("foo", "bar");
  NumericVector y   = NumericVector::create(0.0, 1.0);
  List z            = List::create(x, y);
  return z;
}

// [[Rcpp::export]]
String rcpp_str(String x) {
  return x;
}

// [[Rcpp::export]]
String rcpp_json() {
  json j = "{ \"happy\": true, \"pi\": 3.141 }"_json;
  std::string s = j.dump();
  return s;
}

// bool rcpp_type(String x) {
//   // auto j = json::parse("{ \"happy\": true, \"pi\": 3.141 }");
//   std::string z = x;
//   auto j = json::parse(z);
//   // std::string s = j["type"].dump();
//   bool s = j.is_array();
//   // std::string s = j.dump();
//   return s;
// }

// List rcpp_bools(String x) {
//   std::string z = x;
//   auto j = json::parse(z);
//
//   bool type_feature = j["type"].dump() == "\"Feature\"";
//   bool geom_exists = j.count("geometry") != 0;
//   bool geom_type_point = j["geometry"]["type"].dump() == "\"Point\"";
//   bool geom_coords_is_array = j["geometry"]["coordinates"].is_array();
//
//   return List::create(type_feature, geom_exists, geom_type_point, geom_coords_is_array);
// }
