#' calc_aoi_accumulation
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#'
#' @return sf of geometry type polygon including aggregated target counts
#' @noRd
#'
calc_aoi_accumulation <- function(aoi_sf, pnt_sf) {
  aggregated_values <- aoi_sf %>%
    sf::st_join(pnt_sf, join = sf::st_intersects) %>%
    sf::st_drop_geometry() %>%
    dplyr::group_by(dplyr::across(1)) %>%
    dplyr::summarise(
      MeanCnt = mean(.data$target_cnt, na.rm = TRUE),
      MedianCnt = stats::median(.data$target_cnt, na.rm = TRUE)
    )
  out_sf <- aoi_sf %>%
    dplyr::left_join(aggregated_values)
}
