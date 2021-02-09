#' format_cum_out_from_target_sf
#'
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param target_cnt_df A tibble with a count of targets for each source id
#'
#' @return sf object of geometry type point
#' @noRd
#' @importFrom rlang .data
#'
format_cum_out_from_target_sf <- function(target_df, target_cnt_df) {
  in_sf <- sf::st_as_sf(target_df, coords = c("x", "y"))
  out_sf <- in_sf %>%
    dplyr::left_join(target_cnt_df, by = c("target_id" = "ID")) %>%
    dplyr::select(.data$target_id, source_cnt = .data$target_cnt) %>%
    replace(is.na(.), 0) %>%
    sf::st_set_crs(4326)
}
