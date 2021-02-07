#' format_cum_out_to_target_sf
#'
#' @param sources_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param target_cnt_df A tibble with a count of targets for each source id
#'
#' @return sf object of geometry type point
#' @noRd
#'
format_cum_out_to_target_sf <- function(sources_sf, target_cnt_df) {
  sources_sf %>%
    dplyr::left_join(target_cnt_df, by = c("source_id" = "ID")) %>%
    dplyr::select(.data$source_id, .data$target_cnt) %>%
    replace(is.na(.), 0) %>%
    sf::st_set_crs(4326)
}
utils::globalVariables(c("."))
