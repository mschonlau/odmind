#' to_target
#'
#' @param out_mat A duration or distance matrix object
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices
#' and the source and target locations
#' @param time_distance_value An integer of minutes or meters defining a
#' threshold filter value
#' @param search_direction A character string, "to_target" or "from_target"
#'
#' @return A tibble with a count of targets for each source id
#' @noRd
#'
to_target <- function(out_mat, odm_object, time_distance_value,
                      search_direction) {
  x <- switch_names(out_mat, odm_object, search_direction) %>%
    format_results() %>%
    dplyr::filter(.data$value <= time_distance_value) %>%
    count_targets()
}
