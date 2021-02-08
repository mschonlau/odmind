#' to_target_time_weighted
#'
#' @param out_mat A duration matrix object
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_distance_value A numeric value of minutes
#' @param search_direction A character string, "to_target" or "from_target"
#' @param ors_profile Route profile
#'
#' @return A tibble
#' @noRd
#'
to_target_time_weighted <- function(out_mat, odm_object, time_distance_value,
                                    search_direction, ors_profile) {
  x <- switch_names(out_mat, odm_object, search_direction) %>%
    format_results() %>%
    dplyr::filter(.data$value <= time_distance_value) %>%
    weight_targets_by_time(ors_profile)
}
