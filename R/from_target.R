#' from_target
#'
#' @param out_mat A duration or distance matrix object
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_distance_value A numeric value of minutes or meters defining a
#' threshold filter value
#' @param search_direction A character string, "to_target" or "from_target"
#'
#' @return A tibble with a count of sources for each target id
#' @noRd
#'
from_target <- function(out_mat, odm_object, time_distance_value,
                        search_direction) {
  x <- t(out_mat) %>%
    switch_names(odm_object, search_direction) %>%
    format_results() %>%
    dplyr::filter(.data$value <= time_distance_value) %>%
    dplyr::select(.data$ID, .data$value) %>%
    dplyr::mutate(dplyr::across(where(is.character), as.numeric)) %>%
    count_targets()
}
utils::globalVariables(c("where"))
