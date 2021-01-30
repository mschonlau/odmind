#' from_target_time_weighted
#'
#' @param out_mat A duration matrix object
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_distance_value A numeric value of minutes
#' @param ors_profile Route profile
#'
#' @return A tibble
#' @export
#'
from_target_time_weighted <- function(out_mat, odm_object, time_distance_value, ors_profile) {
  x <- switch_names(out_mat, odm_object) %>%
    t(.) %>%
    format_results(.) %>%
    dplyr::filter(value <= time_distance_value) %>%
    dplyr::select(target_id, value) %>%
    dplyr::mutate(across(where(is.character), as.numeric)) %>%
    weight_targets_by_time(., ors_profile)
}
