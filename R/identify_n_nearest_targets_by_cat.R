#' identify_n_nearest_targets_by_cat
#'
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param matrix_property A string, "distance" or "duration"
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#' @param n An integer defining the number of minimum values to be
#' extracted
#'
#' @return A tibble with n minimum distances or durations for all features
#' matching the applied filter and average distances or durations for each
#' feature
#' @export
#'
identify_n_nearest_targets_by_cat <- function(odm_object, matrix_property,
                                              target_df, filter_attribute,
                                              filter_value, n) {
  mat <- odm_object[[matrix_property]] %>%
    switch_names(.data, odm_object)
  mat_subset <- filter_odm(mat, target_df, filter_attribute, filter_value)
  dst_mat <- get_n_min_values(mat_subset, n) %>%
    average_n_min_values(.data, n)
}
