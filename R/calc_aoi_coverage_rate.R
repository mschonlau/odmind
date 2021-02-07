#' calc_aoi_coverage_rate
#'
#' @param aoi_sf sf of geometry type polygon used for aggregation
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#' @param id_col name of the id column used for grouping operations
#'
#' @return sf of geometry type polygon including an aggregated coverage rate
#' target potentials
#' @noRd
#'
calc_aoi_coverage_rate <- function(aoi_sf, pnt_sf, id_col) {
  aggregated_values <- aoi_sf %>%
    sf::st_join(pnt_sf, join = sf::st_intersects) %>%
    sf::st_drop_geometry() %>%
    dplyr::group_by(dplyr::across(1)) %>%
    dplyr::mutate(SrcCnt = dplyr::n()) %>%
    dplyr::ungroup() %>%
    dplyr::group_by(dplyr::across(c(1, .data$within_threshold))) %>%
    dplyr::mutate(Shares = dplyr::n() / .data$SrcCnt * 100) %>%
    dplyr::filter(.data$within_threshold == 1L) %>%
    dplyr::group_by(dplyr::across(1)) %>%
    dplyr::summarize(Mean_CoverageRate = mean(.data$Shares, na.rm = TRUE))
  out_sf <- aoi_sf %>%
    dplyr::left_join(aggregated_values) %>%
    replace(is.na(.), 0)
}
utils::globalVariables(c("."))

