#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "distance.h"
#include "destination.h"
#include "bearing.h"

// [[Rcpp::export]]
std::string midpoint(std::string from, std::string to) {
  double dist = distance(from, to, "miles");
  double heading = bearing(from, to);
  std::string midpoint = destination(from, dist / 2, heading, "miles");

  return midpoint;
};
