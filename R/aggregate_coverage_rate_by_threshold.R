#' @title aggregate_coverage_rate_by_threshold
#'
#' @description Calculate an average coverage rate within an area of interest
#'     by applying a threshold filter to one of the sf (geometry type point)
#'     attributes \code{"Min_Dist"} or \code{"Min_Time"}. A source location
#'     is defined as covered if a target location is accessible within the
#'     threshold distance or time.
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#' @param id_col name of the id column used for grouping operations
#' @param crs epsg code
#' @param threshold_col Name of the threshold value column, \code{"Min_Dist"}
#'     or \code{"Min_Time"}
#' @param threshold_value A numeric threshold value, minutes or meters
#'
#' @return sf of geometry type polygon including an aggregated coverage rate
#' target potentials
#' @examples
#' data(testdata)
#' pnt_sf <- create_time_distance_sf(odm_object = testdata$od_result)
#' output_sf <- aggregate_coverage_rate_by_threshold(
#'     aoi_sf = testdata$grid_500m,
#'     pnt_sf = pnt_sf,
#'     id_col = "id",
#'     threshold_col = "Min_Dist",
#'     threshold_value = 350,
#'     crs = 4647)
#' @seealso \code{create_time_distance_sf()} to create a suitable sf
#' @export
#'
aggregate_coverage_rate_by_threshold <- function(aoi_sf, pnt_sf, id_col,
                                                 threshold_col,threshold_value,
                                                 crs = 4647) {
  data_list <- read_inputs(aoi_sf, pnt_sf, id_col, crs)
  aoi <- data_list[[1]]
  pnt <- data_list[[2]]
  intermediate_pnts <- apply_threshold(pnt, threshold_col, threshold_value)
  calc_aoi_coverage_rate(aoi, intermediate_pnts, id_col)
}
