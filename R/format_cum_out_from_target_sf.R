#' format_cum_out_from_target_sf
#'
#' @param sources_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param target_cnt_df A tibble with a count of targets for each source id
#'
#' @return sf object of geometry type point
#' @export
#'
format_cum_out_from_target_sf <- function(target_df, target_cnt_df) {
  sources_sf <- sf::st_as_sf(target_df, coords=c("x", "y"))
  out_sf <- sources_sf %>%
    dplyr::left_join(., target_cnt_df, by=c("target_id" = "target_id")) %>%
    dplyr::select(target_id, source_cnt=target_cnt)
}
