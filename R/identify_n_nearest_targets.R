#' identify_n_nearest_targets
#'
#' @param odm_object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param matrix_property A string, "distance" or "duration"
#' @param n An integer defining the number of minimum values to be
#' extracted
#'
#' @return A tibble with n minimum distances or durations for each feature and
#' average distances or durations for each feature
#' @noRd
#'
identify_n_nearest_targets <- function(odm_object, matrix_property, n) {
  mat <- odm_object[[matrix_property]] %>%
    switch_names(odm_object)
  dst_mat <- get_n_min_values(mat, n) %>%
    average_n_min_values(n)
}
