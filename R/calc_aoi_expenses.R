#' calc_aoi_expenses
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#'
#' @return sf of geometry type polygon including aggregated distance and time
#' values
#' @export
#'
calc_aoi_expenses <- function(aoi_sf, pnt_sf) {
  aggregated_values <- aoi_sf %>%
    sf::st_join(., pnt_sf, join = st_intersects) %>%
    sf::st_set_geometry(., NULL) %>%
    dplyr::group_by(across(1)) %>%
    dplyr::summarise(MedianDist = median(Min_Dist),
                     MedianTime = median(Min_Time))
  out_sf <- aoi_sf %>%
    dplyr::left_join(., aggregated_values) %>%
    replace(., is.na(.), -1)
}
