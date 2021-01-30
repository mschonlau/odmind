#' format_pot_out_from_target_sf
#'
#' @param sources_sf sf object of geometry type point containing the sources
#' with coordinates in separate x, y columns
#' @param target_pot_df A tibble with a weighted value of sources for each
#' target id
#'
#' @return sf object of geometry type point
#' @export
#'
format_pot_out_from_target_sf <- function(target_df, target_pot_df) {
  in_sf <- sf::st_as_sf(target_df, coords=c("x", "y"))
  out_sf <- in_sf %>%
    dplyr::left_join(., target_pot_df, by=c("target_id" = "target_id")) %>%
    dplyr::select(target_id, source_pot = target_pot)
}
