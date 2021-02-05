#' from_target_distance_weighted
#'
#' @param out_mat A distance matrix object
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_distance_value A numeric value of meters
#' @param ors_profile Route profile
#'
#' @return A tibble
#' @noRd
#'
from_target_distance_weighted <- function(out_mat, odm_object,
                                          time_distance_value, ors_profile) {
  x <- switch_names(out_mat, odm_object) %>%
    t(.data) %>%
    format_results(.data) %>%
    dplyr::filter(.data$value <= time_distance_value) %>%
    dplyr::select(.data$target_id, .data$value) %>%
    dplyr::mutate(dplyr::across(where(is.character), as.numeric)) %>%
    weight_targets_by_distance(.data, ors_profile)
}
utils::globalVariables(c("where"))
