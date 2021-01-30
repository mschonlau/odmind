#' format_pot_out_to_target_sf
#'
#' @param sources_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param target_pot_df A tibble with a weighted value of targets for each
#' source id
#'
#' @return sf object of geometry type point
#' @export
#'
format_pot_out_to_target_sf <- function(in_sf, target_pot_df) {
  out_sf <- in_sf %>%
    dplyr::left_join(., target_pot_df, by=c("source_id" = "ID")) %>%
    dplyr::select(source_id, target_pot) %>%
    replace(is.na(.), 0)
}
