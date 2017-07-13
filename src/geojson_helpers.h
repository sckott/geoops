std::string feature(std::string geometry, std::string properties = "{}");
std::string featureCollection(std::string features);
std::string point(std::string coordinates, std::string properties = "{}");
std::string point_numvec(std::vector<double> coordinates, std::string properties = "{}");
std::string polygon_numvec(std::vector< std::vector< std::vector<double> > > coordinates, std::string properties = "{}");
std::string polygon(std::vector< std::vector< std::vector<double> > > coordinates, std::string properties = "{}");
std::vector< std::vector< std::vector<double> > > make_coords(std::vector<double> lowLeft, std::vector<double> lowRight, std::vector<double> topRight, std::vector<double> topLeft);
double radiansToDistance(double radians, std::string units = "kilometers");
double distanceToRadians(double distance, std::string units = "kilometers");
