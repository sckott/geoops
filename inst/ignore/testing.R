library(Rcpp)

cppFunction(plugins = "cpp11", "
  std::vector< std::vector< std::vector<double> > > cheese() {
    std::vector<double> xx = { 1.4, 4.1 };
    std::vector< std::vector< std::vector<double> > > zz = {{ xx, xx, xx }};
    return zz;
  };
")
cheese()

# double wgs84_RADIUS = 6378137;
# double wgs84_FLATTENING_DENOM = 298.257223563;
# double wgs84_FLATTENING = 1/wgs84_FLATTENING_DENOM;
# double wgs84_POLAR_RADIUS = wgs84_RADIUS * (1 - wgs84_FLATTENING);

cppFunction('
  std::vector foo() {
    std::vector<int> v = {7, 5};
    std::vector<int> w = {7, 5};
    std::vector<std::vector<int>> z = {v, w};
    return z;
  };
')
foo()

cppFunction('
  double foo(std::string y) {
    std::map<std::string,double> xx;
    xx["miles"] = 3960;
    xx["nauticalmiles"] = 3441.145;
    double f = xx[y];
    return f;
  };
')
foo('nauticalmiles')

cppFunction("
  double cheese() {
    return std::vector<double> v(10'000'007, 0.5);
  };
")
cheese()


cppFunction('
  std::string fff(std::string p = "") {
    if (p.size() == 0) {
      std::string f = "cheese";
    } else {
      std::string f = "poo";
    };
    return f;
  };
')

fff('{"a": 5}')


cppFunction('
  std::string fff() {
    std::string x = std::to_string(1.0);
    std::string y = std::to_string(2.0);
    std::string xx = "[" + x + ", " + y + "]";
    return xx;
  };
')
fff()

cppFunction("
            NumericVector exfun(NumericVector x, int i){
            x = x*i;
            return x; }")
exfun(1:5, 3)


cppFunction('
  double stuff(std::string x) {
    std::map<std::string,double> json;
    json["miles"] = 3960;
    json["kilometers"] = 6373;
    json["kilometres"] = 6373;
    json["feet"] = 5;
    return json[x];
  };
')
stuff(x = "feet")

cppFunction('
double radiansToDistance(int radians, std::string units = "kilometers") {
  std::map<std::string,double> factor;
            factor["miles"] = 3960;
            factor["nauticalmiles"] = 3441.145;
            factor["degrees"] = 57.2957795;
            factor["radians"] = 1;
            factor["inches"] = 250905600;
            factor["yards"] = 6969600;
            factor["meters"] = 6373000;
            factor["metres"] = 6373000;
            factor["kilometers"] = 6373;
            factor["kilometres"] = 6373;
            factor["feet"] = 20908792.65;
            double unit = factor[units];
            // if (factor == "\"undefined\"") {
            //   throw std::domain_error("Invalid unit");
            // }
            return radians * unit;
            }
')
radiansToDistance(5)
radiansToDistance(5, 'feet')

cppFunction(plugins = "cpp11", '
    std::string get_coordss(std::string x) {
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
        }
      }
    }

    double radiansToDistance(int radians, std::string units = "kilometers") {
      std::map<std::string,double> factor;
      factor["miles"] = 3960;
      factor["nauticalmiles"] = 3441.145;
      factor["degrees"] = 57.2957795;
      factor["radians"] = 1;
      factor["inches"] = 250905600;
      factor["yards"] = 6969600;
      factor["meters"] = 6373000;
      factor["metres"] = 6373000;
      factor["kilometers"] = 6373;
      factor["kilometres"] = 6373;
      factor["feet"] = 20908792.65;
      double unit = factor[units];
      return radians * unit;
    }

    // [[Rcpp::export]]
    double distance(std::string start, std::string end, std::string units) {
      const double pie = std::atan(1)*4;
      const double degrees2radians = pie / 180;
      std::string coordinates1 = get_coordss(start);
      std::string coordinates2 = get_coordss(end);

      auto c1 = json::parse(coordinates1);
      auto c2 = json::parse(coordinates2);
      double c10 = std::stod(c1[0].dump());
      double c11 = std::stod(c1[1].dump());
      double c20 = std::stod(c2[0].dump());
      double c21 = std::stod(c2[1].dump());

      const double dLat = degrees2radians * (c21 - c11);
      const double dLon = degrees2radians * (c20 - c10);
      const double lat1 = degrees2radians * c11;
      const double lat2 = degrees2radians * c21;

      const double a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);

      const double dist = radiansToDistance(2 * atan2(sqrt(a), sqrt(1 - a)), units);

      return dist;
    }
')


cppFunction('
  double cheese(double a) {
    return atan2(sqrt(a), sqrt(1 - a));
  }
')

cppFunction('
  double cheese2(double a) {
    return 2 * atan2(sqrt(a), sqrt(1 - a));
  }
')
cheese(0.5)
cheese2(0.5)
cheese(0.4)
cheese(0.3)

cppFunction('
  std::string thing(std::string x){
    if (x == "a") {
      throw std::invalid_argument("input must");
    } else {
      return "cheese";
    }
  };
')
thing()

