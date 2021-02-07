#' calc_aoi_expenses
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#'
#' @return sf of geometry type polygon including aggregated distance and time
#' values
#' @noRd
#'
calc_aoi_expenses <- function(aoi_sf, pnt_sf) {
  aggregated_values <- aoi_sf %>%
    sf::st_join(pnt_sf, join = sf::st_intersects) %>%
    sf::st_drop_geometry() %>%
    dplyr::group_by(dplyr::across(1)) %>%
    dplyr::summarise(
      MedianDist = stats::median(.data$Min_Dist, na.rm = TRUE),
      MedianTime = stats::median(.data$Min_Time, na.rm = TRUE)
    )
  aoi_sf %>%
    dplyr::left_join(aggregated_values)
}
