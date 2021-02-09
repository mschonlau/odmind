#' from_target_distance_weighted
#'
#' @param out_mat A distance matrix object
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_distance_value A numeric value of meters
#' @param search_direction A character string, "to_target" or "from_target"
#' @param ors_profile Route profile
#'
#' @return A tibble
#' @noRd
#'
from_target_distance_weighted <- function(out_mat, odm_object,
                                          time_distance_value, search_direction,
                                          ors_profile) {
  x <- t(out_mat) %>%
    switch_names(odm_object, search_direction) %>%
    format_results() %>%
    dplyr::filter(.data$value <= time_distance_value) %>%
    dplyr::select(.data$ID, .data$value) %>%
    dplyr::mutate(dplyr::across(where(is.character), as.numeric)) %>%
    weight_targets_by_distance(ors_profile)
}
utils::globalVariables(c("where"))
