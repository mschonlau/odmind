#' filter_by_distance_pot
#'
#' @param odm_object odm-object of type list encompassing duration and distance
#' matrices and the source and target locations
#' @param distance_value A numeric value of meters
#' @param search_direction A character string, "to_target" or "from_target"
#' @param ors_profile Route profile
#'
#' @return A tibble with a weighted value of sources for each target id or
#' a weighted value of targets for each source id
#' @noRd
#'
filter_by_distance_pot <- function(odm_object, distance_value,
                                   search_direction, ors_profile) {
  if (search_direction == "to_target") {
    x <- odm_object[["distance"]] %>%
      to_target_distance_weighted(
        odm_object, distance_value, search_direction, ors_profile
      )
  }
  else {
    x <- odm_object[["distance"]] %>%
      from_target_distance_weighted(
        odm_object, distance_value, search_direction, ors_profile
      )
  }
}
