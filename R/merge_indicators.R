#' @title merge_indicators
#'
#' @description Merge several indicators which have been aggregated to the same
#'     area of interest.
#'
#' @param aoi_sf sf of geometry type polygon with matching geometries for all
#'     indicators to be merged
#' @param id_col Name of the column to merge the indicators
#' @param ... indicators to be merged
#'
#' @return sf of geometry type polygon including the values of all input
#'     indicators
#' @examples
#' \dontrun{
#' data(testdata)
#' merged_sf <- merge_indicators(
#'   aoi_sf = testdata$grid_500m,
#'   id_col = "id",
#'   aggregated_sf_1,
#'   aggregated_sf_2,
#'   aggregated_sf_3,
#'   ...
#' )
#' }
#' @export
#'
merge_indicators <- function(aoi_sf, id_col, ...) {
  indicator_sf_list <- list(...)
  tbl_df_list <-
    lapply(indicator_sf_list, function(x) sf::st_set_geometry(x, NULL))
  merged_tbl_df <- tbl_df_list %>%
    purrr::reduce(dplyr::left_join, by = id_col)
  aoi_sf %>%
    dplyr::left_join(merged_tbl_df)
}
