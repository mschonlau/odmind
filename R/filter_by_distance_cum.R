#' filter_by_distance_cum
#'
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param time_value A numeric value of meters
#' @param search_direction A character string, "to_target" or "from_target"
#'
#' @return A tibble with a count of sources for each target id or
#' a count of targets for each source id
#' @export
#'
filter_by_distance_cum <- function(odm_object, distance_value,
                                   search_direction) {
  if (search_direction == "to_target") {
    x <- odm_object[["distance"]] %>%
      to_target(., odm_object, distance_value)
  }
  else {
    x <- odm_object[["distance"]] %>%
      from_target(., odm_object, distance_value)
  }
}
