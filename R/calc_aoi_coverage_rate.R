#' calc_aoi_coverage_rate
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#' @param id_col name of the id column used for grouping operations
#'
#' @return sf of geometry type polygon including an aggregated coverage rate
#' target potentials
#' @export
#'
calc_aoi_coverage_rate <- function(aoi_sf, pnt_sf, id_col) {
  aggregated_values <- aoi_sf %>%
    sf::st_join(., pnt_sf, join = st_intersects) %>%
    sf::st_set_geometry(., NULL) %>%
    dplyr::group_by({{ id_col }}) %>%
    dplyr::mutate(GebCnt = n()) %>%
    dplyr::ungroup() %>%
    group_by({{ id_col }}, within_threshold) %>%
    dplyr::mutate(Shares = n() / GebCnt * 100) %>%
    dplyr::filter(within_threshold == 1) %>%
    dplyr::group_by({{ id_col }}) %>%
    dplyr::summarize(Mean_CoverageRate = mean(Shares))
  out_sf <- aoi_sf %>%
    dplyr::left_join(., aggregated_values) %>%
    replace(., is.na(.), 0)
}
