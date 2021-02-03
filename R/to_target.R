#' to_target
#'
#' @param out_mat A duration or distance matrix object
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices
#' and the source and target locations
#' @param time_distance_value An integer of minutes or meters defining a
#' threshold filter value
#'
#' @return A tibble with a count of targets for each source id
#' @export
#'
to_target <- function(out_mat, odm_object, time_distance_value) {
  x <- switch_names(out_mat, odm_object) %>%
    format_results(.data) %>%
    dplyr::filter(.data$value <= time_distance_value) %>%
    count_targets(.data)
}
