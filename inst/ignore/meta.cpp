#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::plugins(cpp11)]]

#include "json.h"
using json = nlohmann::json;

// template<typename R, typename... A>
// void fun(R f(A...))
// {
//   fun(std::function<R(A...)>(f));
// }
// std::string coordEach(std::string layer, std::function<void()>&& fun, bool excludeWrapCoord) {
//   auto j = json::parse(layer);
//
//   double wrapShrink = 0;
//   double currentIndex = 0;
//   bool isFeatureCollection = (j["type"] == "FeatureCollection");
//   bool isFeature = (j["type"] == "Feature");
//   double stop = (isFeatureCollection) ? j["features"].size() : 1;
//
//   for (int i = 0; i < stop; i++) {
//
//     auto geometryMaybeCollection = (isFeatureCollection) ? j["features"][i]["geometry"] : (isFeature ? j["geometry"] : j);
//
//     bool isGeometryCollection = (geometryMaybeCollection["type"] == "GeometryCollection");
//     double stopG = (isGeometryCollection) ? geometryMaybeCollection["geometries"].size() : 1;
//
//     for (int g = 0; g < stopG; g++) {
//       json geometry = (isGeometryCollection) ? geometryMaybeCollection["geometries"][g] : geometryMaybeCollection;
//       json coords = geometry["coordinates"];
//
//       wrapShrink = (excludeWrapCoord &&
//         (geometry["type"] == "Polygon" || geometry["type"] == "MultiPolygon")) ? 1 : 0;
//
//       if (geometry["type"] == "Point") {
//         fun(coords, currentIndex);
//         currentIndex++;
//       } else if (geometry["type"] == "LineString" ||
//           geometry["type"] == "MultiPoint") {
//
//         for (int k = 0; k < coords.size(); k++) {
//           fun(coords[k], currentIndex);
//           currentIndex++;
//         };
//       } else if (geometry["type"] == "Polygon" ||
//           geometry["type"] == "MultiLineString") {
//
//         for (int k = 0; k < coords.size(); k++) {
//           for (int l = 0; l < coords[k].size() - wrapShrink; l++) {
//             fun(coords[k][l], currentIndex);
//             currentIndex++;
//           };
//         };
//       } else if (geometry["type"] == "MultiPolygon") {
//
//         for (int k = 0; k < coords.size(); k++) {
//           for (int l = 0; l < coords[k].size(); l++) {
//             for (int m = 0; m < coords[k][l].size() - wrapShrink; m++) {
//               fun(coords[k][l][m], currentIndex);
//               currentIndex++;
//             };
//           };
//         };
//       } else if (geometry["type"] == "GeometryCollection") {
//
//         for (int k = 0; k < geometry["geometries"].size(); k++) {
//           coordEach(geometry["geometries"][k], fun, excludeWrapCoord);
//         };
//       } else {
//         throw std::runtime_error("Unknown Geometry Type");
//       };
//     };
//   };
// };
