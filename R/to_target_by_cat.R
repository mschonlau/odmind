#' to_target_by_cat
#'
#' @param out_mat A duration or distance matrix object
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_distance_value A numeric value of minutes or meters defining a
#' threshold filter value
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#'
#' @return A tibble with a count of targets for each source id for all features
#' matching the applied filter
#' @export
#'
to_target_by_cat <- function(out_mat, odm_object, time_distance_value,
                             target_df, filter_attribute, filter_value) {
  x <- switch_names(out_mat, odm_object) %>%
    format_results_by_cat(.data, target_df, filter_attribute, filter_value) %>%
    dplyr::filter(.data$value <= time_distance_value) %>%
    count_targets(.data)
}
