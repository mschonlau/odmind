#' from_target_by_cat_time_weighted
#'
#' @param out_mat A duration matrix object
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_distance_value A numeric value of minutes
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#' @param search_direction A character string, "to_target" or "from_target"
#' @param ors_profile Route profile
#'
#' @return A tibble
#' @noRd
#'
from_target_by_cat_time_weighted <- function(out_mat, odm_object,
                                             time_distance_value, target_df,
                                             filter_attribute, filter_value,
                                             search_direction, ors_profile) {
  x <- t(out_mat) %>%
    switch_names(odm_object, search_direction) %>%
    format_results_by_cat(
      target_df, filter_attribute, filter_value,
      search_direction
    ) %>%
    dplyr::filter(.data$value <= time_distance_value) %>%
    dplyr::select(.data$ID, .data$value) %>%
    dplyr::mutate(dplyr::across(where(is.character), as.numeric)) %>%
    weight_targets_by_time(ors_profile)
}
utils::globalVariables(c("where"))
