#' identify_nearest_target_by_cat
#'
#' @param odm-object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param matrix_property A string, "distance" or "duration"
#' @param target_df data.frame containing the targets with coordinates
#' in separate x, y columns
#' @param filter_attribute A category column to subset the targets
#' @param filter_value A string with a specific category value
#'
#' @return A tibble with the minimum distance or duration for all features
#' matching the applied filter
#' @export
#'
identify_nearest_target_by_cat <- function(odm_object, matrix_property,
                                            target_df, filter_attribute,
                                            filter_value) {
  mat <- odm_object[[matrix_property]] %>%
    switch_names(., odm_object)
  mat_subset <- filter_odm(mat, target_df, filter_attribute, filter_value)
  dst_mat <- get_min_values(mat_subset)
}
