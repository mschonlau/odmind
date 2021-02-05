#' filter_by_time_cum
#'
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_value A numeric value of minutes
#' @param search_direction A character string, "to_target" or "from_target"
#'
#' @return A tibble with a count of sources for each target id or
#' a count of targets for each source id
#' @noRd
#'
filter_by_time_cum <- function(odm_object, time_value, search_direction) {
  if (search_direction == "to_target") {
    x <- odm_object[["duration"]] %>%
      to_target(.data, odm_object, time_value)
  }
  else {
    x <- odm_object[["duration"]] %>%
      from_target(.data, odm_object, time_value)
  }
}
