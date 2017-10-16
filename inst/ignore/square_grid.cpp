#include <Rcpp.h>
using namespace Rcpp;

#include "json.h"
using json = nlohmann::json;

#include "geojson_helpers.h"
#include "distance.h"

// std::string squareGrid(std::vector<double> bbox, double cellSize, std::string units) {
//   std::string p1 = "[" + std::to_string(bbox[0]) + ", " + std::to_string(bbox[1]) + "]";
//   std::string p2 = "[" + std::to_string(bbox[2]) + ", " + std::to_string(bbox[1]) + "]";
//   std::string p3 = "[" + std::to_string(bbox[0]) + ", " + std::to_string(bbox[3]) + "]";
//   double xFraction = cellSize / (distance(point(p1), point(p2), units));
//   double cellWidth = xFraction * (bbox[2] - bbox[0]);
//   double yFraction = cellSize / (distance(point(p1), point(p3), units));
//   double cellHeight = yFraction * (bbox[3] - bbox[1]);
//
//   // std::vector<std::vector<std::string>> feats;
//   std::vector<std::string> feats;
//   double currentX = bbox[0];
//   while (currentX <= bbox[2]) {
//     double currentY = bbox[1];
//     while (currentY <= bbox[3]) {
//       std::string cxstr = std::to_string(currentX);
//       std::string cystr = std::to_string(currentY);
//       std::string cych = std::to_string(currentY + cellHeight);
//       std::string cxcw = std::to_string(currentX + cellWidth);
//
//       std::string p4 = "[[[" + cxstr + "," + cystr + "], " +
//         "[" + cxstr + "," + cych + "], " +
//         "[" + cxcw + "," + cych + "], " +
//         "[" + cxcw + "," + cystr + "], " +
//         "[" + cxstr + "," + cystr + "]]]";
//       // std::string p4 = "[[" + "[" + std::to_string(currentX) + "," + std::to_string(currentY) + "], " +
//       //   "[" + std::to_string(currentX) + "," + std::to_string(currentY + cellHeight) + "], " +
//       //   "[" + std::to_string(currentX + cellWidth) + "," + std::to_string(currentY + cellHeight) + "], " +
//       //   "[" + std::to_string(currentX + cellWidth) + "," + std::to_string(currentY) + "], " +
//       //   "[" + std::to_string(currentX) + "," + std::to_string(currentY) + "]" +
//       // "]]";
//       std::string cellPoly = polygon(p4);
//       feats.push_back(feature(cellPoly));
//
//       currentY += cellHeight;
//     };
//     currentX += cellWidth;
//   };
//
//   json fc;
//   fc["type"] = "FeatureCollection";
//   fc["features"] = feats;
//   std::string out = fc.dump();
//
//   return out;
// };
