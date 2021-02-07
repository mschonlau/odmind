#' apply_threshold
#'
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#' @param threshold_col Name of the threshold value column
#' @param value A numeric threshold value
#'
#' @return sf of geometry type point
#' @noRd
#'
apply_threshold <- function(pnt_sf, threshold_col, value) {
  pnt_sf %>%
    dplyr::mutate(within_threshold = dplyr::case_when(
      !! rlang::sym(threshold_col) <= as.numeric(value) ~ 1,
      TRUE ~ 0)
    )
}
