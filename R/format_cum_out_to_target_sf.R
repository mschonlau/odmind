#' format_cum_out_to_target_sf
#'
#' @param sources_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param target_cnt_df A tibble with a count of targets for each source id
#'
#' @return sf object of geometry type point
#' @export
#'
format_cum_out_to_target_sf <- function(sources_sf, target_cnt_df) {
  out_sf <- sources_sf %>%
    dplyr::left_join(., target_cnt_df, by=c("source_id" = "ID")) %>%
    dplyr::select(source_id, target_cnt) %>%
    replace(is.na(.), 0)
}
