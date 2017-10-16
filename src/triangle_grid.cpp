#include <Rcpp.h>

#include "json.h"
using json = nlohmann::json;

#include "get_coords.h"
#include "distance.h"
#include "geojson_helpers.h"

// [[Rcpp::export]]
std::string triangleGrid(std::vector<double> bbox, int cellSize, std::string units) {
  json fc;
  fc["type"] = "FeatureCollection";
  std::vector<double> v1 = { bbox[0], bbox[1] };
  std::vector<double> v2 = { bbox[2], bbox[1] };
  std::vector<double> v3 = { bbox[0], bbox[3] };

  double dist_12 = distance(point_numvec(v1), point_numvec(v2), units);
  double xFraction = cellSize / dist_12;
  double bbox20 = bbox[2] - bbox[0];
  double cellWidth = xFraction * bbox20;

  double dist_13 = distance(point_numvec(v1), point_numvec(v3), units);
  double yFraction = cellSize / dist_13;
  double cellHeight = yFraction * (bbox[3] - bbox[1]);

  int xi = 0;
  double currentX = bbox[0];
  while (currentX <= bbox[2]) {
    int yi = 0;
    double currentY = bbox[1];

    std::vector<double> b1 = { currentX, currentY };
    std::vector<double> b2 = { currentX + cellWidth, currentY + cellHeight };
    std::vector<double> b3 = { currentX + cellWidth, currentY };
    std::vector<double> b4 = { currentX, currentY + cellHeight };

    while (currentY <= bbox[3]) {
      if ((xi % 2) == 0 && (yi % 2) == 0) {
        json p1 = json::parse(polygon(make_coords(b1, b4, b3, b1)));
        json p2 = json::parse(polygon(make_coords(b4, b2, b3, b4)));
        fc["features"].push_back(p1);
        fc["features"].push_back(p2);
      } else if ((xi % 2) == 0 && (yi % 2) == 1) {
        json p1 = json::parse(polygon(make_coords(b1, b2, b3, b1)));
        json p2 = json::parse(polygon(make_coords(b1, b4, b2, b1)));
        fc["features"].push_back(p1);
        fc["features"].push_back(p2);
      } else if ((yi % 2) == 0 && (xi % 2) == 1) {
        json p1 = json::parse(polygon(make_coords(b1, b4, b2, b1)));
        json p2 = json::parse(polygon(make_coords(b1, b2, b3, b1)));
        fc["features"].push_back(p1);
        fc["features"].push_back(p2);
      } else if ((yi % 2) == 1 && (xi % 2) == 1) {
        json p1 = json::parse(polygon(make_coords(b1, b4, b3, b1)));
        json p2 = json::parse(polygon(make_coords(b4, b2, b3, b4)));
        fc["features"].push_back(p1);
        fc["features"].push_back(p2);
      };
      currentY += cellHeight;
      yi++;
    };
    xi++;
    currentX += cellWidth;
  };
  std::string out = fc.dump();
  return out;
};
