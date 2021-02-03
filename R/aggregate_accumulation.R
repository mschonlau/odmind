#' aggregate_accumulation
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#' @param id_col name of the id column used for grouping operations
#' @param crs epsg code
#'
#' @return sf of geometry type polygon including aggregated target counts
#' @export
#'
aggregate_accumulation <- function(aoi_sf, pnt_sf, id_col, crs) {
  data_list <- read_inputs(aoi_sf, pnt_sf, id_col, crs)
  aoi <- data_list[[1]]
  pnt <- data_list[[2]]
  calc_aoi_accumulation(aoi, pnt)
}
