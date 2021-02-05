#' identify_nearest_target
#'
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param matrix_property A string, "distance" or "duration"
#'
#' @return A tibble with the minimum distance or duration for each feature
#' @noRd
#' @importFrom rlang .data

identify_nearest_target <- function(odm_object, matrix_property) {
  mat <- odm_object[[matrix_property]] %>%
    switch_names(odm_object)
  get_min_values(mat)
}
