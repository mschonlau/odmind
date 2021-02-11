#' @title Aggregate accumulation indicators
#'
#' @description Aggregate the sf (geometry type point) attribute
#'     \code{"MeanCnt"} or \code{"MedianCnt"} to an area of interest
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#' @param id_col name of the id column used for grouping operations
#' @param crs epsg code
#'
#' @return sf of geometry type polygon including aggregated target counts
#' @examples
#' data(testdata)
#' pnt_sf <- create_cumulative_sf(
#'   odm_object = testdata$od_result,
#'   filter_value_type = "distance",
#'   accessibility_filter_value = 750,
#'   search_direction = "to_target"
#' )
#' output_sf <- aggregate_accumulation(
#'   aoi_sf = testdata$grid_500m,
#'   pnt_sf = pnt_sf,
#'   id_col = "id",
#'   crs = 4647
#' )
#' @seealso \code{create_cumulative_sf()} to create a suitable sf
#' @export
#'
aggregate_accumulation <- function(aoi_sf, pnt_sf, id_col, crs = 4647) {
  data_list <- read_inputs(aoi_sf, pnt_sf, id_col, crs)
  aoi <- data_list[[1]]
  pnt <- data_list[[2]]
  calc_aoi_accumulation(aoi, pnt)
}
