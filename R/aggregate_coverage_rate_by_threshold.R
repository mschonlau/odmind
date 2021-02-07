#' aggregate_coverage_rate_by_threshold
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#' @param id_col name of the id column used for grouping operations
#' @param crs epsg code
#' @param threshold_col Name of the threshold value column
#' @param threshold_value A numeric threshold value, minutes or meters
#'
#' @return sf of geometry type polygon including an aggregated coverage rate
#' target potentials
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
