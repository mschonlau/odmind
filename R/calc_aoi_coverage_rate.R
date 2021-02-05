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
    sf::st_join(.data, pnt_sf, join = sf::st_intersects) %>%
    sf::st_set_geometry(.data, NULL) %>%
    dplyr::group_by({{ id_col }}) %>%
    dplyr::mutate(GebCnt = dplyr::n()) %>%
    dplyr::ungroup() %>%
    dplyr::group_by({{ id_col }}, .data$within_threshold) %>%
    dplyr::mutate(Shares = dplyr::n() / .data$GebCnt * 100) %>%
    dplyr::filter(.data$within_threshold == 1) %>%
    dplyr::group_by({{ id_col }}) %>%
    dplyr::summarize(Mean_CoverageRate = mean(.data$Shares, na.rm = TRUE))
  out_sf <- aoi_sf %>%
    dplyr::left_join(.data, aggregated_values) %>%
    replace(.data, is.na(.data), 0)
}
?n
