#' calc_aoi_potential
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#'
#' @return sf of geometry type polygon including aggregated weighted target
#' potentials
#' @noRd
#'
calc_aoi_potential <- function(aoi_sf, pnt_sf) {
  aggregated_values <- aoi_sf %>%
    sf::st_join(pnt_sf, join = sf::st_intersects) %>%
    sf::st_drop_geometry() %>%
    dplyr::group_by(dplyr::across(1)) %>%
    dplyr::summarise(
      MeanPot = mean(.data$target_pot, na.rm = TRUE),
      MedianPot = stats::median(.data$target_pot, na.rm = TRUE)
    )
  out_sf <- aoi_sf %>%
    dplyr::left_join(aggregated_values)
}
