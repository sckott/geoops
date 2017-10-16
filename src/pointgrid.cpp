#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "geojson_helpers.h"
#include "distance.h"

// [[Rcpp::export]]
std::string pointGrid(std::vector<double> bbox, double cellSize, std::string units) {
  json fc;
  fc["type"] = "FeatureCollection";

  std::vector<double> v1 = { bbox[0], bbox[1] };
  std::vector<double> v2 = { bbox[2], bbox[1] };
  std::vector<double> v3 = { bbox[0], bbox[3] };
  double xFraction = cellSize / (distance(point_numvec(v1), point_numvec(v2), units));
  double cellWidth = xFraction * (bbox[2] - bbox[0]);
  double yFraction = cellSize / (distance(point_numvec(v1), point_numvec(v3), units));
  double cellHeight = yFraction * (bbox[3] - bbox[1]);

  double currentX = bbox[0];
  while (currentX <= bbox[2]) {
    double currentY = bbox[1];
    while (currentY <= bbox[3]) {
      std::vector<double> v4 = { currentX, currentY };
      std::string res = point_numvec(v4);
      auto res2 = json::parse(res);
      fc["features"].push_back(res2);
      currentY += cellHeight;
    };
    currentX += cellWidth;
  };

  std::string out = fc.dump();

  return out;
};
