#' Description of GeoJSON data types
#'
#' @name geojson-types
#'
#' @section GeoJSON object:
#'
#' GeoJSON always consists of a single object. This object (referred to as the
#' GeoJSON object below) represents a geometry, feature, or collection of
#' features.
#'
#' \itemize{
#'  \item The GeoJSON object may have any number of members (name/value pairs).
#'  \item The GeoJSON object must have a member with the name "type". This
#'  member's value is a string that determines the type of the GeoJSON object.
#'  \item The value of the type member must be one of: "Point", "MultiPoint",
#'  "LineString", "MultiLineString", "Polygon", "MultiPolygon",
#'  "GeometryCollection", "Feature", or "FeatureCollection". The case of the
#'  type member values must be as shown here.
#'  \item A GeoJSON object may have an optional "crs" member, the value of
#'  which must be a coordinate reference system object (see 3. Coordinate
#'  Reference System Objects).
#'  \item A GeoJSON object may have a "bbox" member, the value of which must
#'  be a bounding box array (see 4. Bounding Boxes).
#' }
#'
#' @family geo types
NULL
