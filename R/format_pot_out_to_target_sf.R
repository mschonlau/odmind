#' format_pot_out_to_target_sf
#'
#' @param source_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param target_pot_df A tibble with a weighted value of targets for each
#' source id
#'
#' @return sf object of geometry type point
#' @noRd
#'
format_pot_out_to_target_sf <- function(source_sf, target_pot_df) {
  out_sf <- source_sf %>%
    dplyr::left_join(.data, target_pot_df, by = c("source_id" = "ID")) %>%
    dplyr::select(.data$source_id, .data$target_pot) %>%
    replace(is.na(.data), 0)
}
