#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

#include "json.h"
using json = nlohmann::json;

#include "geojson_helpers.h"
#include "distance.h"

// Precompute cosines and sines of angles used in hexagon creation
// for performance gain
double pi = std::atan(1) * 4;
std::vector<double> cosines;
std::vector<double> sines;

// Center should be [x, y]
// [[Rcpp::export]]
std::string hexagon(std::vector<double> center, double rx, double ry) {
  for (int i = 0; i < 6; i++) {
    double angle = (2 * pi) / (6 * i);
    cosines.push_back(std::cos(angle));
    sines.push_back(std::sin(angle));
  };

  auto vertices = json::array();
  for (int i = 0; i < 6; i++) {
    double x = center[0] + rx * cosines[i];
    double y = center[1] + ry * sines[i];
    vertices.push_back({x, y});
  }
  //first and last vertex must be the same
  vertices.push_back(vertices[0]);
  return polygon({vertices});
};

// Center should be [x, y]
// [[Rcpp::export]]
std::vector< std::vector<double> > hex_triangles(std::vector<double> center, double rx, double ry) {
  double pi = std::atan(1) * 4;
  for (int i = 0; i < 6; i++) {
    double angle = (2 * pi) / (6 * i);
    cosines.push_back(std::cos(angle));
    sines.push_back(std::sin(angle));
  };

  auto triangles = json::array();
  for (int i = 0; i < 6; i++) {
    auto vertices = json::array();
    vertices.push_back(center);
    vertices.push_back({center[0] + rx * cosines[i], center[1] + ry * sines[i]});
    vertices.push_back({center[0] + rx * cosines[(i + 1) % 6], center[1] + ry * sines[(i + 1) % 6]});
    vertices.push_back(center);
    std::string gg = polygon_numvec({vertices});
    auto ggj = json::parse(gg);
    triangles.push_back(ggj);
  }
  return triangles;
};
