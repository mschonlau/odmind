#' to_target_by_cat_distance_weighted
#'
#' @param out_mat A distance matrix object
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_distance_value A numeric value of meters
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#' @param ors_profile Route profile
#'
#' @return A tibble
#' @export
#'
to_target_by_cat_distance_weighted <- function(out_mat, odm_object, time_distance_value, target_df, filter_attribute, filter_value, ors_profile) {
  x <- switch_names(out_mat, odm_object) %>%
    format_results_by_cat(., target_df, filter_attribute, filter_value) %>%
    dplyr::filter(value <= time_distance_value) %>%
    weight_targets_by_distance(., ors_profile)
}
