#' calc_aoi_accumulation
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#'
#' @return sf of geometry type polygon including aggregated target counts
#' @export
#'
calc_aoi_accumulation <- function(aoi_sf, pnt_sf) {
  aggregated_values <- aoi_sf %>%
    sf::st_join(., pnt_sf, join = st_intersects) %>%
    sf::st_set_geometry(., NULL) %>%
    dplyr::group_by(across(1)) %>%
    dplyr::summarise(MeanCnt = mean(target_cnt),
                     MedianCnt = median(target_cnt))
  out_sf <- aoi_sf %>%
    dplyr::left_join(., aggregated_values) %>%
    replace(., is.na(.), -1)
}
