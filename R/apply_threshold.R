#' apply_threshold
#'
#' @param pnt_sf sf of geometry type point including attribute to be aggregated
#' @param threshold_col Name of the threshold value column
#' @param value A numeric threshold value
#'
#' @return sf of geometry type point
#' @export
#'
apply_threshold <- function(pnt_sf, threshold_col, value) {
  out_pnts <- pnt_sf %>%
    dplyr::mutate(within_threshold = case_when({{ threshold_col }} <= value ~ 1L,
                                               TRUE ~ 0L))
}
