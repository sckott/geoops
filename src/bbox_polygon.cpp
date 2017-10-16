#include <Rcpp.h>

#include "geojson_helpers.h"

// [[Rcpp::export]]
std::string bbox_polygon(std::vector<double> bbox) {
  std::vector<double> lowLeft = { bbox[0], bbox[1] };
  std::vector<double> topLeft = { bbox[0], bbox[3] };
  std::vector<double> topRight = { bbox[2], bbox[3] };
  std::vector<double> lowRight = { bbox[2], bbox[1] };

  std::vector< std::vector< std::vector<double> > > bb = {{
    lowLeft, lowRight, topRight, topLeft, lowLeft
  }};
  std::string out = polygon_numvec(bb);
  return out;
};
